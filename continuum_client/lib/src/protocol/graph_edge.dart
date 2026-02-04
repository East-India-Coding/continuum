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

abstract class GraphEdge implements _i1.SerializableModel {
  GraphEdge._({
    this.id,
    required this.userId,
    required this.sourceNodeId,
    required this.targetNodeId,
    required this.weight,
  });

  factory GraphEdge({
    int? id,
    required String userId,
    required int sourceNodeId,
    required int targetNodeId,
    required double weight,
  }) = _GraphEdgeImpl;

  factory GraphEdge.fromJson(Map<String, dynamic> jsonSerialization) {
    return GraphEdge(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      sourceNodeId: jsonSerialization['sourceNodeId'] as int,
      targetNodeId: jsonSerialization['targetNodeId'] as int,
      weight: (jsonSerialization['weight'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String userId;

  int sourceNodeId;

  int targetNodeId;

  double weight;

  /// Returns a shallow copy of this [GraphEdge]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GraphEdge copyWith({
    int? id,
    String? userId,
    int? sourceNodeId,
    int? targetNodeId,
    double? weight,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GraphEdge',
      if (id != null) 'id': id,
      'userId': userId,
      'sourceNodeId': sourceNodeId,
      'targetNodeId': targetNodeId,
      'weight': weight,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GraphEdgeImpl extends GraphEdge {
  _GraphEdgeImpl({
    int? id,
    required String userId,
    required int sourceNodeId,
    required int targetNodeId,
    required double weight,
  }) : super._(
         id: id,
         userId: userId,
         sourceNodeId: sourceNodeId,
         targetNodeId: targetNodeId,
         weight: weight,
       );

  /// Returns a shallow copy of this [GraphEdge]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GraphEdge copyWith({
    Object? id = _Undefined,
    String? userId,
    int? sourceNodeId,
    int? targetNodeId,
    double? weight,
  }) {
    return GraphEdge(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      sourceNodeId: sourceNodeId ?? this.sourceNodeId,
      targetNodeId: targetNodeId ?? this.targetNodeId,
      weight: weight ?? this.weight,
    );
  }
}
