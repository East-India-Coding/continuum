import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:graphify/src/controller/interface.dart';
import 'package:graphify/src/view/console_message.dart';

/// Callback for chart events (click, hover, etc.)
/// Receives the chart ID and event data
typedef OnChartEvent = void Function(
    String chartId, Map<String, dynamic> eventData);

abstract class GraphifyView extends StatefulWidget {
  const GraphifyView({
    super.key,
    this.controller,
    this.initialOptions,
    this.onConsoleMessage,
    this.onCreated,
    this.onChartClick,
  });

  final GraphifyController? controller;

  final Map<String, dynamic>? initialOptions;

  final OnConsoleMessage? onConsoleMessage;

  final VoidCallback? onCreated;

  /// Called when a chart element (node or edge) is clicked
  final OnChartEvent? onChartClick;

  @override
  State<StatefulWidget> createState();
}

abstract class GraphifyViewState<T extends GraphifyView> extends State<T> {
  late Widget view;

  @nonVirtual
  @override
  void initState() {
    super.initState();
    initView();
    buildView();
  }

  @nonVirtual
  @override
  Widget build(BuildContext context) => view;

  Widget buildView();

  void initView();
}
