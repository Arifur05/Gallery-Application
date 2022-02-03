import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';


import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class WallPaperBlock extends Cubit<void> {
  WallPaperBlock(void initialState) : super(false);


 void saveImageToGallery(
      {required String imageUrl, required BuildContext context}) async {

    var response = await Dio()
        .get(imageUrl, options: Options(responseType: ResponseType.bytes));
    await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "hello");

    Navigator.pop(context);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Wallpaper Saved Successfully!'),
      backgroundColor: Colors.green,
    ));
  }

  void saveAsWallPaper(
      {required String imageUrl,
      required BuildContext context,
      required int location}) async {

    var file = await DefaultCacheManager().getSingleFile(imageUrl);
    await WallpaperManagerFlutter()
        .setwallpaperfromFile(file, location)
        .whenComplete(() {
          Navigator.pop(context);
          Navigator.pop(context);
        });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Wallpaper Saved Successfully!'),
      backgroundColor: Colors.green,
    ));
  }


}
