import "package:flutter/material.dart";
import "package:color_sort/data.dart";

class BottleWidget extends StatelessWidget {
  static const double levelHeight = 50;
  static const double levelWidth = 75;
  
  final Bottle bottle;
  final bool isSelected;
  final bool isFlashed;
  final VoidCallback? onTap;
  BottleWidget({
    required this.bottle, 
    required this.isSelected,
    required this.isFlashed,
    required this.onTap,
    super.key,
  });

  final allColors = [
    Colors.red.shade400, 
    Colors.deepOrange.shade300,
    Colors.amber,
    Colors.green,
    Colors.cyan.shade200,
    Colors.indigo.shade300,
    Colors.purpleAccent.shade700,    
    Colors.pink.shade200,
    Colors.blueGrey.shade700,
    Colors.brown,
  ];

  @override
  Widget build(BuildContext context) => Transform.translate(
    offset: isSelected ? const Offset(0, -24) : Offset.zero,
    child: SizedBox(
      width: levelWidth, 
      height: levelHeight * 4,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          padding: const EdgeInsets.all(2),
          decoration: isFlashed 
            ? BoxDecoration(border: Border.all(color: Colors.orange, width: 5))
            : BoxDecoration(border: Border.all()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (bottle.availableHeight > 0) 
                Spacer(flex: bottle.availableHeight),
              for (final color in bottle.colors.reversed) Expanded(
                child: Container(color: allColors[color]),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
