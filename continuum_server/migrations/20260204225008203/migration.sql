BEGIN;

--
-- CREATE VECTOR EXTENSION IF AVAILABLE
--
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_available_extensions WHERE name = 'vector') THEN
    EXECUTE 'CREATE EXTENSION IF NOT EXISTS vector';
  ELSE
    RAISE EXCEPTION 'Required extension "vector" is not available on this instance. Please install pgvector. For instructions, see https://docs.serverpod.dev/upgrading/upgrade-to-pgvector.';
  END IF;
END
$$;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "graph_edge" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "sourceNodeId" bigint NOT NULL,
    "targetNodeId" bigint NOT NULL,
    "weight" double precision NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "graph_node" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "videoId" text NOT NULL,
    "label" text NOT NULL,
    "impactScore" double precision NOT NULL,
    "summary" text NOT NULL,
    "primarySpeakerId" bigint NOT NULL,
    "references" json NOT NULL,
    "embedding" vector(768) NOT NULL,
    "isBookmarked" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "graph_node_idx" ON "graph_node" USING btree ("userId", "videoId", "primarySpeakerId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ingestion_job" (
    "id" bigserial PRIMARY KEY,
    "podcastId" bigint NOT NULL,
    "userId" text NOT NULL,
    "stage" text NOT NULL DEFAULT 'booting up'::text,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "errorMessage" text,
    "progress" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "podcast" (
    "id" bigserial PRIMARY KEY,
    "youtubeUrl" text NOT NULL,
    "userId" text NOT NULL,
    "videoId" text NOT NULL,
    "title" text,
    "channelName" text,
    "thumbnailUrl" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "graphExists" boolean NOT NULL DEFAULT false
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "segmented_transcript" (
    "id" bigserial PRIMARY KEY,
    "videoId" text,
    "ideas" json NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "speaker" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "name" text NOT NULL,
    "normalizedName" text NOT NULL,
    "detectedCount" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "speaker_idx" ON "speaker" USING btree ("userId", "normalizedName");


--
-- MIGRATION VERSION FOR continuum
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('continuum', '20260204225008203', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260204225008203', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260109031533194', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260109031533194', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();


COMMIT;
