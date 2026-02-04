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

abstract class GraphLinkDisplay implements _i1.SerializableModel {
  GraphLinkDisplay._({
    required this.source,
    required this.target,
  });

  factory GraphLinkDisplay({
    required int source,
    required int target,
  }) = _GraphLinkDisplayImpl;

  factory GraphLinkDisplay.fromJson(Map<String, dynamic> jsonSerialization) {
    return GraphLinkDisplay(
      source: jsonSerialization['source'] as int,
      target: jsonSerialization['target'] as int,
    );
  }

  int source;

  int target;

  /// Returns a shallow copy of this [GraphLinkDisplay]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GraphLinkDisplay copyWith({
    int? source,
    int? target,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GraphLinkDisplay',
      'source': source,
      'target': target,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GraphLinkDisplayImpl extends GraphLinkDisplay {
  _GraphLinkDisplayImpl({
    required int source,
    required int target,
  }) : super._(
         source: source,
         target: target,
       );

  /// Returns a shallow copy of this [GraphLinkDisplay]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GraphLinkDisplay copyWith({
    int? source,
    int? target,
  }) {
    return GraphLinkDisplay(
      source: source ?? this.source,
      target: target ?? this.target,
    );
  }
}
