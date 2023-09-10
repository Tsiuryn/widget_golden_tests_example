import 'dart:async';
import 'dart:math';

class Bird {
  final BirdType type;

  const Bird(this.type);
}

class BirdItem {
  final BirdType type;
  final int price;

  const BirdItem({required this.type, required this.price});
}

enum BirdType {
  constant,
  random,
  combo,
}

class BirdCalc {
  static const _minRandomValue = 1;
  static const _maxRandomValue = 50;

  final Random random;

  const BirdCalc(this.random);

  int getTransaction(Bird bird, {List<Bird> birds = const []}) {
    switch (bird.type) {
      case BirdType.constant:
        return 1;
      case BirdType.random:
        return random.nextInt(_maxRandomValue) + _minRandomValue;
      case BirdType.combo:
        return 5 * birds.where((bird) => bird.type == BirdType.combo).length;
    }
  }
}

class AppState {
  static const AppState initState = AppState(
    balance: 0,
    birds: [Bird(BirdType.constant)],
    items: [
      BirdItem(type: BirdType.constant, price: 50),
      BirdItem(type: BirdType.random, price: 100),
      BirdItem(type: BirdType.combo, price: 150),
    ],
  );

  final int balance;
  final List<Bird> birds;
  final List<BirdItem> items;

  const AppState({
    this.balance = 0,
    this.birds = const [],
    this.items = const [],
  });

  AppState copyWith({
    int? balance,
    List<Bird>? birds,
    List<BirdItem>? items,
  }) {
    return AppState(
      balance: balance ?? this.balance,
      birds: birds ?? this.birds,
      items: items ?? this.items,
    );
  }
}

class Store {
  AppState state;
  final _controller = StreamController<AppState>.broadcast();
  final BirdCalc calc;

  Stream<AppState> get changes => _controller.stream;

  Store(this.state, this.calc);

  void buyBird(BirdItem item) {
    final newBirds = [...state.birds];
    newBirds.add(Bird(item.type));
    final newBalance = state.balance - item.price;
    state = state.copyWith(balance: newBalance, birds: newBirds);
    _controller.add(state);
  }

  void earn(Bird bird) {
    final earned = calc.getTransaction(bird, birds: state.birds);
    final newBalance = state.balance + earned;
    state = state.copyWith(balance: newBalance);
    _controller.add(state);
  }
}
