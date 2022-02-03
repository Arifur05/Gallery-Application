import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gallery_application/apps/model/photos_list_model.dart';
import 'package:gallery_application/apps/repositories/photo_list_repository.dart';
import 'package:gallery_application/apps/screens/home/bloc/home_screen_bloc.dart';
import 'package:gallery_application/apps/screens/home/bloc/home_screens_state.dart';

void main(){


  group('homeBloc Tests',(){
    PhotosListRepository photoListRepository;
    late HomeScreenBloc homeScreenBloc;
    var cat = <PhotosListModel>[];



    const empty = TypeMatcher<PhotosEmptyState>();
    const loading = TypeMatcher<PhotosLoadingState>();
    const loaded = TypeMatcher<PhotosLoadedState>();

    setUp((){
      EquatableConfig.stringify= true;
      photoListRepository= PhotosListRepository(baseUrl: '');
      homeScreenBloc= HomeScreenBloc( photosRepository: photoListRepository);
    });

    blocTest(
      'emits [] when state is empty',
      build: () => homeScreenBloc,
      expect: () => [],
    );
    blocTest<HomeScreenBloc, HomeScreenState>(
      'emits [PhotosEmptyState,PhotosLoadingState,PhotosLoadedState] when state is empty',
      build: () => homeScreenBloc,
      act: (bloc)=> bloc.getPhotosData(),
      expect: () => [
        PhotosEmptyState(),
        PhotosLoadingState(cat),
        PhotosLoadedState(cat)
      ],
    );


    tearDown((){
      homeScreenBloc.close();
    });

  });




}
