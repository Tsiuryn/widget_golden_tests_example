import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:widget_golden_tests_example/bird_calc/bird_calc_page.dart';
import 'package:widget_golden_tests_example/bird_calc/logic.dart';
import 'package:widget_golden_tests_example/main.dart' as app;


void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final constantItemFinder = find.byKey(const Key ('BirdStoreViewBirdType.constant'));
  final randomItemFinder = find.byKey(const Key ('BirdStoreViewBirdType.random'));
  final firstBirdFinder = find.byKey( ValueKey('$BirdCalcPage${BirdType.constant}0'));
  final balanceFinder = find.byKey(const Key ('WalletViewbalance'));

  group('e2e tests', () {
    testWidgets('testing Bird Calculator', (WidgetTester tester) async {
      app.main();

      // Check balance - $0
      await tester.pumpAndSettle();
      final element = balanceFinder.evaluate().first.widget as Text;
      expect(element.data, "\$0");

      //when clicking constant bird then balance increments
      await tester.pumpAndSettle();
      for (var i = 0; i < 24; ++i) {
        await tester.tap(firstBirdFinder);
        await delayed(100);
      }

      // Check balance - $24
      await tester.pumpAndSettle();
      final element2 =  balanceFinder.evaluate().first.widget as Text;
      expect(element2.data, "\$24");

      //when balance less then 24 cannot tap constant bird
      await tester.pumpAndSettle();
      await tester.tap(constantItemFinder);

      // Check balance - $24
      await tester.pumpAndSettle();
      final element3 =  balanceFinder.evaluate().first.widget as Text;
      expect(element3.data, "\$24");

      //when clicking constant bird then balance increments
      await tester.pumpAndSettle();
      for (var i = 0; i < 26; ++i) {
        await tester.tap(firstBirdFinder);
        await delayed(100);
      }

      await tester.pumpAndSettle();
      await tester.tap(randomItemFinder);

      // Check balance - $0
      await tester.pumpAndSettle();
      final element4 =  balanceFinder.evaluate().first.widget as Text;
      expect(element4.data, "\$0");
    });
  });


}

Future<void> delayed(int milliseconds) async{
  await Future.delayed(Duration(milliseconds: milliseconds));
}