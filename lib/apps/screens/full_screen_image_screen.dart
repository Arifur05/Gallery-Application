import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FullScreenImageScreen extends StatelessWidget{
  final String image;
  final int index;

  const FullScreenImageScreen({required this.image, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: index,
        child: CachedNetworkImage(
          imageUrl: image,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}