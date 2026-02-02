import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:ui_web';

import 'package:flutter/cupertino.dart';
import 'package:graphify/src/controller/implements/web.dart';
import 'package:graphify/src/controller/js_methods.dart';
import 'package:graphify/src/resources/dependencies.js.dart';
import 'package:graphify/src/resources/index.html.dart';
import 'package:graphify/src/view/_interface.dart' as g_view;
import 'package:web/web.dart';

const _chartDependencyId = 'graphify-chart-dependency';

class GraphifyView extends g_view.GraphifyView {
  const GraphifyView({
    super.key,
    super.controller,
    super.initialOptions,
    super.onConsoleMessage,
    super.onCreated,
    super.onChartClick,
  });

  @override
  State<StatefulWidget> createState() => _GraphifyViewState();
}

class _GraphifyViewState extends g_view.GraphifyViewState<GraphifyView> {
  late final controller = widget.controller ?? GraphifyController();

  String get uid => controller.uid;

  @override
  void initView() {
    initChartDependencies();
    registerEventHandlers();
    platformViewRegistry.registerViewFactory(
      uid,
      createHTMLIFrameElement,
    );
  }

  void registerEventHandlers() {
    // Register event handlers on the window object so they can be called from iframe
    if (widget.onChartClick != null) {
      (window as JSObject).setProperty(
        JsMethods.onChartClick.toJS,
        ((JSString chartId, JSString eventDataJson) {
          final chartIdStr = chartId.toDart;
          final data = jsonDecode(eventDataJson.toDart) as Map<String, dynamic>;
          widget.onChartClick!(chartIdStr, data);
        }).toJS,
      );
    }
  }

  @override
  Widget buildView() {
    widget.onCreated?.call();
    return view = HtmlElementView(viewType: uid);
  }

  HTMLIFrameElement createHTMLIFrameElement(_) {
    final iframe = HTMLIFrameElement()
      ..id = 'graphify_$uid'
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.border = 'none'
      ..srcdoc = indexHtml(id: uid).toJS
      ..onLoad.listen((_) => controller.update(widget.initialOptions))
      ..onError.listen(widget.onConsoleMessage);

    return iframe;
  }

  void initChartDependencies() {
    final document = window.document;
    final dependencyScripts = document.querySelector("#$_chartDependencyId");

    if (dependencyScripts == null) {
      final scriptElement = HTMLScriptElement()
        ..id = _chartDependencyId
        ..innerHTML = dependencies.toJS;

      final dom = window.document;
      final body = dom.documentElement?.children.item(1);

      body?.append(scriptElement);
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }
}
