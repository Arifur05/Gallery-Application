import 'dart:convert';

List<PhotosListModel> photosListModelFromJson(String str) => List<PhotosListModel>.from(json.decode(str).map((x) => PhotosListModel.fromJson(x)));

String photosListModelToJson(List<PhotosListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PhotosListModel {
  PhotosListModel({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  factory PhotosListModel.fromJson(Map<String, dynamic> json) => PhotosListModel(
    id: json["id"] == null ? null : json["id"],
    author: json["author"] == null ? null : json["author"],
    width: json["width"] == null ? null : json["width"],
    height: json["height"] == null ? null : json["height"],
    url: json["url"] == null ? null : json["url"],
    downloadUrl: json["download_url"] == null ? null : json["download_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "author": author == null ? null : author,
    "width": width == null ? null : width,
    "height": height == null ? null : height,
    "url": url == null ? null : url,
    "download_url": downloadUrl == null ? null : downloadUrl,
  };
}
