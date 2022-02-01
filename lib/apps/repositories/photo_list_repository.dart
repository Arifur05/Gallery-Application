
import 'package:gallery_application/apps/model/photos_list_model.dart';

import 'package:http/http.dart';

class PhotosListRepository {
 Future<List<PhotosListModel>> getPhotosList() async{

   var response = await get(Uri.parse('https://picsum.photos/v2/list?page=2&limit=20'));
   print(response.body);
   return photosListModelFromJson((response.body));
}
}