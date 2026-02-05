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

abstract class AgentResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AgentResponse._({
    this.thinking,
    this.result,
  });

  factory AgentResponse({
    String? thinking,
    String? result,
  }) = _AgentResponseImpl;

  factory AgentResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return AgentResponse(
      thinking: jsonSerialization['thinking'] as String?,
      result: jsonSerialization['result'] as String?,
    );
  }

  String? thinking;

  String? result;

  /// Returns a shallow copy of this [AgentResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AgentResponse copyWith({
    String? thinking,
    String? result,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AgentResponse',
      if (thinking != null) 'thinking': thinking,
      if (result != null) 'result': result,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AgentResponse',
      if (thinking != null) 'thinking': thinking,
      if (result != null) 'result': result,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AgentResponseImpl extends AgentResponse {
  _AgentResponseImpl({
    String? thinking,
    String? result,
  }) : super._(
         thinking: thinking,
         result: result,
       );

  /// Returns a shallow copy of this [AgentResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AgentResponse copyWith({
    Object? thinking = _Undefined,
    Object? result = _Undefined,
  }) {
    return AgentResponse(
      thinking: thinking is String? ? thinking : this.thinking,
      result: result is String? ? result : this.result,
    );
  }
}
