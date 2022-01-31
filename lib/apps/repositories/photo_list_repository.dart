import 'package:dio/dio.dart';
import 'package:gallery_application/apps/model/photos_list_model.dart';


class PhotosListRepository {
 Future<List<PhotosListModel>> getPhotosList() async{

   var response = await Dio()
       .get('https://picsum.photos/v2/list?page=2&limit=20');

   print(response.data);
   if (response.data['success'] == true) {
   return photosListModelFromJson((response.data));

   } else {
   throw Exception('Failed to load data!');
   } // } else {
   //   toast('SOMETHING_WENT_WRONG'.tr);
}
}