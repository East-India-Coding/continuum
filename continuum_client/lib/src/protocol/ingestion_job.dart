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

abstract class IngestionJob implements _i1.SerializableModel {
  IngestionJob._({
    this.id,
    required this.podcastId,
    required this.userId,
    String? stage,
    String? status,
    this.errorMessage,
    int? progress,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.completedAt,
  }) : stage = stage ?? 'booting up',
       status = status ?? 'pending',
       progress = progress ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory IngestionJob({
    int? id,
    required int podcastId,
    required String userId,
    String? stage,
    String? status,
    String? errorMessage,
    int? progress,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
  }) = _IngestionJobImpl;

  factory IngestionJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return IngestionJob(
      id: jsonSerialization['id'] as int?,
      podcastId: jsonSerialization['podcastId'] as int,
      userId: jsonSerialization['userId'] as String,
      stage: jsonSerialization['stage'] as String?,
      status: jsonSerialization['status'] as String?,
      errorMessage: jsonSerialization['errorMessage'] as String?,
      progress: jsonSerialization['progress'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int podcastId;

  String userId;

  String stage;

  String status;

  String? errorMessage;

  int progress;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? completedAt;

  /// Returns a shallow copy of this [IngestionJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  IngestionJob copyWith({
    int? id,
    int? podcastId,
    String? userId,
    String? stage,
    String? status,
    String? errorMessage,
    int? progress,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IngestionJob',
      if (id != null) 'id': id,
      'podcastId': podcastId,
      'userId': userId,
      'stage': stage,
      'status': status,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'progress': progress,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IngestionJobImpl extends IngestionJob {
  _IngestionJobImpl({
    int? id,
    required int podcastId,
    required String userId,
    String? stage,
    String? status,
    String? errorMessage,
    int? progress,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
  }) : super._(
         id: id,
         podcastId: podcastId,
         userId: userId,
         stage: stage,
         status: status,
         errorMessage: errorMessage,
         progress: progress,
         createdAt: createdAt,
         updatedAt: updatedAt,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [IngestionJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  IngestionJob copyWith({
    Object? id = _Undefined,
    int? podcastId,
    String? userId,
    String? stage,
    String? status,
    Object? errorMessage = _Undefined,
    int? progress,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? completedAt = _Undefined,
  }) {
    return IngestionJob(
      id: id is int? ? id : this.id,
      podcastId: podcastId ?? this.podcastId,
      userId: userId ?? this.userId,
      stage: stage ?? this.stage,
      status: status ?? this.status,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      progress: progress ?? this.progress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}
