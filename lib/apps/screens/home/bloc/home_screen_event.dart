import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();
}

class FetchPhotos extends HomeScreenEvent {
  // final String city;
  //
  // FetchPhotos({required this.city})
  //     : assert(city != null),
  //       super([city]);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}