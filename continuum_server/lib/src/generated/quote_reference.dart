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

abstract class QuoteReference
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  QuoteReference._({
    required this.startTime,
    required this.endTime,
    required this.verbatimQuote,
  });

  factory QuoteReference({
    required int startTime,
    required int endTime,
    required String verbatimQuote,
  }) = _QuoteReferenceImpl;

  factory QuoteReference.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuoteReference(
      startTime: jsonSerialization['startTime'] as int,
      endTime: jsonSerialization['endTime'] as int,
      verbatimQuote: jsonSerialization['verbatimQuote'] as String,
    );
  }

  int startTime;

  int endTime;

  String verbatimQuote;

  /// Returns a shallow copy of this [QuoteReference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuoteReference copyWith({
    int? startTime,
    int? endTime,
    String? verbatimQuote,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuoteReference',
      'startTime': startTime,
      'endTime': endTime,
      'verbatimQuote': verbatimQuote,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuoteReference',
      'startTime': startTime,
      'endTime': endTime,
      'verbatimQuote': verbatimQuote,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _QuoteReferenceImpl extends QuoteReference {
  _QuoteReferenceImpl({
    required int startTime,
    required int endTime,
    required String verbatimQuote,
  }) : super._(
         startTime: startTime,
         endTime: endTime,
         verbatimQuote: verbatimQuote,
       );

  /// Returns a shallow copy of this [QuoteReference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuoteReference copyWith({
    int? startTime,
    int? endTime,
    String? verbatimQuote,
  }) {
    return QuoteReference(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      verbatimQuote: verbatimQuote ?? this.verbatimQuote,
    );
  }
}
