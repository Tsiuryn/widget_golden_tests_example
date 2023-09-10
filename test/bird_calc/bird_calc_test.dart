import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:widget_golden_tests_example/bird_calc/logic.dart';

import 'bird_calc_page_test.mocks.dart';

void main() {
  late Random random;
  setUp(() {
    random = MockRandom();
  });
  test('when const bird type then transaction is constant', () {
    // arrange
    final random = Random();
    final calc = BirdCalc(random);
    const bird = Bird(BirdType.constant);

    // act
    final result = calc.getTransaction(bird);

    // assert
    expect(result, 1);
  });

  test('when random bird type then transaction is dependant on random', () {
    const minRandomValue = 1;
    const maxRandomValue = 50;
    var time = 0;
    final randomValues = [minRandomValue - 1, 4, 29, maxRandomValue - 1];
    when(random.nextInt(maxRandomValue)).thenAnswer((_) {
      return randomValues[time++];
    });

    final calc = BirdCalc(random);
    const bird = Bird(BirdType.random);
    final expectedResults = [minRandomValue, 5, 30, maxRandomValue];

    for (final value in expectedResults) {
      final result = calc.getTransaction(bird);

      expect(result, value);
    }

    verify(random.nextInt(maxRandomValue)).called(4);
  });

  test('when single combo bird type then transaction is 1', () {
    final random = Random();
    final calc = BirdCalc(random);
    const bird = Bird(BirdType.combo);

    final result = calc.getTransaction(bird, birds: [const Bird(BirdType.combo)]);

    expect(result, 5);
  });

  test('when many combo birds then transaction is bigger each time', () {
    final random = Random();
    final calc = BirdCalc(random);
    const bird = Bird(BirdType.combo);

    var result = calc.getTransaction(bird,
        birds: [const Bird(BirdType.combo), const Bird(BirdType.constant)]);

    expect(result, 5);

    result = calc.getTransaction(bird, birds: [
      const Bird(BirdType.combo),
      const Bird(BirdType.constant),
      const Bird(BirdType.random),
    ]);

    expect(result, 5);

    result = calc.getTransaction(bird, birds: [
      const Bird(BirdType.combo),
      const Bird(BirdType.constant),
      const Bird(BirdType.random),
      const Bird(BirdType.combo),
    ]);

    expect(result, 10);

    result = calc.getTransaction(bird, birds: [
      const Bird(BirdType.combo),
      const Bird(BirdType.constant),
      const Bird(BirdType.random),
      const Bird(BirdType.combo),
      const Bird(BirdType.combo),
    ]);

    expect(result, 15);
  });
}
