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
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey,
            ),
            child: Row(children: [
              Stack(
                children: [
                  Positioned(
                    left: 20,
                    child: Container(
                      height: 200,
                      width: 150,
                      color: Colors.black12,
                    ),
                  ),
                  const SizedBox(width: 50),
                  Container(
                    height: 25,
                    width: 150,
                    color: Colors.grey[400],
                  ),
                ],
              )
            ]),
          ),
          const SizedBox(height: 10),
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey,
            ),
            child: Row(children: [
              Stack(
                children: [
                  Positioned(
                    left: 20,
                    child: Container(
                      height: 200,
                      width: 150,
                      color: Colors.black12,
                    ),
                  ),
                  const SizedBox(width: 50),
                  Container(
                    height: 25,
                    width: 150,
                    color: Colors.grey[400],
                  ),
                ],
              )
            ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
