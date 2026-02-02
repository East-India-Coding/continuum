import 'package:freezed_annotation/freezed_annotation.dart';

part 'graph_data.freezed.dart';
part 'graph_data.g.dart';

@freezed
abstract class GraphData with _$GraphData {
  const factory GraphData({
    required List<GraphWithGranularity> graphWithGranularity,
  }) = _GraphData;

  factory GraphData.fromJson(Map<String, Object?> json) =>
      _$GraphDataFromJson(json);
}

@freezed
abstract class GraphWithGranularity with _$GraphWithGranularity {
  const factory GraphWithGranularity({
    required int granularity,
    required GraphElements graph,
  }) = _GraphWithGranularity;

  factory GraphWithGranularity.fromJson(Map<String, Object?> json) =>
      _$GraphWithGranularityFromJson(json);
}

@freezed
abstract class GraphElements with _$GraphElements {
  const factory GraphElements({
    required List<GraphCategory> categories,
    required List<GraphNodeDisplay> nodes,
    required List<GraphLinkDisplay> links,
  }) = _GraphElements;

  factory GraphElements.fromJson(Map<String, Object?> json) =>
      _$GraphElementsFromJson(json);
}

@freezed
abstract class GraphCategory with _$GraphCategory {
  const factory GraphCategory({
    required String name,
  }) = _GraphCategory;

  factory GraphCategory.fromJson(Map<String, Object?> json) =>
      _$GraphCategoryFromJson(json);
}

@freezed
abstract class GraphNodeDisplay with _$GraphNodeDisplay {
  const factory GraphNodeDisplay({
    required String name,
    required double value,
    required int category,
    required double symbolSize,
    required String nodeId,
    required String videoId,
    required String summary,
    required String primarySpeakerId,
    required List<QuoteReference> references,
    required bool isBookmarked,
  }) = _GraphNodeDisplayImpl;

  factory GraphNodeDisplay.fromJson(Map<String, Object?> json) =>
      _$GraphNodeDisplayFromJson(json);
}

@freezed
abstract class GraphLinkDisplay with _$GraphLinkDisplay {
  const factory GraphLinkDisplay({
    required int source,
    required int target,
  }) = _GraphLinkDisplayImpl;

  factory GraphLinkDisplay.fromJson(Map<String, Object?> json) =>
      _$GraphLinkDisplayFromJson(json);
}

@freezed
abstract class QuoteReference with _$QuoteReference {
  const factory QuoteReference({
    required int startTime,
    required int endTime,
    required String verbatimQuote,
  }) = _QuoteReferenceImpl;

  factory QuoteReference.fromJson(Map<String, Object?> json) =>
      _$QuoteReferenceFromJson(json);
}
