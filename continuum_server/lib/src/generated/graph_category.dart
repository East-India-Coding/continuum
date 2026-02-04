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

abstract class GraphCategory
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  GraphCategory._({required this.name});

  factory GraphCategory({required String name}) = _GraphCategoryImpl;

  factory GraphCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return GraphCategory(name: jsonSerialization['name'] as String);
  }

  String name;

  /// Returns a shallow copy of this [GraphCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GraphCategory copyWith({String? name});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GraphCategory',
      'name': name,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GraphCategory',
      'name': name,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GraphCategoryImpl extends GraphCategory {
  _GraphCategoryImpl({required String name}) : super._(name: name);

  /// Returns a shallow copy of this [GraphCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GraphCategory copyWith({String? name}) {
    return GraphCategory(name: name ?? this.name);
  }
}
