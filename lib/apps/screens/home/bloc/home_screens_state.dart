
import 'package:equatable/equatable.dart';
import 'package:gallery_application/apps/model/photos_list_model.dart';

abstract class HomeScreenState extends Equatable{
}

class PhotosEmptyState extends HomeScreenState{
  @override
  // TODO: implement props
  List<Object?> get props =>[];

}

class PhotosLoadingState extends HomeScreenState{
  PhotosLoadingState(this.photos, {this.isfirstfetch=false});
  final List<PhotosListModel> photos ;
  final bool isfirstfetch;
  @override
  // TODO: implement props
  List<Object> get props => [photos];


}
class PhotosLoadedState extends HomeScreenState{

  PhotosLoadedState(this.newPhotos);
  final List<PhotosListModel> newPhotos;
  @override
  List<Object> get props => [newPhotos];

}

class PhotosLoadingErrorState extends HomeScreenState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}