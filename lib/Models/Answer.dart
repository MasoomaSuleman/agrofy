class Answer {
  // question Details
  String questionByName;
  String questionByUID;
  String questionByProfession;
  String questionByImageURL;
  String questionText;
  String questionTimeStamp;
  String questionUID;
  //int replyCount;
  // answer Details
  String answerText;
  String answerTimeStamp;
  String answerImageURL;
  int likesCount;
  //String _answerImage;

  // answer udser details
  String answerByUID;
  String answerByName;
  String answerByProfession;
  String answerByImageURL;

  Answer(
      {this.questionByName,
      this.questionByUID,
      this.questionByProfession,
      this.questionByImageURL,
      this.questionText,
      this.questionTimeStamp,
      this.questionUID,
      this.answerText,
      this.answerByUID,
      this.answerByName,
      this.answerByProfession,
      this.answerByImageURL,
      this.answerTimeStamp,
      this.answerImageURL,
      this.likesCount}); //

  Map<String, dynamic> toMap() {
    return {
      'questionUID': questionUID,
      'questionByName': questionByName,
      'questionByUID': questionByUID,
      'questionByProfession': questionByProfession,
      'questionByImageURL': questionByImageURL,
      'questionText': questionText,
      'questionTimeStamp': questionTimeStamp,
      'answerText': answerText,
      'answerTimeStamp': answerTimeStamp,
      'answerByUID': answerByUID,
      'answerByName': answerByName,
      'answerByProfession': answerByProfession,
      'answerByImageURL': answerByImageURL,
      'answerImageURL': answerImageURL,
      'likesCount': 0
    };
  }

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      questionUID: json['questionUID'],
      questionByName: json['questionByName'],
      questionByUID: json['questionByUID'],
      questionByProfession: json['questionByProfession'],
      questionByImageURL: json['questionByImageURL'],
      questionText: json['questionText'],
      questionTimeStamp: json['questionTimeStamp'],
      answerText: json['answerText'],
      answerTimeStamp: json['answerTimeStamp'],
      answerByUID: json['answerByUID'],
      answerByName: json['answerByName'],
      answerByProfession: json['answerByProfession'],
      answerByImageURL: json['answerByImageURL'],
      answerImageURL: json['answerImageURL'],
      likesCount: json['likesCount'],
    );
  }
}
