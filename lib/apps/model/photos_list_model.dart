// To parse this JSON data, do
//
//     final photosListModel = photosListModelFromJson(jsonString);

import 'dart:convert';

List<PhotosListModel> photosListModelFromJson(String str) => List<PhotosListModel>.from(json.decode(str).map((x) => PhotosListModel.fromJson(x)));

String photosListModelToJson(List<PhotosListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PhotosListModel {
  PhotosListModel({
    this.id,
    this.author,
    this.width,
    this.height,
    this.url,
    this.downloadUrl,
  });

  final int? id;
  final String? author;
  final int? width;
  final int? height;
  final String? url;
  final String? downloadUrl;

  factory PhotosListModel.fromJson(Map<String, dynamic> json) => PhotosListModel(
    id: json["id"],
    author: json["author"],
    width: json["width"],
    height: json["height"],
    url: json["url"],
    downloadUrl: json["download_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author,
    "width": width,
    "height": height,
    "url": url,
    "download_url": downloadUrl,
  };
}
