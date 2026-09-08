import 'package:flutter_test/flutter_test.dart';
import 'package:tes_mobile_awal/main.dart';

void main() {
  testWidgets('Academic Dashboard tampil', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Dashboard Akademik TRPL'), findsWidgets);
  });
}
