import "package:color_sort/data.dart";

class GameTransition extends AStarTransition<GameState> {
  final int from;
  final int to;
  final int amount;
  GameTransition(super.parent, {required this.from, required this.to, required this.amount});

  @override
  String toString() => "Pour bottle ${from + 1} to bottle ${to + 1}";
}

class GameState extends AStarState<GameState> {
  final List<Bottle> bottles;
  final int numColors;

  GameState({required this.bottles, required this.numColors}) : super(transition: null);

  GameState.copy(GameState other, {super.transition}) : 
    numColors = other.numColors,
    bottles = [
      for (final bottle in other.bottles) 
        bottle.copy(),
    ];

  factory GameState.level(int level) {
    final numColors = (level ~/ 5 + 2).clamp(2, 10);
    final colors = [
      for (var color = 0; color < numColors; color++)
        for (var i = 0; i < 4; i++) 
          color,
    ];
    colors.shuffle();
    final bottles = [
      for (int i = 0; i < colors.length; i += 4) 
        Bottle(colors.sublist(i, i + 4)),
      // Extra bottles
      Bottle([]),
      Bottle([]),
    ];
    
    return GameState(
      numColors: numColors, 
      bottles: bottles,
    );
  }

  @override
  String hash() => [
    for (final bottle in bottles) 
      bottle.hash,
  ].join("|");

  // For an actual win:
  // @override
  // int calculateHeuristic() {
  //   var result = 0;
  //   for (final bottle in bottles) {
  //     result += bottle.colors.length;
  //   }
  //   var numEmpty = 0;
  //   for (final bottle in bottles) {
  //     if (bottle.isEmpty) numEmpty++;
  //   }
  //   return result - numColors - (numEmpty * 5);
  // }

  @override
  int calculateHeuristic() => [
    for (final bottle in bottles) 
      bottle.height,
  ].max();

  @override
  Iterable<GameState> getNeighbors() sync* {
    for (final (index, bottle) in bottles.enumerate) {
      for (final (otherIndex, otherBottle) in bottles.enumerate) {
        if (index == otherIndex) continue;
        if (!bottle.canPour(otherBottle)) continue;
        final copyState = GameState.copy(this);
        final amount = copyState.pour(index, otherIndex);
        final transition = GameTransition(this, from: index, to: otherIndex, amount: amount);
        copyState.transition = transition;
        copyState.finalize();
        yield copyState;
      }
    }
  }

  int pour(int fromIndex, int toIndex) {
    // Must save availableHeight before popping
    final from = bottles[fromIndex];
    final to = bottles[toIndex];
    var amount = 0;
    while (from.canPour(to)) {
      amount++;
      to.colors.push(from.colors.pop());
    }
    return amount;
  }

  @override
  bool isGoal() => bottles.any(
    // Every bottle is either empty or full of just one color
    (bottle) => bottle.isEmpty,
  );

  bool isWin() => bottles.every(
    (bottle) => bottle.isEmpty || bottle.isFull,
  );

  GameTransition? getHint(int _) {
    // Check 1 million possible paths lol
    final result = aStar(this, limit: 10000000, verbose: false);
    if (result == null) return null;
    final path = result.reconstructPath();
    if (path.isEmpty) {
      return null;
    } else {
      return path.first as GameTransition;
    }
  }

  GameState undo(GameTransition transition) {
    final copy = GameState.copy(this);
    final from = copy.bottles[transition.from];
    final to = copy.bottles[transition.to];
    for (final _ in range(transition.amount)) {
      from.colors.push(to.colors.pop());
    }
    copy.finalize();
    return copy;
  }
}
