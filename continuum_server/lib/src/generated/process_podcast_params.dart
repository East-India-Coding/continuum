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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class ProcessPodcastParams
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ProcessPodcastParams._({
    required this.jobId,
    required this.userId,
    required this.podcastId,
  });

  factory ProcessPodcastParams({
    required int jobId,
    required String userId,
    required int podcastId,
  }) = _ProcessPodcastParamsImpl;

  factory ProcessPodcastParams.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ProcessPodcastParams(
      jobId: jsonSerialization['jobId'] as int,
      userId: jsonSerialization['userId'] as String,
      podcastId: jsonSerialization['podcastId'] as int,
    );
  }

  int jobId;

  String userId;

  int podcastId;

  /// Returns a shallow copy of this [ProcessPodcastParams]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProcessPodcastParams copyWith({
    int? jobId,
    String? userId,
    int? podcastId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProcessPodcastParams',
      'jobId': jobId,
      'userId': userId,
      'podcastId': podcastId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProcessPodcastParams',
      'jobId': jobId,
      'userId': userId,
      'podcastId': podcastId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ProcessPodcastParamsImpl extends ProcessPodcastParams {
  _ProcessPodcastParamsImpl({
    required int jobId,
    required String userId,
    required int podcastId,
  }) : super._(
         jobId: jobId,
         userId: userId,
         podcastId: podcastId,
       );

  /// Returns a shallow copy of this [ProcessPodcastParams]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProcessPodcastParams copyWith({
    int? jobId,
    String? userId,
    int? podcastId,
  }) {
    return ProcessPodcastParams(
      jobId: jobId ?? this.jobId,
      userId: userId ?? this.userId,
      podcastId: podcastId ?? this.podcastId,
    );
  }
}
