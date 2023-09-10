import 'package:flutter_test/flutter_test.dart';
import 'package:widget_golden_tests_example/main.dart';


void main(){
  testWidgets('Golden test MyApp', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await expectLater(find.byType(MyApp),
        matchesGoldenFile('goldens/bird_calc_page.png'));
  });
}