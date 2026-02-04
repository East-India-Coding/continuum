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
import 'graph_elements.dart' as _i2;
import 'package:continuum_server/src/generated/protocol.dart' as _i3;

abstract class GraphGranularity
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  GraphGranularity._({
    required this.granularity,
    required this.graph,
  });

  factory GraphGranularity({
    required int granularity,
    required _i2.GraphElements graph,
  }) = _GraphGranularityImpl;

  factory GraphGranularity.fromJson(Map<String, dynamic> jsonSerialization) {
    return GraphGranularity(
      granularity: jsonSerialization['granularity'] as int,
      graph: _i3.Protocol().deserialize<_i2.GraphElements>(
        jsonSerialization['graph'],
      ),
    );
  }

  int granularity;

  _i2.GraphElements graph;

  /// Returns a shallow copy of this [GraphGranularity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GraphGranularity copyWith({
    int? granularity,
    _i2.GraphElements? graph,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GraphGranularity',
      'granularity': granularity,
      'graph': graph.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GraphGranularity',
      'granularity': granularity,
      'graph': graph.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GraphGranularityImpl extends GraphGranularity {
  _GraphGranularityImpl({
    required int granularity,
    required _i2.GraphElements graph,
  }) : super._(
         granularity: granularity,
         graph: graph,
       );

  /// Returns a shallow copy of this [GraphGranularity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GraphGranularity copyWith({
    int? granularity,
    _i2.GraphElements? graph,
  }) {
    return GraphGranularity(
      granularity: granularity ?? this.granularity,
      graph: graph ?? this.graph.copyWith(),
    );
  }
}
