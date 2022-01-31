
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_application/general/text_style.dart';

import 'bloc/home_screen_bloc.dart';
import 'bloc/home_screen_event.dart';
import 'bloc/home_screens_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
        BlocBuilder<HomeScreenBloc, HomeScreenState>(
            builder: (context,state){
              if (state is PhotosLoadingState){
                BlocProvider.of<HomeScreenBloc>(context).getPhotosData();
                return const Center(child: CircularProgressIndicator());
              }
              else if (state is PhotosLoadedState){
                return ListView.builder(
                    padding: const EdgeInsets.all(0.0),
                    shrinkWrap: true,
                    itemCount: state.photos.length,
                    itemBuilder: (context, index){
                      return Text(state.photos[index].url!.toString());
                    });
              }
              else{
                return Center(child: const Text("No Data Found!"));
              }
            }
        )
        //     BlocBuilder<HomeScreenBloc, HomeState>(
        //       builder: ( context, state) {
        //         if (state is PhotosLoadingState) {
        //           return Center(child: CircularProgressIndicator());
        //         }
        //
        //         return Center();
        //       }
        // )
      ),
    );
  }
}
