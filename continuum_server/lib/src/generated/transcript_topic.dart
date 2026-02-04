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
import 'transcript_reference.dart' as _i2;
import 'package:continuum_server/src/generated/protocol.dart' as _i3;

abstract class TranscriptTopic
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  TranscriptTopic._({
    required this.label,
    required this.summary,
    required this.impactScore,
    required this.primarySpeaker,
    required this.references,
  });

  factory TranscriptTopic({
    required String label,
    required String summary,
    required double impactScore,
    required String primarySpeaker,
    required List<_i2.TranscriptReference> references,
  }) = _TranscriptTopicImpl;

  factory TranscriptTopic.fromJson(Map<String, dynamic> jsonSerialization) {
    return TranscriptTopic(
      label: jsonSerialization['label'] as String,
      summary: jsonSerialization['summary'] as String,
      impactScore: (jsonSerialization['impactScore'] as num).toDouble(),
      primarySpeaker: jsonSerialization['primarySpeaker'] as String,
      references: _i3.Protocol().deserialize<List<_i2.TranscriptReference>>(
        jsonSerialization['references'],
      ),
    );
  }

  String label;

  String summary;

  double impactScore;

  String primarySpeaker;

  List<_i2.TranscriptReference> references;

  /// Returns a shallow copy of this [TranscriptTopic]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TranscriptTopic copyWith({
    String? label,
    String? summary,
    double? impactScore,
    String? primarySpeaker,
    List<_i2.TranscriptReference>? references,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TranscriptTopic',
      'label': label,
      'summary': summary,
      'impactScore': impactScore,
      'primarySpeaker': primarySpeaker,
      'references': references.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TranscriptTopic',
      'label': label,
      'summary': summary,
      'impactScore': impactScore,
      'primarySpeaker': primarySpeaker,
      'references': references.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TranscriptTopicImpl extends TranscriptTopic {
  _TranscriptTopicImpl({
    required String label,
    required String summary,
    required double impactScore,
    required String primarySpeaker,
    required List<_i2.TranscriptReference> references,
  }) : super._(
         label: label,
         summary: summary,
         impactScore: impactScore,
         primarySpeaker: primarySpeaker,
         references: references,
       );

  /// Returns a shallow copy of this [TranscriptTopic]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TranscriptTopic copyWith({
    String? label,
    String? summary,
    double? impactScore,
    String? primarySpeaker,
    List<_i2.TranscriptReference>? references,
  }) {
    return TranscriptTopic(
      label: label ?? this.label,
      summary: summary ?? this.summary,
      impactScore: impactScore ?? this.impactScore,
      primarySpeaker: primarySpeaker ?? this.primarySpeaker,
      references:
          references ?? this.references.map((e0) => e0.copyWith()).toList(),
    );
  }
}
