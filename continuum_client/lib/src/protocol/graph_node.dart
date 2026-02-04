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
import 'quote_reference.dart' as _i2;
import 'package:continuum_client/src/protocol/protocol.dart' as _i3;

abstract class GraphNode implements _i1.SerializableModel {
  GraphNode._({
    this.id,
    required this.userId,
    required this.videoId,
    required this.label,
    required this.impactScore,
    required this.summary,
    required this.primarySpeakerId,
    required this.references,
    required this.embedding,
    bool? isBookmarked,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isBookmarked = isBookmarked ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory GraphNode({
    int? id,
    required String userId,
    required String videoId,
    required String label,
    required double impactScore,
    required String summary,
    required int primarySpeakerId,
    required List<_i2.QuoteReference> references,
    required _i1.Vector embedding,
    bool? isBookmarked,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _GraphNodeImpl;

  factory GraphNode.fromJson(Map<String, dynamic> jsonSerialization) {
    return GraphNode(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      videoId: jsonSerialization['videoId'] as String,
      label: jsonSerialization['label'] as String,
      impactScore: (jsonSerialization['impactScore'] as num).toDouble(),
      summary: jsonSerialization['summary'] as String,
      primarySpeakerId: jsonSerialization['primarySpeakerId'] as int,
      references: _i3.Protocol().deserialize<List<_i2.QuoteReference>>(
        jsonSerialization['references'],
      ),
      embedding: _i1.VectorJsonExtension.fromJson(
        jsonSerialization['embedding'],
      ),
      isBookmarked: jsonSerialization['isBookmarked'] as bool?,
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

  String videoId;

  String label;

  double impactScore;

  String summary;

  int primarySpeakerId;

  List<_i2.QuoteReference> references;

  _i1.Vector embedding;

  bool isBookmarked;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [GraphNode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GraphNode copyWith({
    int? id,
    String? userId,
    String? videoId,
    String? label,
    double? impactScore,
    String? summary,
    int? primarySpeakerId,
    List<_i2.QuoteReference>? references,
    _i1.Vector? embedding,
    bool? isBookmarked,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GraphNode',
      if (id != null) 'id': id,
      'userId': userId,
      'videoId': videoId,
      'label': label,
      'impactScore': impactScore,
      'summary': summary,
      'primarySpeakerId': primarySpeakerId,
      'references': references.toJson(valueToJson: (v) => v.toJson()),
      'embedding': embedding.toJson(),
      'isBookmarked': isBookmarked,
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

class _GraphNodeImpl extends GraphNode {
  _GraphNodeImpl({
    int? id,
    required String userId,
    required String videoId,
    required String label,
    required double impactScore,
    required String summary,
    required int primarySpeakerId,
    required List<_i2.QuoteReference> references,
    required _i1.Vector embedding,
    bool? isBookmarked,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         videoId: videoId,
         label: label,
         impactScore: impactScore,
         summary: summary,
         primarySpeakerId: primarySpeakerId,
         references: references,
         embedding: embedding,
         isBookmarked: isBookmarked,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [GraphNode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GraphNode copyWith({
    Object? id = _Undefined,
    String? userId,
    String? videoId,
    String? label,
    double? impactScore,
    String? summary,
    int? primarySpeakerId,
    List<_i2.QuoteReference>? references,
    _i1.Vector? embedding,
    bool? isBookmarked,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GraphNode(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      videoId: videoId ?? this.videoId,
      label: label ?? this.label,
      impactScore: impactScore ?? this.impactScore,
      summary: summary ?? this.summary,
      primarySpeakerId: primarySpeakerId ?? this.primarySpeakerId,
      references:
          references ?? this.references.map((e0) => e0.copyWith()).toList(),
      embedding: embedding ?? this.embedding.clone(),
      isBookmarked: isBookmarked ?? this.isBookmarked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
