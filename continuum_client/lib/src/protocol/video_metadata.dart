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

abstract class VideoMetadata implements _i1.SerializableModel {
  VideoMetadata._({
    required this.youtubeUrl,
    required this.videoId,
    this.title,
    this.channelName,
    this.thumbnailUrl,
  });

  factory VideoMetadata({
    required String youtubeUrl,
    required String videoId,
    String? title,
    String? channelName,
    String? thumbnailUrl,
  }) = _VideoMetadataImpl;

  factory VideoMetadata.fromJson(Map<String, dynamic> jsonSerialization) {
    return VideoMetadata(
      youtubeUrl: jsonSerialization['youtubeUrl'] as String,
      videoId: jsonSerialization['videoId'] as String,
      title: jsonSerialization['title'] as String?,
      channelName: jsonSerialization['channelName'] as String?,
      thumbnailUrl: jsonSerialization['thumbnailUrl'] as String?,
    );
  }

  String youtubeUrl;

  String videoId;

  String? title;

  String? channelName;

  String? thumbnailUrl;

  /// Returns a shallow copy of this [VideoMetadata]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  VideoMetadata copyWith({
    String? youtubeUrl,
    String? videoId,
    String? title,
    String? channelName,
    String? thumbnailUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VideoMetadata',
      'youtubeUrl': youtubeUrl,
      'videoId': videoId,
      if (title != null) 'title': title,
      if (channelName != null) 'channelName': channelName,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VideoMetadataImpl extends VideoMetadata {
  _VideoMetadataImpl({
    required String youtubeUrl,
    required String videoId,
    String? title,
    String? channelName,
    String? thumbnailUrl,
  }) : super._(
         youtubeUrl: youtubeUrl,
         videoId: videoId,
         title: title,
         channelName: channelName,
         thumbnailUrl: thumbnailUrl,
       );

  /// Returns a shallow copy of this [VideoMetadata]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  VideoMetadata copyWith({
    String? youtubeUrl,
    String? videoId,
    Object? title = _Undefined,
    Object? channelName = _Undefined,
    Object? thumbnailUrl = _Undefined,
  }) {
    return VideoMetadata(
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      videoId: videoId ?? this.videoId,
      title: title is String? ? title : this.title,
      channelName: channelName is String? ? channelName : this.channelName,
      thumbnailUrl: thumbnailUrl is String? ? thumbnailUrl : this.thumbnailUrl,
    );
  }
}
