import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery_application/apps/model/photos_list_model.dart';
import 'package:gallery_application/general/text_style.dart';

import '../full_screen_image_screen.dart';
import 'bloc/home_screen_bloc.dart';
import 'bloc/home_screen_event.dart';
import 'bloc/home_screens_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Explore",
              textAlign: TextAlign.left,
              style: TextStyles.generalTextStyle(
                  fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            BlocBuilder<HomeScreenBloc, HomeScreenState>(
                builder: (context, state) {
              if (state is PhotosLoadingState) {
                BlocProvider.of<HomeScreenBloc>(context).getPhotosData();
                return const Center(child: SizedBox(child: CircularProgressIndicator()));
              }
              if (state is PhotosLoadedState) {
                return Expanded(
                  child: GridView.custom(
                    shrinkWrap: true,
                    //semanticChildCount: state.photos.length,
                    gridDelegate: SliverWovenGridDelegate.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      pattern: [
                        const WovenGridTile(1),
                        const WovenGridTile(
                          6.5 / 7.5,
                          crossAxisRatio: 1,
                          alignment: AlignmentDirectional.centerEnd,
                        ),
                      ],
                    ),
                    childrenDelegate:
                        SliverChildBuilderDelegate((context, index) {
                      return _listViewItem(photos: state.photos[index], context: context, index: index);
                    }, childCount: state.photos.length),
                  ),
                );
              } else {
                return Center(child: const Text("No Data Found!"));
              }
            }),
          ],
        ),
      )),
    );
  }

  Widget _listViewItem({
    required PhotosListModel photos,
    required BuildContext context,
    required int index
  }) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FullScreenImageScreen(image: photos.downloadUrl!, index: index)),
        );
      },
      onLongPress: (){},
      child: Card(
        elevation: 6,
        child: SizedBox(
          height: 80.0,
          width: 80.0,
          child: Hero(
            tag: index,
            child: CachedNetworkImage(
              imageUrl: photos.downloadUrl!,
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
      ),
    );
  }
}
