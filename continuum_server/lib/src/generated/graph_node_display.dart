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
import 'quote_reference.dart' as _i2;
import 'package:continuum_server/src/generated/protocol.dart' as _i3;

abstract class GraphNodeDisplay
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  GraphNodeDisplay._({
    required this.name,
    required this.value,
    required this.category,
    required this.symbolSize,
    required this.nodeId,
    required this.videoId,
    required this.summary,
    required this.primarySpeakerId,
    required this.references,
    required this.isBookmarked,
  });

  factory GraphNodeDisplay({
    required String name,
    required double value,
    required int category,
    required double symbolSize,
    required int nodeId,
    required String videoId,
    required String summary,
    required int primarySpeakerId,
    required List<_i2.QuoteReference> references,
    required bool isBookmarked,
  }) = _GraphNodeDisplayImpl;

  factory GraphNodeDisplay.fromJson(Map<String, dynamic> jsonSerialization) {
    return GraphNodeDisplay(
      name: jsonSerialization['name'] as String,
      value: (jsonSerialization['value'] as num).toDouble(),
      category: jsonSerialization['category'] as int,
      symbolSize: (jsonSerialization['symbolSize'] as num).toDouble(),
      nodeId: jsonSerialization['nodeId'] as int,
      videoId: jsonSerialization['videoId'] as String,
      summary: jsonSerialization['summary'] as String,
      primarySpeakerId: jsonSerialization['primarySpeakerId'] as int,
      references: _i3.Protocol().deserialize<List<_i2.QuoteReference>>(
        jsonSerialization['references'],
      ),
      isBookmarked: jsonSerialization['isBookmarked'] as bool,
    );
  }

  String name;

  double value;

  int category;

  double symbolSize;

  int nodeId;

  String videoId;

  String summary;

  int primarySpeakerId;

  List<_i2.QuoteReference> references;

  bool isBookmarked;

  /// Returns a shallow copy of this [GraphNodeDisplay]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GraphNodeDisplay copyWith({
    String? name,
    double? value,
    int? category,
    double? symbolSize,
    int? nodeId,
    String? videoId,
    String? summary,
    int? primarySpeakerId,
    List<_i2.QuoteReference>? references,
    bool? isBookmarked,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GraphNodeDisplay',
      'name': name,
      'value': value,
      'category': category,
      'symbolSize': symbolSize,
      'nodeId': nodeId,
      'videoId': videoId,
      'summary': summary,
      'primarySpeakerId': primarySpeakerId,
      'references': references.toJson(valueToJson: (v) => v.toJson()),
      'isBookmarked': isBookmarked,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GraphNodeDisplay',
      'name': name,
      'value': value,
      'category': category,
      'symbolSize': symbolSize,
      'nodeId': nodeId,
      'videoId': videoId,
      'summary': summary,
      'primarySpeakerId': primarySpeakerId,
      'references': references.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'isBookmarked': isBookmarked,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GraphNodeDisplayImpl extends GraphNodeDisplay {
  _GraphNodeDisplayImpl({
    required String name,
    required double value,
    required int category,
    required double symbolSize,
    required int nodeId,
    required String videoId,
    required String summary,
    required int primarySpeakerId,
    required List<_i2.QuoteReference> references,
    required bool isBookmarked,
  }) : super._(
         name: name,
         value: value,
         category: category,
         symbolSize: symbolSize,
         nodeId: nodeId,
         videoId: videoId,
         summary: summary,
         primarySpeakerId: primarySpeakerId,
         references: references,
         isBookmarked: isBookmarked,
       );

  /// Returns a shallow copy of this [GraphNodeDisplay]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GraphNodeDisplay copyWith({
    String? name,
    double? value,
    int? category,
    double? symbolSize,
    int? nodeId,
    String? videoId,
    String? summary,
    int? primarySpeakerId,
    List<_i2.QuoteReference>? references,
    bool? isBookmarked,
  }) {
    return GraphNodeDisplay(
      name: name ?? this.name,
      value: value ?? this.value,
      category: category ?? this.category,
      symbolSize: symbolSize ?? this.symbolSize,
      nodeId: nodeId ?? this.nodeId,
      videoId: videoId ?? this.videoId,
      summary: summary ?? this.summary,
      primarySpeakerId: primarySpeakerId ?? this.primarySpeakerId,
      references:
          references ?? this.references.map((e0) => e0.copyWith()).toList(),
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}
