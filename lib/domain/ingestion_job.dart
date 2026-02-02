import 'package:continuum/data/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingestion_job.freezed.dart';
part 'ingestion_job.g.dart';

@freezed
abstract class IngestionJob with _$IngestionJob {
  const factory IngestionJob({
    required String id,
    required String userId,
    required String podcastId,
    required String stage,
    required String status,
    String? errorMessage,
    int? progress,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? completedAt,
  }) = _IngestionJob;

  factory IngestionJob.fromJson(Map<String, Object?> json) =>
      _$IngestionJobFromJson(json);
}
