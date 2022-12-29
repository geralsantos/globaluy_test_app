import 'package:flutter/material.dart';
import 'package:globaluy_test_app/utils/flutter/ShimmerSkeleton.dart';

class ShimmerProduct extends StatelessWidget {
  const ShimmerProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerSkeleton(
            height: 100,
            width: 100,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerSkeleton(
                height: 30,
                width: size.width,
              ),
              ShimmerSkeleton(
                height: 30,
                width: size.width,
              ),
              ShimmerSkeleton(
                height: 30,
                width: size.width,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
