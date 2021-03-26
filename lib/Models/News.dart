class News {
  String headlineText;
  String text;
  String imageUrl;
  News({this.text, this.imageUrl, this.headlineText});

  Map<String, dynamic> toMap() {
    return {
      'headlineText': headlineText,
      'text': text,
      'imageUrl': imageUrl,
    };
  }

  News fromMap(snap) {
    return News(
        text: snap['text'],
        headlineText: snap['headlineText'],
        imageUrl: snap['imageUrl']);
  }
}
