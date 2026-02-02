import 'package:continuum/presentation/utils/continuum_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    required this.data,
    required this.value,
    this.loading,
    this.nullException,
    this.nullWidget,
    this.loadingTopPadding,
    super.key,
  });
  final AsyncValue<T?> value;
  final Widget Function(T) data;
  final Widget? loading;
  final Widget? nullWidget;
  final String? nullException;
  final double? loadingTopPadding;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: (resolved) {
        if (resolved == null) {
          if (nullException != null) throw Exception(nullException);
          return nullWidget ?? const SizedBox.shrink();
        }
        return data(resolved);
      },
      error: (e, st) => Center(
        child: Text(
          e.toString(),
          style: const TextStyle(color: ContinuumColors.accent),
        ),
      ),
      loading: () =>
          loading ??
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: loadingTopPadding ?? 0),
              child: const CircularProgressIndicator(),
            ),
          ),
    );
  }
}
