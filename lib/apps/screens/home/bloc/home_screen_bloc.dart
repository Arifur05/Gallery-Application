import 'package:gallery_application/apps/model/photos_list_model.dart';
import 'package:gallery_application/apps/repositories/photo_list_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'home_screen_event.dart';
import 'home_screens_state.dart';


class HomeScreenBloc extends Cubit<HomeScreenState> {
  HomeScreenBloc({required this.photosRepository})
      : super(PhotosLoadingState());

  final PhotosListRepository photosRepository;

  late List<PhotosListModel> photos;
  void getPhotosData()async{
    print("called");
    emit(PhotosLoadingState());
    // try {
      photos = await photosRepository.getPhotosList();
      emit(PhotosLoadedState(photos: photos));
    // }
    // catch (e){
    //   throw e;
    // }
  }
  }
