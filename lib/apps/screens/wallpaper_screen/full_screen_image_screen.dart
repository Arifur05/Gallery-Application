import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gallery_application/apps/screens/wallpaper_screen/wallpaper_bloc.dart';
import 'package:gallery_application/general/text_style.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class FullScreenImageScreen extends StatelessWidget {
  final String image;
  final int index;

  const FullScreenImageScreen({required this.image, required this.index});

  @override
  Widget build(BuildContext context) {
    print(image.toString());
    return SafeArea(
      child: Scaffold(
        body: Hero(
          tag: index,
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: InteractiveViewer(
                  boundaryMargin: const EdgeInsets.all(0.0),
                  minScale: 0.1,
                  maxScale: 1.6,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              Positioned(
                bottom: 80.0,
                left: MediaQuery.of(context).size.width / 3,
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          var file = await DefaultCacheManager().getSingleFile(
                              image);
                          Share.shareFiles([file.path],
                              text:
                                  'Great picture'); // context.read<WallPaperBlock>().shareWallpaper(imageUrl: "https://picsum.photos/id/1003/1181/1772", context: context);
                        },
                      child: const Center(
                          child: Icon(
                            Icons.share,
                            color: Colors.black,
                          )),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        primary: Colors.blueGrey,
                        onPrimary: Colors.black,
                      ),),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return BlocProvider(
                              create: (_) => WallPaperBlock(null),
                              child: _bottomSheet(imageUrl: image),
                            );
                          }),
                      child: const Center(
                          child: Icon(
                        Icons.download_rounded,
                        color: Colors.black,
                      )),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        primary: Colors.white,
                        onPrimary: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomSheet({required String imageUrl}) {
    return BlocBuilder<WallPaperBlock, void>(
        builder: (context, string) => Container(
              height: MediaQuery.of(context).size.height / 4,
              padding: const EdgeInsets.symmetric(vertical:16, horizontal: 32.0),
              child: Column(
                children: [
                  Text("What Would You Like To Do?",style:TextStyles.generalTextStyle(fontSize: 16.0, fontWeight: FontWeight.bold), ),
                  const SizedBox(height: 20),
                  _bottomSheetOptions(
                      text: "Set Wallpaper",
                      onClick: () {
                        context.read<WallPaperBlock>().saveAsWallPaper(
                            imageUrl: imageUrl,
                            context: context,
                            location: WallpaperManagerFlutter.HOME_SCREEN);
                      },
                      image: Icons.wallpaper_rounded),
                  const SizedBox(height: 10),
                  _bottomSheetOptions(
                      text: "Set Lock Screen",
                      onClick: () {
                        context.read<WallPaperBlock>().saveAsWallPaper(
                            imageUrl: imageUrl,
                            context: context,
                            location: WallpaperManagerFlutter.LOCK_SCREEN);
                      },
                      image: Icons.lock_outline_rounded),
                  const SizedBox(height: 10),
                  _bottomSheetOptions(
                      text: "Set Both",
                      onClick: () {
                        context.read<WallPaperBlock>().saveAsWallPaper(
                            imageUrl: imageUrl,
                            context: context,
                            location: WallpaperManagerFlutter.BOTH_SCREENS);
                      },
                      image: Icons.screen_lock_rotation),
                  const SizedBox(height: 10),
                  _bottomSheetOptions(
                      text: "Save To Media Folder",
                      onClick: () {

                        context.read<WallPaperBlock>().saveImageToGallery(
                            imageUrl: imageUrl, context: context);
                      },
                      image: Icons.perm_media_outlined),
                ],
              ),
            ));
  }

  Widget _bottomSheetOptions({
    required String text,
    required VoidCallback onClick,
    required IconData image,
  }) {
    return GestureDetector(
      onTap: onClick,
      child: Row(
        children: [
          Icon(image),
          const SizedBox(width: 10),
          Text(text, style: TextStyles.generalTextStyle(fontSize: 14.0)),
        ],
      ),
    );
  }
}
