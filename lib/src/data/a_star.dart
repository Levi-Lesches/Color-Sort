import "dart:collection";
import "package:collection/collection.dart";

class AStarTransition<T extends AStarState<T>> {
  final T parent;
  AStarTransition(this.parent);
}

abstract class AStarState<T extends AStarState<T>> {
  late final int heuristic;
  late final String hashed;

  bool _isFinalized = false;
  AStarTransition<T>? transition;
  int depth = 0;
  int get score => depth + heuristic;
  
  String hash();
  bool isGoal();
  int calculateHeuristic();
  Iterable<T> getNeighbors();

  AStarState({required this.transition});

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => hashed.hashCode;

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) => other is AStarState<T> 
    && other.hashed == hashed;

  void finalize() {
    heuristic = calculateHeuristic();
    hashed = hash();
    _isFinalized = true;
  }

  Queue<AStarTransition<T>> reconstructPath() {
    final path = Queue<AStarTransition<T>>();
    var current = transition;
    while (current != null) {
      path.addFirst(current);
      current = current.parent.transition;
    }
    return path;
  }

  @override
  String toString() => hashed;
}

class AStarTimeout implements Exception { }

T? aStar<T extends AStarState<T>>(T start, {bool verbose = false, int limit = 1000}) {
  if (!start._isFinalized) throw StateError("Starting state was not finalized");
  final opened = <T>{};
  final closed = <T>{};
  final open = PriorityQueue<T>(
    (a, b) => a.score.compareTo(b.score),
  );

  open.add(start);
  opened.add(start);
  var count = 0;
  
  while (open.isNotEmpty) {
    if (count++ >= limit) {
      // ignore: avoid_print
      if (verbose) print("ABORT: Hit A* limit");
      return null;
    }
    final node = open.removeFirst();
    // ignore: avoid_print
    if (verbose) print("[$count] Exploring: ${node.hashed}");
    opened.remove(node.hashed);
    closed.add(node);
    if (node.isGoal()) {
      return node;
    }
    for (final neighbor in node.getNeighbors()) {
      if (count++ >= limit) {
        
        // ignore: avoid_print
        if (verbose) print("ABORT: Hit A* limit");
        return null;
      }
      if (closed.contains(neighbor)) continue;
      if (opened.contains(neighbor)) continue;
      // ignore: avoid_print
      if (verbose) print("[$count]   Got: ${neighbor.hashed}");
      neighbor.depth = node.depth + 1;
      open.add(neighbor);
      opened.add(neighbor);
    }
  }
  return null;
}
