import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_application/apps/repositories/photo_list_repository.dart';

import 'home/bloc/home_screen_bloc.dart';
import 'home/home_screen.dart';

class SplashScreen extends StatelessWidget{



  const SplashScreen({Key? key,required this.baseUrl}) : super(key: key);

  final String baseUrl;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: Future.delayed(const Duration(milliseconds: 3000)),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Splash();
            }
            else {
              // return Splash();
              return BlocProvider<HomeScreenBloc>(
                create: (context) =>
                    HomeScreenBloc(photosRepository: PhotosListRepository(
                        baseUrl: baseUrl)),
                child: HomeScreen(),
              );
            }
          }
        ),
      ),
    );
  }

}

class Splash extends StatelessWidget{
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/images/wallpaper_basket.png'),
          ),
        ),
      ],
    );
  }

}