import 'package:flutter_test/flutter_test.dart';
import "package:color_sort/data.dart";

void main() {
  test("Simple A*", () {
    final goal = GameState(const [
      Bottle([ColorLevel(colorIndex: 0, height: 4)]),
      Bottle([ColorLevel(colorIndex: 1, height: 4)]),
      Bottle([]),
    ]);
    final start = GameState(const [
      Bottle([ColorLevel(colorIndex: 0, height: 2), ColorLevel(colorIndex: 1, height: 2)]),
      Bottle([ColorLevel(colorIndex: 0, height: 2), ColorLevel(colorIndex: 1, height: 2)]),
    ]);
    final result = aStar<GameState>(start);
    expect(result, isNotNull, reason: "Could not find path");
    expect(result, equals(goal));
  });
}