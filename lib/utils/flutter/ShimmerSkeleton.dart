import 'package:globaluy_test_app/utils/flutter/HexColor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ShimmerSkeleton extends StatelessWidget {
  ShimmerSkeleton(
      {Key? key, this.radius, required this.height, required this.width})
      : super(key: key);
  final double height, width;
  double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(5),
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: HexColor('#dbdbdb'),
        highlightColor: HexColor('#ededed'),
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 5))),
          padding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
