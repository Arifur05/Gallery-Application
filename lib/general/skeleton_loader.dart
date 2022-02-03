import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class ListSkeletonLoader extends StatelessWidget {
  const ListSkeletonLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SingleChildScrollView(
        child: SkeletonGridLoader(
          items: 8,
          builder: Card(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 120,
            ),
          ),
        ),
      ),
    );
  }
}
