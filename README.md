# Widget/Golden tests example

## Генерация макетов из теста
```bash
flutter test --update-goldens
```

## Генерация макетa для одного теста по пути к файлу
```bash
flutter test --update-goldens <path_to_test_file>
```

## Запуск тестов
```bash
flutter test
```

## Проверить покрытие тестами
1. Installing in Mac `lcov`
```bash
brew install lcov
```
2. Run tests, generate coverage files and convert to HTML
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```
3. Open coverage report in browser
```bash
open coverage/html/index.html
```

## golden-toolkit package

https://pub.dev/packages/golden_toolkit

## Документация

https://docs.flutter.dev/cookbook/testing/widget/introduction
https://api.flutter.dev/flutter/flutter_test/matchesGoldenFile.html

## Статья

https://medium.com/flutter-community/flutter-golden-tests-compare-widgets-with-snapshots-27f83f266cea

https://habr.com/ru/companies/surfstudio/articles/650557/
