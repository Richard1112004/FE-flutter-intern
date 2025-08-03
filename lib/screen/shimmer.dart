import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

// Widget Shimmer loading
Widget shimmerLoading() {
  return SizedBox(
    height: 200,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 3, // placeholder items
      separatorBuilder: (_, __) => SizedBox(width: 20),
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
  );
}
