class PdfModel {
  
  String url;
  String name;
  String type;
  int size;
  PdfModel({
    this.url,
    this.name,
    this.type,
    this.size
    });

  factory PdfModel.fromJson(Map<String, dynamic> json) {
    return PdfModel(
      url: json['url'],
      name: json['name'],
      type: json['type'],
      size: json['size'],
    );
  }
  toJson() {
    return {
      "url": url,
      "name":name,
      "type":type,
      "size":size,
    };
  }
}
