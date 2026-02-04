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

abstract class TranscriptReference
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  TranscriptReference._({
    required this.quote,
    required this.start,
    required this.end,
  });

  factory TranscriptReference({
    required String quote,
    required int start,
    required int end,
  }) = _TranscriptReferenceImpl;

  factory TranscriptReference.fromJson(Map<String, dynamic> jsonSerialization) {
    return TranscriptReference(
      quote: jsonSerialization['quote'] as String,
      start: jsonSerialization['start'] as int,
      end: jsonSerialization['end'] as int,
    );
  }

  String quote;

  int start;

  int end;

  /// Returns a shallow copy of this [TranscriptReference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TranscriptReference copyWith({
    String? quote,
    int? start,
    int? end,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TranscriptReference',
      'quote': quote,
      'start': start,
      'end': end,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TranscriptReference',
      'quote': quote,
      'start': start,
      'end': end,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TranscriptReferenceImpl extends TranscriptReference {
  _TranscriptReferenceImpl({
    required String quote,
    required int start,
    required int end,
  }) : super._(
         quote: quote,
         start: start,
         end: end,
       );

  /// Returns a shallow copy of this [TranscriptReference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TranscriptReference copyWith({
    String? quote,
    int? start,
    int? end,
  }) {
    return TranscriptReference(
      quote: quote ?? this.quote,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }
}
