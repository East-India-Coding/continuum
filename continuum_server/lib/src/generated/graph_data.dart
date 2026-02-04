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
import 'graph_granularity.dart' as _i2;
import 'package:continuum_server/src/generated/protocol.dart' as _i3;

abstract class GraphData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  GraphData._({required this.graphWithGranularity});

  factory GraphData({
    required List<_i2.GraphGranularity> graphWithGranularity,
  }) = _GraphDataImpl;

  factory GraphData.fromJson(Map<String, dynamic> jsonSerialization) {
    return GraphData(
      graphWithGranularity: _i3.Protocol()
          .deserialize<List<_i2.GraphGranularity>>(
            jsonSerialization['graphWithGranularity'],
          ),
    );
  }

  List<_i2.GraphGranularity> graphWithGranularity;

  /// Returns a shallow copy of this [GraphData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GraphData copyWith({List<_i2.GraphGranularity>? graphWithGranularity});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GraphData',
      'graphWithGranularity': graphWithGranularity.toJson(
        valueToJson: (v) => v.toJson(),
      ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GraphData',
      'graphWithGranularity': graphWithGranularity.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GraphDataImpl extends GraphData {
  _GraphDataImpl({required List<_i2.GraphGranularity> graphWithGranularity})
    : super._(graphWithGranularity: graphWithGranularity);

  /// Returns a shallow copy of this [GraphData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GraphData copyWith({List<_i2.GraphGranularity>? graphWithGranularity}) {
    return GraphData(
      graphWithGranularity:
          graphWithGranularity ??
          this.graphWithGranularity.map((e0) => e0.copyWith()).toList(),
    );
  }
}
