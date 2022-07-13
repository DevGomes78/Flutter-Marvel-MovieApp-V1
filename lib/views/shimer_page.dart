import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildListView(),
    );
  }
  Shimmer buildListView() {
    return Shimmer.fromColors(
      highlightColor: Colors.grey[300]!,
      baseColor: Colors.grey[400]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 380,
            color: Colors.grey[400],
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            width: 380,
            color: Colors.grey[400],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
