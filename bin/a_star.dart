// ignore_for_file: avoid_print
import "package:color_sort/data.dart";

void main() {
  final start = GameState(numColors: 2, bottles: [
    Bottle([0, 0, 1, 1]),
    Bottle([1, 1, 0, 0]),
    Bottle([]),
  ],);
  start.finalize();
  print("Starting...");
  final result = aStar<GameState>(start);
  if (result == null) {
    print("Error: Could not solve puzzle");
    return;
  } else if (!result.isGoal()) {
    print("Error: Got the following state: ${result.hashed}");
    return;
  }
  final path = result.reconstructPath();
  print("Path to solution:");
  for (final transition in path) {
    print("  $transition");
  }
  print("Solution: ${result.hashed}");
}
