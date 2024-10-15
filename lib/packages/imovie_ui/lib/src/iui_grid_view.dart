import 'package:flutter/widgets.dart';

class IUIGridView extends StatelessWidget {
  final int? crossAxisCount;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final double? mainAxisExtent;
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  final Axis? scrollDirection;

  const IUIGridView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.crossAxisCount,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.mainAxisExtent,
    this.scrollDirection,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: scrollDirection ?? Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount ?? 1,
        mainAxisSpacing: mainAxisSpacing ?? 10,
        crossAxisSpacing: crossAxisSpacing ?? 8,
        mainAxisExtent: mainAxisExtent ?? 70,
      ),
      padding: const EdgeInsets.all(0),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
