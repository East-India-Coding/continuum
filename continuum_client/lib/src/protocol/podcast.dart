/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Podcast implements _i1.SerializableModel {
  Podcast._({
    this.id,
    required this.youtubeUrl,
    required this.userId,
    required this.videoId,
    this.title,
    this.channelName,
    this.thumbnailUrl,
    DateTime? createdAt,
    bool? graphExists,
  }) : createdAt = createdAt ?? DateTime.now(),
       graphExists = graphExists ?? false;

  factory Podcast({
    int? id,
    required String youtubeUrl,
    required String userId,
    required String videoId,
    String? title,
    String? channelName,
    String? thumbnailUrl,
    DateTime? createdAt,
    bool? graphExists,
  }) = _PodcastImpl;

  factory Podcast.fromJson(Map<String, dynamic> jsonSerialization) {
    return Podcast(
      id: jsonSerialization['id'] as int?,
      youtubeUrl: jsonSerialization['youtubeUrl'] as String,
      userId: jsonSerialization['userId'] as String,
      videoId: jsonSerialization['videoId'] as String,
      title: jsonSerialization['title'] as String?,
      channelName: jsonSerialization['channelName'] as String?,
      thumbnailUrl: jsonSerialization['thumbnailUrl'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      graphExists: jsonSerialization['graphExists'] as bool?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String youtubeUrl;

  String userId;

  String videoId;

  String? title;

  String? channelName;

  String? thumbnailUrl;

  DateTime createdAt;

  bool graphExists;

  /// Returns a shallow copy of this [Podcast]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Podcast copyWith({
    int? id,
    String? youtubeUrl,
    String? userId,
    String? videoId,
    String? title,
    String? channelName,
    String? thumbnailUrl,
    DateTime? createdAt,
    bool? graphExists,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Podcast',
      if (id != null) 'id': id,
      'youtubeUrl': youtubeUrl,
      'userId': userId,
      'videoId': videoId,
      if (title != null) 'title': title,
      if (channelName != null) 'channelName': channelName,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      'createdAt': createdAt.toJson(),
      'graphExists': graphExists,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PodcastImpl extends Podcast {
  _PodcastImpl({
    int? id,
    required String youtubeUrl,
    required String userId,
    required String videoId,
    String? title,
    String? channelName,
    String? thumbnailUrl,
    DateTime? createdAt,
    bool? graphExists,
  }) : super._(
         id: id,
         youtubeUrl: youtubeUrl,
         userId: userId,
         videoId: videoId,
         title: title,
         channelName: channelName,
         thumbnailUrl: thumbnailUrl,
         createdAt: createdAt,
         graphExists: graphExists,
       );

  /// Returns a shallow copy of this [Podcast]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Podcast copyWith({
    Object? id = _Undefined,
    String? youtubeUrl,
    String? userId,
    String? videoId,
    Object? title = _Undefined,
    Object? channelName = _Undefined,
    Object? thumbnailUrl = _Undefined,
    DateTime? createdAt,
    bool? graphExists,
  }) {
    return Podcast(
      id: id is int? ? id : this.id,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      userId: userId ?? this.userId,
      videoId: videoId ?? this.videoId,
      title: title is String? ? title : this.title,
      channelName: channelName is String? ? channelName : this.channelName,
      thumbnailUrl: thumbnailUrl is String? ? thumbnailUrl : this.thumbnailUrl,
      createdAt: createdAt ?? this.createdAt,
      graphExists: graphExists ?? this.graphExists,
    );
  }
}
