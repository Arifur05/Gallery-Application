
import 'package:gallery_application/apps/model/photos_list_model.dart';

import 'package:http/http.dart';

class PhotosListRepository {
  PhotosListRepository({required this.baseUrl});
  String baseUrl ;
 Future<List<PhotosListModel>> getPhotosList({page}) async{

   var response = await get(Uri.parse('$baseUrl=$page&limit=15'));
   return photosListModelFromJson((response.body));
}


}