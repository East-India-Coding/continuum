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

abstract class Speaker implements _i1.SerializableModel {
  Speaker._({
    this.id,
    required this.userId,
    required this.name,
    required this.normalizedName,
    required this.detectedCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Speaker({
    int? id,
    required String userId,
    required String name,
    required String normalizedName,
    required int detectedCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SpeakerImpl;

  factory Speaker.fromJson(Map<String, dynamic> jsonSerialization) {
    return Speaker(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      name: jsonSerialization['name'] as String,
      normalizedName: jsonSerialization['normalizedName'] as String,
      detectedCount: jsonSerialization['detectedCount'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String userId;

  String name;

  String normalizedName;

  int detectedCount;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Speaker]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Speaker copyWith({
    int? id,
    String? userId,
    String? name,
    String? normalizedName,
    int? detectedCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Speaker',
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'normalizedName': normalizedName,
      'detectedCount': detectedCount,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpeakerImpl extends Speaker {
  _SpeakerImpl({
    int? id,
    required String userId,
    required String name,
    required String normalizedName,
    required int detectedCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         name: name,
         normalizedName: normalizedName,
         detectedCount: detectedCount,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Speaker]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Speaker copyWith({
    Object? id = _Undefined,
    String? userId,
    String? name,
    String? normalizedName,
    int? detectedCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Speaker(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      normalizedName: normalizedName ?? this.normalizedName,
      detectedCount: detectedCount ?? this.detectedCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
