import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:gallery_application/apps/model/photos_list_model.dart';
import 'package:gallery_application/apps/repositories/photo_list_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screens_state.dart';

class HomeScreenBloc extends Cubit<HomeScreenState> {
  HomeScreenBloc({required this.photosRepository}) : super(PhotosEmptyState());

  final PhotosListRepository photosRepository;
  int page = 1;

  void getPhotosData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final currentState = state;
    var photos = <PhotosListModel>[];
    if (state is PhotosLoadingState) return;
    var connectivityResult = await Connectivity().checkConnectivity();


    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {

      if (currentState is PhotosLoadedState) {
        photos = currentState.newPhotos;
      }
      emit(PhotosLoadingState(photos, isfirstfetch: page == 1));
      photosRepository.getPhotosList(page: page).then((photoList) async {
        page++;
        final photos = (state as PhotosLoadingState).photos;
        photos.addAll(photoList);
        prefs.clear();
        String encodedData = jsonEncode(photos);
        await prefs.setString('photos', encodedData);
        emit(PhotosLoadedState(photos));
      });
    }
    else {
      final photoEncodedString = prefs.getString('photos');

      final List<PhotosListModel> photosList =
      photosListModelFromJson(photoEncodedString!);
      emit(PhotosLoadingErrorState(photosList));
    }

  }
}
