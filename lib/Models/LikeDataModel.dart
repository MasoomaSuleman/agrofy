class Like {
  String userId;
  String answerId;

  Like({this.answerId, this.userId});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'answerId': answerId,
    };
  }
}
