import "package:flutter/foundation.dart";
import "../model.dart"; 

import "package:color_sort/data.dart";

class GameViewModel extends ViewModel {
  int level;
  late GameState _backup;
  late GameState state;
  final List<GameTransition> history = [];

  bool didWin = false;

  GameViewModel(this.level) {
    loadLevel(); 
  }

  void loadLevel() {
    didWin = false;
    state = GameState.level(level);
    _backup = GameState.copy(state);
    state.finalize();
    status = null;
    notifyListeners();
  }

  List<Bottle> get bottles => state.bottles;

  Iterable<List<(int, Bottle)>> getBottleLayout() {
    final numRows = switch (bottles.length) {
      <= 4 => 1, 
      _ => 2,
    };
    final numPerRow = bottles.length ~/ numRows;
    final lastIndex = numPerRow * numRows;
    final rows = <List<(int, Bottle)>>[
      for (final _ in range(numRows)) [],
    ];
    for (final (index, bottle) in bottles.enumerate.take(lastIndex)) {
      rows[index ~/ numPerRow].add( (index, bottle) );
    }
    return rows;
  }

  int? selectedIndex;
  void onTap(int index) {
    if (selectedIndex == null) {
      // Select
      selectedIndex = index;
    } else if (selectedIndex == index) {
      // Deselect
      selectedIndex = null;
    } else {
      // Pour
      final from = bottles[selectedIndex!];
      final to = bottles[index];
      if (from.canPour(to)) {
        final amount = state.pour(selectedIndex!, index);
        final transition = GameTransition(state, from: selectedIndex!, to: index, amount: amount);
        history.add(transition);
        update();
        selectedIndex = null;
      } else {
        selectedIndex = index;
      }
    }
    notifyListeners();
  }

  void undo() {
    final last = history.removeLast();
    state = state.undo(last);
    update();
    status = null;
    notifyListeners();
  }

  void update() {
    didWin = state.isWin();
  }

  void nextLevel() {
    level++;
    loadLevel();
    notifyListeners();
  }

  void reset() {
    state = GameState.copy(_backup);
    state.finalize();
    update();
    notifyListeners();
  }

  String? status;
  int? flashIndex;
  Future<void> checkLevel() async {
    if (state.isGoal()) {
      status = "Pour any color into the empty tube";
      notifyListeners();
      return;
    }
    status = "Checking...";
    notifyListeners();
    final copyState = GameState.copy(state);
    copyState.finalize();
    final hint = await compute(copyState.getHint, -1);
    if (hint == null) {
      status = "Level unsolvable";
      notifyListeners();
    } else {
      status = hint.toString();
      flashIndex = hint.from;
      notifyListeners();
      await Future<void>.delayed(const Duration(milliseconds: 750));
      flashIndex = hint.to;
      notifyListeners();
      await Future<void>.delayed(const Duration(milliseconds: 750));
      flashIndex = null;
      notifyListeners();
    }
  }
}
