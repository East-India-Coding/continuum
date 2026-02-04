import 'package:flutter/material.dart';
import 'package:continuum_flutter/presentation/widgets/continuum_header.dart';
import 'package:continuum_flutter/presentation/widgets/continuum_sidebar.dart';

class ContinuumLayout extends StatelessWidget {
  const ContinuumLayout({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ContinuumHeader(),
          Expanded(
            child: Row(
              children: [
                const ContinuumSidebar(),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
