
import 'package:equatable/equatable.dart';
import 'package:gallery_application/apps/model/photos_list_model.dart';

abstract class HomeScreenState extends Equatable{

  const HomeScreenState();
}

class PhotosEmptyState extends HomeScreenState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class PhotosLoadingState extends HomeScreenState{
  @override
  // TODO: implement props
  List<Object> get props => [];


}
class PhotosLoadedState extends HomeScreenState{

  PhotosLoadedState({required this.photos});
  late List<PhotosListModel> photos;
  @override
  List<Object> get props => [photos];

}

class PhotosLoadingErrorState extends HomeScreenState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}