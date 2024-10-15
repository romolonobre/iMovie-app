import 'package:app_services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final int itemCount;
  Axis direction;

  ShimmerLoading({
    super.key,
    required this.width,
    required this.height,
    required this.itemCount,
    this.direction = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: direction,
      children: List.generate(
        itemCount,
        (index) => Shimmer.fromColors(
          baseColor: Colors.grey[900]!,
          highlightColor: Colors.grey[800]!,
          child: Container(
            margin: EdgeInsets.only(
              top: direction == Axis.vertical ? 10 : 0,
            ),
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ).paddingOnly(left: 10),
      ),
    );
  }
}
