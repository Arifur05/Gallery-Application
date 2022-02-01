import 'package:gallery_application/apps/model/photos_list_model.dart';
import 'package:gallery_application/apps/repositories/photo_list_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'home_screen_event.dart';
import 'home_screens_state.dart';


class HomeScreenBloc extends Cubit<HomeScreenState> {
  HomeScreenBloc({required this.photosRepository}) : super(PhotosEmptyState());

  final PhotosListRepository photosRepository;
  int page = 1;
  //late List<PhotosListModel> photos;
  void getPhotosData(){
    //print("called");
    if (state is PhotosLoadingState) return;

    final currentState = state;
    //print(currentState);
    var photos = <PhotosListModel>[];
    if (currentState is PhotosLoadedState) {
      photos = currentState.newPhotos;
    }
    emit(PhotosLoadingState(photos, isfirstfetch: page == 1 ));
     photosRepository.getPhotosList(page:page).then((newPhotos) {
       page++;
       final photos = (state as PhotosLoadingState).photos;
       photos.addAll(newPhotos);
        print(photos.length);
       emit(PhotosLoadedState(photos));
     });

    //print(currentState);
    //emit(PhotosLoadedState(photos: photos));

  }
  }
