# Color Sort

The classic Color Sort game, in Flutter! I made this because I was tired of watching ads between every level and wanted hints without being penalized. 

| The game | With hints! |
| ----------------|-------------|
| ![image](https://github.com/Levi-Lesches/Color-Sort/assets/20747538/0db6f3d2-0892-4402-b6c4-f6c0bd16dae9) | ![image](https://github.com/Levi-Lesches/Color-Sort/assets/20747538/62546b4c-51ac-4a70-8a9f-eec1e702fef9) |

## Rules

Pour the colors from tube to tube until each color has its own tube. That is, each tube is either completely empty or completely full with just one color. Pouring is only allowed if there is space for at least one "level" of color and the top-most color of the destination tube matches the top-most color of the source tube. Basically, no mixing colors!

## Hints

I used the A* algorithm to provide hints when needed. A* is usually used for physical pathfinding but I love using it for games: every state has a few moves that lead to other states, so find the shortest acyclic path to the goal.

A cool little revelation I had: doing the whole game in A* was way too much, at least with very simple heuristics. But the game is always solvable (after the very first turn) with just 1 empty tube. And every move reduces the total "entropy" of the board. So the app uses A* just to get to the next empty tube, which is usually only 5-10 moves away, and clearing tubes repeatedly eventually wins the game.

## Using

I have not published this, but you can simply [install Flutter](https://docs.flutter.dev/get-started/install) and run

#### Android
```
flutter build apk
flutter install
```

#### Windows/MacOS/Linux
```
flutter build windows/macos/linux
```
> [!NOTE]
> Do not actually type all 3, just choose one (no slashes)

#### iOS
I do not have an iPhone or Mac, so I'm unfamiliar with the build process, but you can always try `flutter run --release` or opening the project in XCode.

