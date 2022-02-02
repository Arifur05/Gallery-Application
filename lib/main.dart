import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_application/apps/repositories/photo_list_repository.dart';
import 'package:gallery_application/apps/screens/wallpaper_screen/full_screen_image_screen.dart';
import 'package:gallery_application/apps/screens/home/bloc/home_screen_bloc.dart';

import 'apps/screens/home/home_screen.dart';


void main() async{

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
        home: BlocProvider<HomeScreenBloc>(
            create: (context) => HomeScreenBloc(photosRepository: PhotosListRepository()),
            child: FullScreenImageScreen(index: 1, image: '',)
        ),
    );
  }
}

