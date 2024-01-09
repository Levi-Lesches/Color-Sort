import "package:color_sort/data.dart";

class Bottle {
  final List<int> colors;
  Bottle(this.colors);

  String get hash => [
    for (final color in colors) 
      "$color",
  ].join(",");

  static const maxHeight = 4;
  int get availableHeight => maxHeight - colors.length;
  int get height => colors.length;
  bool get isEmpty => colors.isEmpty;
  bool get isFull {
    if (isEmpty) return false;
    final color = colors.first;
    return height == maxHeight && colors.every((other) => other == color);
  }

  bool canPour(Bottle other) {
    if (colors.isEmpty) return false;
    if (other.colors.isEmpty) return true;
    final topColor = colors.peek();
    final otherTopColor = other.colors.peek();
    return topColor == otherTopColor
      && other.availableHeight >= 1;
  }

  Bottle copy() => Bottle(List.from(colors));
}
