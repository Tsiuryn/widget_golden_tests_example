import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:widget_golden_tests_example/bird_calc/bird_calc_page.dart';
import 'package:widget_golden_tests_example/bird_calc/logic.dart';

import 'bird_calc_page_test.mocks.dart';

void main() {
  late MockRandom random;
  late BirdCalc calc;
  late Store store;

  setUp(() {
    random = MockRandom();
    calc = BirdCalc(random);
    store = Store(AppState.initState, calc);
  });
  testGoldens('DeviceBuilder - multiple scenarios - with BirdCalcPage',
      (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        // Device.iphone11,
        // Device.tabletPortrait,
        // Device.tabletLandscape,
      ])
      ..addScenario(
        widget: BirdCalcPage(store: store),
        name: 'default page',
      )
      ..addScenario(
          widget: BirdCalcPage(store: store),
          name: 'tap 25 times',
          onCreate: (scenarioWidgetKey) async {
            final finder = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching:
                  find.byKey(ValueKey(
                      '$BirdCalcPage${BirdType.constant}0')),
            );
            expect(finder, findsOneWidget);
            for (var i = 0; i < 26; ++i) {
              await tester.tap(finder);
            }
          });

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'flutter_demo_page_multiple_scenarios');
  });
}
