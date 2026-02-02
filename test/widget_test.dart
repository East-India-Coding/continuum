import 'package:continuum/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test', (tester) async {
    await tester.pumpWidget(const MainApp());
  });
}
