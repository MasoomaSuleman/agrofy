class FileModel {
  String url;
  String name;
  String type;
  int size;
  FileModel({this.url, this.name, this.type, this.size});
  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      url: json['url'],
      name: json['name'],
      type: json['type'],
      size: json['size'],
    );
  }
  toJson() {
    return {
      "url": url,
      "name": name,
      "type": type,
      "size": size,
    };
  }
}
