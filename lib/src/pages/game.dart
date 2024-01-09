import "package:flutter/material.dart";

import "package:color_sort/models.dart";
import "package:color_sort/widgets.dart";

/// The home page.
class GamePage extends ReactiveWidget<GameViewModel> {
  @override
  GameViewModel createModel() => GameViewModel(50);

  @override
  Widget build(BuildContext context, GameViewModel model) => Scaffold(
    appBar: AppBar(),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final row in model.getBottleLayout()) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final (index, bottle) in row) Column(children: [ 
                BottleWidget(
                  bottle: bottle,
                  onTap: bottle.isFull || model.didWin ? null : () => model.onTap(index),
                  isSelected: model.selectedIndex == index,
                  isFlashed: model.flashIndex == index,
                ),
                const SizedBox(height: 4),
                Text("${index + 1}"),
              ],),
            ],
          ),
          const SizedBox(height: 48),
        ],
        if (!model.didWin && model.status != null) Text(model.status!, style: context.textTheme.titleLarge),
        const SizedBox(height: 16),
        if (!model.didWin) Row(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            const SizedBox(width: 24),
            OutlinedButton.icon(
              label: const Text("Reset"),
              icon: const Icon(Icons.restart_alt), 
              onPressed: model.reset,
            ),
            const SizedBox(width: 24),
            OutlinedButton.icon(
              label: const Text("Hint"),
              icon: const Icon(Icons.help),
              onPressed: model.checkLevel,
            ),
          ],
        ),
        const SizedBox(height: 4),
        if (!model.didWin) Row(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            OutlinedButton.icon(
              label: const Text("New game"),
              icon: const Icon(Icons.flag), 
              onPressed: model.loadLevel,
            ),
            const SizedBox(width: 24),
            OutlinedButton.icon(
              label: const Text("Undo"),
              icon: const Icon(Icons.undo), 
              onPressed: model.history.isEmpty ? null : model.undo,
            ),
          ],
        ),
        if (model.didWin) ...[
          Text("Good job!", style: context.textTheme.headlineLarge),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: model.nextLevel,
            child: const Text("Next Level"),
          ),
        ],
      ],
    ),
  );
}
