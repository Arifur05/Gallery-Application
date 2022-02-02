import 'dart:async';
/**
 * @author : Arif
 * @date : 2/3/2022-02-2022 12:31 AM
 * @package : com.arifur.gallery_application
 * -------------------------------------------
 * Copyright (C) 2022 - All Rights Reserved
 **/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery_application/apps/model/photos_list_model.dart';
import 'package:gallery_application/general/text_style.dart';

import '../wallpaper_screen/full_screen_image_screen.dart';
import 'bloc/home_screen_bloc.dart';
import 'bloc/home_screen_event.dart';
import 'bloc/home_screens_state.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<HomeScreenBloc>(context).getPhotosData();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<HomeScreenBloc>(context).getPhotosData();
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
            _photoListWidget()
          ],
        ),
      )),
    );
  }

  Widget _photoListWidget() {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
      if (state is PhotosLoadingState && state.isfirstfetch) {
        //BlocProvider.of<HomeScreenBloc>(context).getPhotosData();
        return _loadingIndicator();
      }
      List<PhotosListModel> photosList = [];
      bool isLoading = false;

      if (state is PhotosLoadingState) {

        photosList = state.photos;
        isLoading = true;
        print(photosList.length);
      }
      if (state is PhotosLoadedState) {
        photosList = state.newPhotos;
        print(photosList.length);
      }

      return Expanded(
        child: GridView.custom(
          controller: scrollController,
          shrinkWrap: true,
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
          childrenDelegate: SliverChildBuilderDelegate((context, index) {
            if (index < photosList.length) {
              return _listViewItem(
                  photos: photosList[index], context: context, index: index);
            } else {
              Timer(const Duration(milliseconds: 30), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });

              return _loadingIndicator();
            }
          }, childCount: photosList.length + (isLoading ? 1 : 0)),
        ),
      );
    });
  }

  Widget _listViewItem(
      {required PhotosListModel photos,
      required BuildContext context,
      required int index}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FullScreenImageScreen(
                  image: photos.downloadUrl!, index: index)),
        );
      },
      onLongPress: () {},
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

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
