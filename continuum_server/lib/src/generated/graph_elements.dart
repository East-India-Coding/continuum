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
import 'graph_category.dart' as _i2;
import 'graph_node_display.dart' as _i3;
import 'graph_link_display.dart' as _i4;
import 'package:continuum_server/src/generated/protocol.dart' as _i5;

abstract class GraphElements
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  GraphElements._({
    required this.categories,
    required this.nodes,
    required this.links,
  });

  factory GraphElements({
    required List<_i2.GraphCategory> categories,
    required List<_i3.GraphNodeDisplay> nodes,
    required List<_i4.GraphLinkDisplay> links,
  }) = _GraphElementsImpl;

  factory GraphElements.fromJson(Map<String, dynamic> jsonSerialization) {
    return GraphElements(
      categories: _i5.Protocol().deserialize<List<_i2.GraphCategory>>(
        jsonSerialization['categories'],
      ),
      nodes: _i5.Protocol().deserialize<List<_i3.GraphNodeDisplay>>(
        jsonSerialization['nodes'],
      ),
      links: _i5.Protocol().deserialize<List<_i4.GraphLinkDisplay>>(
        jsonSerialization['links'],
      ),
    );
  }

  List<_i2.GraphCategory> categories;

  List<_i3.GraphNodeDisplay> nodes;

  List<_i4.GraphLinkDisplay> links;

  /// Returns a shallow copy of this [GraphElements]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GraphElements copyWith({
    List<_i2.GraphCategory>? categories,
    List<_i3.GraphNodeDisplay>? nodes,
    List<_i4.GraphLinkDisplay>? links,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GraphElements',
      'categories': categories.toJson(valueToJson: (v) => v.toJson()),
      'nodes': nodes.toJson(valueToJson: (v) => v.toJson()),
      'links': links.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GraphElements',
      'categories': categories.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'nodes': nodes.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'links': links.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GraphElementsImpl extends GraphElements {
  _GraphElementsImpl({
    required List<_i2.GraphCategory> categories,
    required List<_i3.GraphNodeDisplay> nodes,
    required List<_i4.GraphLinkDisplay> links,
  }) : super._(
         categories: categories,
         nodes: nodes,
         links: links,
       );

  /// Returns a shallow copy of this [GraphElements]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GraphElements copyWith({
    List<_i2.GraphCategory>? categories,
    List<_i3.GraphNodeDisplay>? nodes,
    List<_i4.GraphLinkDisplay>? links,
  }) {
    return GraphElements(
      categories:
          categories ?? this.categories.map((e0) => e0.copyWith()).toList(),
      nodes: nodes ?? this.nodes.map((e0) => e0.copyWith()).toList(),
      links: links ?? this.links.map((e0) => e0.copyWith()).toList(),
    );
  }
}
