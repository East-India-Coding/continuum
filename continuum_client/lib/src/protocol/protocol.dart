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
import 'graph_category.dart' as _i2;
import 'graph_data.dart' as _i3;
import 'graph_edge.dart' as _i4;
import 'graph_elements.dart' as _i5;
import 'graph_granularity.dart' as _i6;
import 'graph_link_display.dart' as _i7;
import 'graph_node.dart' as _i8;
import 'graph_node_display.dart' as _i9;
import 'ingestion_job.dart' as _i10;
import 'podcast.dart' as _i11;
import 'process_podcast_params.dart' as _i12;
import 'quote_reference.dart' as _i13;
import 'segmented_transcript.dart' as _i14;
import 'speaker.dart' as _i15;
import 'transcript_reference.dart' as _i16;
import 'transcript_topic.dart' as _i17;
import 'video_metadata.dart' as _i18;
import 'package:continuum_client/src/protocol/speaker.dart' as _i19;
import 'package:continuum_client/src/protocol/graph_node.dart' as _i20;
import 'package:continuum_client/src/protocol/podcast.dart' as _i21;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i22;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i23;
export 'graph_category.dart';
export 'graph_data.dart';
export 'graph_edge.dart';
export 'graph_elements.dart';
export 'graph_granularity.dart';
export 'graph_link_display.dart';
export 'graph_node.dart';
export 'graph_node_display.dart';
export 'ingestion_job.dart';
export 'podcast.dart';
export 'process_podcast_params.dart';
export 'quote_reference.dart';
export 'segmented_transcript.dart';
export 'speaker.dart';
export 'transcript_reference.dart';
export 'transcript_topic.dart';
export 'video_metadata.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.GraphCategory) {
      return _i2.GraphCategory.fromJson(data) as T;
    }
    if (t == _i3.GraphData) {
      return _i3.GraphData.fromJson(data) as T;
    }
    if (t == _i4.GraphEdge) {
      return _i4.GraphEdge.fromJson(data) as T;
    }
    if (t == _i5.GraphElements) {
      return _i5.GraphElements.fromJson(data) as T;
    }
    if (t == _i6.GraphGranularity) {
      return _i6.GraphGranularity.fromJson(data) as T;
    }
    if (t == _i7.GraphLinkDisplay) {
      return _i7.GraphLinkDisplay.fromJson(data) as T;
    }
    if (t == _i8.GraphNode) {
      return _i8.GraphNode.fromJson(data) as T;
    }
    if (t == _i9.GraphNodeDisplay) {
      return _i9.GraphNodeDisplay.fromJson(data) as T;
    }
    if (t == _i10.IngestionJob) {
      return _i10.IngestionJob.fromJson(data) as T;
    }
    if (t == _i11.Podcast) {
      return _i11.Podcast.fromJson(data) as T;
    }
    if (t == _i12.ProcessPodcastParams) {
      return _i12.ProcessPodcastParams.fromJson(data) as T;
    }
    if (t == _i13.QuoteReference) {
      return _i13.QuoteReference.fromJson(data) as T;
    }
    if (t == _i14.SegmentedTranscript) {
      return _i14.SegmentedTranscript.fromJson(data) as T;
    }
    if (t == _i15.Speaker) {
      return _i15.Speaker.fromJson(data) as T;
    }
    if (t == _i16.TranscriptReference) {
      return _i16.TranscriptReference.fromJson(data) as T;
    }
    if (t == _i17.TranscriptTopic) {
      return _i17.TranscriptTopic.fromJson(data) as T;
    }
    if (t == _i18.VideoMetadata) {
      return _i18.VideoMetadata.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.GraphCategory?>()) {
      return (data != null ? _i2.GraphCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.GraphData?>()) {
      return (data != null ? _i3.GraphData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.GraphEdge?>()) {
      return (data != null ? _i4.GraphEdge.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.GraphElements?>()) {
      return (data != null ? _i5.GraphElements.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.GraphGranularity?>()) {
      return (data != null ? _i6.GraphGranularity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.GraphLinkDisplay?>()) {
      return (data != null ? _i7.GraphLinkDisplay.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.GraphNode?>()) {
      return (data != null ? _i8.GraphNode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.GraphNodeDisplay?>()) {
      return (data != null ? _i9.GraphNodeDisplay.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.IngestionJob?>()) {
      return (data != null ? _i10.IngestionJob.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Podcast?>()) {
      return (data != null ? _i11.Podcast.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.ProcessPodcastParams?>()) {
      return (data != null ? _i12.ProcessPodcastParams.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.QuoteReference?>()) {
      return (data != null ? _i13.QuoteReference.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.SegmentedTranscript?>()) {
      return (data != null ? _i14.SegmentedTranscript.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.Speaker?>()) {
      return (data != null ? _i15.Speaker.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.TranscriptReference?>()) {
      return (data != null ? _i16.TranscriptReference.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.TranscriptTopic?>()) {
      return (data != null ? _i17.TranscriptTopic.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.VideoMetadata?>()) {
      return (data != null ? _i18.VideoMetadata.fromJson(data) : null) as T;
    }
    if (t == List<_i6.GraphGranularity>) {
      return (data as List)
              .map((e) => deserialize<_i6.GraphGranularity>(e))
              .toList()
          as T;
    }
    if (t == List<_i2.GraphCategory>) {
      return (data as List)
              .map((e) => deserialize<_i2.GraphCategory>(e))
              .toList()
          as T;
    }
    if (t == List<_i9.GraphNodeDisplay>) {
      return (data as List)
              .map((e) => deserialize<_i9.GraphNodeDisplay>(e))
              .toList()
          as T;
    }
    if (t == List<_i7.GraphLinkDisplay>) {
      return (data as List)
              .map((e) => deserialize<_i7.GraphLinkDisplay>(e))
              .toList()
          as T;
    }
    if (t == List<_i13.QuoteReference>) {
      return (data as List)
              .map((e) => deserialize<_i13.QuoteReference>(e))
              .toList()
          as T;
    }
    if (t == List<_i17.TranscriptTopic>) {
      return (data as List)
              .map((e) => deserialize<_i17.TranscriptTopic>(e))
              .toList()
          as T;
    }
    if (t == List<_i16.TranscriptReference>) {
      return (data as List)
              .map((e) => deserialize<_i16.TranscriptReference>(e))
              .toList()
          as T;
    }
    if (t == List<_i19.Speaker>) {
      return (data as List).map((e) => deserialize<_i19.Speaker>(e)).toList()
          as T;
    }
    if (t == List<_i20.GraphNode>) {
      return (data as List).map((e) => deserialize<_i20.GraphNode>(e)).toList()
          as T;
    }
    if (t == List<_i21.Podcast>) {
      return (data as List).map((e) => deserialize<_i21.Podcast>(e)).toList()
          as T;
    }
    try {
      return _i22.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i23.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.GraphCategory => 'GraphCategory',
      _i3.GraphData => 'GraphData',
      _i4.GraphEdge => 'GraphEdge',
      _i5.GraphElements => 'GraphElements',
      _i6.GraphGranularity => 'GraphGranularity',
      _i7.GraphLinkDisplay => 'GraphLinkDisplay',
      _i8.GraphNode => 'GraphNode',
      _i9.GraphNodeDisplay => 'GraphNodeDisplay',
      _i10.IngestionJob => 'IngestionJob',
      _i11.Podcast => 'Podcast',
      _i12.ProcessPodcastParams => 'ProcessPodcastParams',
      _i13.QuoteReference => 'QuoteReference',
      _i14.SegmentedTranscript => 'SegmentedTranscript',
      _i15.Speaker => 'Speaker',
      _i16.TranscriptReference => 'TranscriptReference',
      _i17.TranscriptTopic => 'TranscriptTopic',
      _i18.VideoMetadata => 'VideoMetadata',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('continuum.', '');
    }

    switch (data) {
      case _i2.GraphCategory():
        return 'GraphCategory';
      case _i3.GraphData():
        return 'GraphData';
      case _i4.GraphEdge():
        return 'GraphEdge';
      case _i5.GraphElements():
        return 'GraphElements';
      case _i6.GraphGranularity():
        return 'GraphGranularity';
      case _i7.GraphLinkDisplay():
        return 'GraphLinkDisplay';
      case _i8.GraphNode():
        return 'GraphNode';
      case _i9.GraphNodeDisplay():
        return 'GraphNodeDisplay';
      case _i10.IngestionJob():
        return 'IngestionJob';
      case _i11.Podcast():
        return 'Podcast';
      case _i12.ProcessPodcastParams():
        return 'ProcessPodcastParams';
      case _i13.QuoteReference():
        return 'QuoteReference';
      case _i14.SegmentedTranscript():
        return 'SegmentedTranscript';
      case _i15.Speaker():
        return 'Speaker';
      case _i16.TranscriptReference():
        return 'TranscriptReference';
      case _i17.TranscriptTopic():
        return 'TranscriptTopic';
      case _i18.VideoMetadata():
        return 'VideoMetadata';
    }
    className = _i22.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i23.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'GraphCategory') {
      return deserialize<_i2.GraphCategory>(data['data']);
    }
    if (dataClassName == 'GraphData') {
      return deserialize<_i3.GraphData>(data['data']);
    }
    if (dataClassName == 'GraphEdge') {
      return deserialize<_i4.GraphEdge>(data['data']);
    }
    if (dataClassName == 'GraphElements') {
      return deserialize<_i5.GraphElements>(data['data']);
    }
    if (dataClassName == 'GraphGranularity') {
      return deserialize<_i6.GraphGranularity>(data['data']);
    }
    if (dataClassName == 'GraphLinkDisplay') {
      return deserialize<_i7.GraphLinkDisplay>(data['data']);
    }
    if (dataClassName == 'GraphNode') {
      return deserialize<_i8.GraphNode>(data['data']);
    }
    if (dataClassName == 'GraphNodeDisplay') {
      return deserialize<_i9.GraphNodeDisplay>(data['data']);
    }
    if (dataClassName == 'IngestionJob') {
      return deserialize<_i10.IngestionJob>(data['data']);
    }
    if (dataClassName == 'Podcast') {
      return deserialize<_i11.Podcast>(data['data']);
    }
    if (dataClassName == 'ProcessPodcastParams') {
      return deserialize<_i12.ProcessPodcastParams>(data['data']);
    }
    if (dataClassName == 'QuoteReference') {
      return deserialize<_i13.QuoteReference>(data['data']);
    }
    if (dataClassName == 'SegmentedTranscript') {
      return deserialize<_i14.SegmentedTranscript>(data['data']);
    }
    if (dataClassName == 'Speaker') {
      return deserialize<_i15.Speaker>(data['data']);
    }
    if (dataClassName == 'TranscriptReference') {
      return deserialize<_i16.TranscriptReference>(data['data']);
    }
    if (dataClassName == 'TranscriptTopic') {
      return deserialize<_i17.TranscriptTopic>(data['data']);
    }
    if (dataClassName == 'VideoMetadata') {
      return deserialize<_i18.VideoMetadata>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i22.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i23.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i22.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i23.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
