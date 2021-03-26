class ImagesModel {
  String id;
  String url;
  ImagesModel({this.id, this.url});

  factory ImagesModel.fromJson(Map<String, dynamic> json) {
    return ImagesModel(
      id: json["id"],
      url: json['url'],
    );
  }
  toJson() {
    return {
      "id": id,
      "url": url,
    };
  }
}
