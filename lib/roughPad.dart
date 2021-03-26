class DummyQuestionsToUpload {
  String questionByName;
  String questionByUID;
  String questionByProfession;
  String questionByImageURL;

// question details
  String questionText;
  String questionTimeStamp;
  String latestAnswerText;
  int replyCount;
  bool isAnswered;
  bool containsImage;
  List<dynamic> questionImages;

  DummyQuestionsToUpload(
      {this.questionByName,
      this.questionByUID,
      this.questionByProfession,
      this.questionByImageURL,
      this.questionText,
      this.questionTimeStamp,
      this.latestAnswerText,
      this.replyCount,
      this.containsImage,
      this.questionImages});

  static List<DummyQuestionsToUpload> QuestionListTOUpload = [
    DummyQuestionsToUpload(
      questionByName: 'New User',
      questionByImageURL: null,
      questionByProfession: 'Profession',
      questionByUID: '1V8PLdNvmsThNVxkX6Ham3Q6brI3',
      questionText: 'WHAT IS THE DUE DATE OF FILING ANNUAL RETURN?',
      questionTimeStamp: '1599397848784',
    ),
    DummyQuestionsToUpload(
      questionByName: 'Gaurav Pandit',
      questionByImageURL:
          'https://lh3.googleusercontent.com/a-/AOh14GgRLpIJfjjO8fbg0Ej6pAiR7CR7Qse9ZM8YRVLg=s96-c',
      questionByProfession: 'Profession',
      questionByUID: 'y1BlE8mU7pNMoW8EJlk6XxORYOS2',
      questionText: 'WHAT IS THE DUE DATE OF FILING ANNUAL RETURN',
      questionTimeStamp: '1599397848784',
    ),
    DummyQuestionsToUpload(
      questionByName: 'New User',
      questionByImageURL: null,
      questionByProfession: 'Profession',
      questionByUID: '1V8PLdNvmsThNVxkX6Ham3Q6brI3',
      questionText:
          'WHAT IS ANNUAL RETURN AND WHICH SECTION ELABORATES THE PROVISIONS OF ANNUAL RETURN?',
      questionTimeStamp: '1599397848784',
    ),
  ];

  Map<String, dynamic> toMap() {
    return {
      'questionByName': questionByName,
      'questionByUID': questionByUID,
      'questionByProfession': questionByProfession,
      'questionByImageURL': questionByImageURL,
      'questionText': questionText,
      'questionTimeStamp': questionTimeStamp,
      'latestAnswerText': null,
      'replyCount': 0,
    };
  }
}
/////
//////  static List<DummyQuestionsToUpload> toUpload = [
//////    DummyQuestionsToUpload(
//////        userID: '1V8PLdNvmsThNVxkX6Ham3Q6brI3',
//////        userProfession: 'Profession',
//////        userName: 'Ettsff',
//////        userImageUrl: null,
//////        containImages: false,
//////        isAnswered: false,
//////        isBookmarked: false,
//////        timeStamp: 0,
//////        questionText:
//////            'WHAT IS ANNUAL RETURN AND WHICH SECTION ELABORATES THE PROVISIONS OF ANNUAL RETURN?',
//////        imagesCount: 0),
//////    DummyQuestionsToUpload(
//////        userID: 'y1BlE8mU7pNMoW8EJlk6XxORYOS2',
//////        userProfession: 'Profession',
//////        userName: 'Gaurav Pandit',
//////        userImageUrl:
//////            'https://lh3.googleusercontent.com/a-/AOh14GgRLpIJfjjO8fbg0Ej6pAiR7CR7Qse9ZM8YRVLg=s96-c',
//////        containImages: false,
//////        isAnswered: false,
//////        isBookmarked: false,
//////        timeStamp: 0,
//////        questionText: 'WHAT IS THE DUE DATE OF FILING ANNUAL RETURN',
//////        imagesCount: 0),
//////    DummyQuestionsToUpload(
//////        userID: '1V8PLdNvmsThNVxkX6Ham3Q6brI3',
//////        userProfession: 'Profession',
//////        userName: 'Ettsff',
//////        userImageUrl: null,
//////        containImages: false,
//////        isAnswered: false,
//////        isBookmarked: false,
//////        timeStamp: 0,
//////        questionText:
//////            'IS THERE ANY EXTENSION IN THE DUE DATE OF FILING ANNUAL RETURN FOR F.Y. 2017-18?',
//////        imagesCount: 0),
//////    DummyQuestionsToUpload(
//////        userID: 'y1BlE8mU7pNMoW8EJlk6XxORYOS2',
//////        userProfession: 'Profession',
//////        userName: 'Gaurav Pandit',
//////        userImageUrl:
//////            'https://lh3.googleusercontent.com/a-/AOh14GgRLpIJfjjO8fbg0Ej6pAiR7CR7Qse9ZM8YRVLg=s96-c',
//////        containImages: false,
//////        isAnswered: false,
//////        isBookmarked: false,
//////        timeStamp: 0,
//////        questionText:
//////            'IS THERE ANY EXTENSION IN THE DUE DATE OF FILING ANNUAL RETURN FOR F.Y. 2017-18?',
//////        imagesCount: 0),
//////    DummyQuestionsToUpload(
//////        userID: '1V8PLdNvmsThNVxkX6Ham3Q6brI3',
//////        userProfession: 'Profession',
//////        userName: 'Ettsff',
//////        userImageUrl: null,
//////        containImages: false,
//////        isAnswered: false,
//////        isBookmarked: false,
//////        timeStamp: 0,
//////        questionText:
//////            'WHAT IS THE QUANTUM OF LATE FEE APPLICABLE ON LATE FILING OF GSTR 9?',
//////        imagesCount: 0),
//////    DummyQuestionsToUpload(
//////        userID: 'y1BlE8mU7pNMoW8EJlk6XxORYOS2',
//////        userProfession: 'Profession',
//////        userName: 'Gaurav Pandit',
//////        userImageUrl:
//////            'https://lh3.googleusercontent.com/a-/AOh14GgRLpIJfjjO8fbg0Ej6pAiR7CR7Qse9ZM8YRVLg=s96-c',
//////        containImages: false,
//////        isAnswered: false,
//////        isBookmarked: false,
//////        timeStamp: 0,
//////        questionText: 'WHO IS SUPPOSED TO FILE ANNUAL RETURN?',
//////        imagesCount: 0),
//////    DummyQuestionsToUpload(
//////        userID: '1V8PLdNvmsThNVxkX6Ham3Q6brI3',
//////        userProfession: 'Profession',
//////        userName: 'Ettsff',
//////        userImageUrl: null,
//////        containImages: false,
//////        isAnswered: false,
//////        isBookmarked: false,
//////        timeStamp: 0,
//////        questionText:
//////            'ARE THERE DIFFERENT ANNUAL RETURNS ON THE BASIS OF NATURE OF TAXABLE PERSONS?',
//////        imagesCount: 0),
//////    DummyQuestionsToUpload(
//////        userID: 'y1BlE8mU7pNMoW8EJlk6XxORYOS2',
//////        userProfession: 'Profession',
//////        userName: 'Gaurav Pandit',
//////        userImageUrl:
//////            'https://lh3.googleusercontent.com/a-/AOh14GgRLpIJfjjO8fbg0Ej6pAiR7CR7Qse9ZM8YRVLg=s96-c',
//////        containImages: false,
//////        isAnswered: false,
//////        isBookmarked: false,
//////        timeStamp: 0,
//////        questionText: 'IS THERE ANY EXCEPTION FROM FILING OF ANNUAL RETURN?',
//////        imagesCount: 0),
//////    DummyQuestionsToUpload(
//////        userID: '1V8PLdNvmsThNVxkX6Ham3Q6brI3',
//////        userProfession: 'Profession',
//////        userName: 'Ettsff',
//////        userImageUrl: null,
//////        containImages: false,
//////        isAnswered: false,
//////        isBookmarked: false,
//////        timeStamp: 0,
//////        questionText:
//////            'IS THERE ANY EXEMPTION THRESHOLD LIMIT BELOW WHICH A PERSON IS NOT REQUIRED TO FILE ANNUAL RETURN AND RECONCILIATION STATEMENT?',
//////        imagesCount: 0),
//////  ];
//////
//////  Map<String, dynamic> toMap() {
//////    return {
//////      '_containImages': containImages,
//////      '_imagesCount': imagesCount,
//////      '_isAnswered': isAnswered,
//////      '_isBookmarked': isBookmarked,
//////      '_question': questionText,
//////      '_timeStamp': timeStamp,
//////      '_userID': userID,
//////      '_userImageUrl': userImageUrl,
//////      '_userName': userName,
//////      '_userProfession': userProfession,
//////    };
//////  }
//////}
////import 'package:cached_network_image/cached_network_image.dart';
////import 'package:cloud_firestore/cloud_firestore.dart';
////import 'package:flutter/cupertino.dart';
////import 'package:flutter/material.dart';
////import 'package:google_fonts/google_fonts.dart';
////import 'package:gst_application/provider/QuestionDetails.dart';
////import 'package:gst_application/provider/personal_information.dart';
////import 'package:gst_application/utils/SizeConfig.dart';
////import 'package:provider/provider.dart';
////
////Color greyColor = new Color(0xffA2A2A2);
////Color lightGreyColor = new Color(0xffF3F3F3);
////Color textColor = new Color(0xffAEAEAE);
////Color backgroundColor = new Color(0xffF8F8F8);
////Widget answerWidget;
//////ExpandableText(this.text)
//////String text;
////bool isExpanded = false;
////ScrollController _scrollController = new ScrollController();
////
////bool _containsImages = false;
////int _numberOfImages = 0;
////int _numberOfLikes = 0;
////bool _isUserLikedAnswer = false;
////var _questionUserImage;
////List<dynamic> answersList = new List();
////bool _isOnTop = true;
////var _containsImage = false;
////
////String questionID;
////String _answer;
////String _answerImage;
////String _questionTimeStamp;
////String _answerTimeStamp;
////String _userImageUrl;
////String _userName;
////String _userId;
////String _answerID;
////
////Map<String, dynamic> _userLikesMap;
////
////List<dynamic> _likesList;
////bool _isAnswerLiked = false;
////DocumentSnapshot _answerSnapshot;
////
////List<String> _listOfDocumentID;
////int answersListLenght = 0;
////
////String sampleQuestion =
////    "What is the best online stock investigation tool for beginners in times of pandemic of Coronavirus ?";
//////String sampleAnswer = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo";
////String answer =
////    "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet";
////
////class HomeScreenTwo extends StatefulWidget {
////  @override
////  _HomeScreenTwoState createState() => _HomeScreenTwoState();
////}
////
////class _HomeScreenTwoState extends State<HomeScreenTwo>
////    with TickerProviderStateMixin {
////  var _isQuestionAnswered;
////
////  @override
////  void initState() {
////    // TODO: implement initState
////    super.initState();
////    isExpanded = false;
////  }
////
////  @override
////  Widget build(BuildContext context) {
////    var questionDetails = Provider.of<QuestionDetails>(context);
////    var userDetails = Provider.of<UserDetails>(context);
////    _userId = userDetails.user_id;
////    print("User ID:: $_userId");
////    _containsImages = questionDetails.containsImages;
////    print("Contains Images: ${_containsImages.toString()}");
////    return Scaffold(
////        resizeToAvoidBottomPadding: true,
////        appBar: AppBar(
////          backgroundColor: CupertinoColors.white,
////          leading: InkWell(
////            child: Icon(
////              Icons.arrow_back,
////              color: CupertinoColors.black,
////            ),
////            onTap: () {
////              Navigator.of(context).pop(true);
////            },
////          ),
////        ),
////        body: Padding(
////            padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
////            child: answersListWidget(questionDetails)));
////  }
////
////  _scrollToTop() {
////    _scrollController.animateTo(_scrollController.position.minScrollExtent,
////        duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
////    setState(() => _isOnTop = true);
////  }
////
////  _scrollToBottom() {
////    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
////        duration: Duration(milliseconds: 1000), curve: Curves.easeOut);
////    setState(() => _isOnTop = false);
////  }
////
////  Widget nameAndBookmarkWidget(QuestionDetails questionDetails) {
////    String name;
////    questionID = questionDetails?.questionID;
////    return Container(
////      width: SizeConfig.blockSizeHorizontal * 100,
////      height: SizeConfig.blockSizeVertical * 10,
////      child: Padding(
////        padding: EdgeInsets.all(0),
////        child: Container(
////          width: SizeConfig.blockSizeHorizontal * 85,
////          child: StreamBuilder(
////            stream: Firestore.instance
////                .collection("questionData")
////                .document(questionID)
////                .snapshots(),
////            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
////              DocumentSnapshot documentSnapshot = snapshot?.data;
////              print("Data: ${documentSnapshot?.data["_userImageUrl"]}");
////              print("Data: ${documentSnapshot?.data["_userID"]}");
////              name = documentSnapshot?.data["_userName"];
////              return Row(
////                mainAxisAlignment: MainAxisAlignment.start,
////                crossAxisAlignment: CrossAxisAlignment.center,
////                children: [
////                  Padding(
////                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
////                    child: CircleAvatar(
////                      radius: 20.0,
////                      backgroundImage:
////                      NetworkImage(documentSnapshot?.data["_userImageUrl"]),
////                      backgroundColor: Colors.transparent,
////                    ),
////                  ),
////                  Text(
////                    '$name',
////                    style: GoogleFonts.poppins(
////                        color: CupertinoColors.black,
////                        fontSize: 14,
////                        fontWeight: FontWeight.w500),
////                  ),
////                  // userNameWidget(name: name),
////                  recommendedWidget(),
////                ],
////              );
////            },
////          ),
////        ),
////      ),
////    );
////  }
////
////  Widget userNameWidget({String name}) {
////    return Text(
////      '$name',
////      style: GoogleFonts.poppins(
////          color: CupertinoColors.black,
////          fontSize: 14,
////          fontWeight: FontWeight.w500),
////    );
////  }
////
////  Widget recommendedWidget() {
////    return Padding(
////      padding: EdgeInsets.all(5),
////      child: Text(
////        '- Recommended for you',
////        style: GoogleFonts.poppins(
////            color: CupertinoColors.inactiveGray,
////            fontSize: 8,
////            fontWeight: FontWeight.w400),
////      ),
////    );
////  }
////
////  Widget questionWidget(QuestionDetails questionDetails) {
////    return Padding(
////        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
////        child: Expanded(
////          child: Text(
////            questionDetails?.question,
////            style: GoogleFonts.poppins(
////                color: CupertinoColors.black,
////                fontSize: 16,
////                fontStyle: FontStyle.normal,
////                fontWeight: FontWeight.w600),
////          ),
////        ));
////  }
////
////  Widget addAnswerWidget() {
////    return Padding(
////      padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
////      child: TextField(
////        showCursor: true,
//////          readOnly: true,
////        onTap: () {
////          Navigator.of(context).push(
////              MaterialPageRoute(builder: (context) => AddNewAnswerScreen()));
////        },
////        decoration: new InputDecoration(
////            prefixIcon: Icon(Icons.translate),
////            suffixIcon: Icon(Icons.filter),
////            disabledBorder: InputBorder.none,
////            border: OutlineInputBorder(
////                borderRadius: BorderRadius.all(Radius.circular(5.0)),
////                borderSide: BorderSide.none),
////            filled: true,
////            hintStyle: GoogleFonts.poppins(
////                color: CupertinoColors.inactiveGray,
////                fontSize: 12,
////                fontWeight: FontWeight.w400),
////            hintText: "Share you answer...",
////            fillColor: new Color(0xffFFFFFF)),
////      ),
////    );
////  }
////
////  Widget answersListWidget(QuestionDetails questionDetails) {
////    questionID = questionDetails?.questionID;
////    return StreamBuilder(
////      stream: Firestore.instance
////          .collection("questionData")
////          .document(questionID)
////          .snapshots(),
////      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
////        if (snapshot.connectionState == ConnectionState.done) {
////          print("Connection State Done!");
////        } else if (snapshot.connectionState == ConnectionState.active) {
////          print("Connection State Active!");
////          if (snapshot.hasData) {
////            print("Has Data");
////            _isQuestionAnswered = snapshot?.data["_isAnswered"];
////          } else if (snapshot.hasError) {
////            print("Error: ${snapshot.hasError.hashCode.toString()}");
////          } else {
////            print("No Data");
////          }
////        }
////        return _isQuestionAnswered
////            ? answersWidget(questionDetails)
////            : Center(
////          child: Text('No Answers Yet!',
////              style: GoogleFonts.poppins(
////                  fontSize: 18,
////                  color: CupertinoColors.black,
////                  fontWeight: FontWeight.w500)),
////        );
////      },
////    );
////  }
////
////  Widget answersWidget(QuestionDetails questionDetails) {
////    var _likesCount;
////    return StreamBuilder(
////      stream: Firestore.instance
////          .collection("questionData")
////          .document(questionID)
////          .collection("answerData")
////          .snapshots(),
////      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
////        switch (snapshot.connectionState) {
////          case ConnectionState.none:
////            answersListLenght = 0;
////            break;
////          case ConnectionState.done:
////            answersListLenght = 0;
////            break;
////          case ConnectionState.waiting:
////            answersListLenght = 0;
////            break;
////          case ConnectionState.active:
////            answersListLenght = snapshot?.data?.documents?.length;
////            break;
////          default:
////            answersListLenght = 0;
////            break;
////        }
////
////        return ListView.builder(
////          primary: true,
////          shrinkWrap: true,
////          physics: PageScrollPhysics(),
////          padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
////          itemCount: 1 + answersListLenght,
////          itemBuilder: (context, index) {
////            if (index == 0) {
////              return Expanded(
////                flex: 1,
////                child: Column(
////                  children: <Widget>[
////                    nameAndBookmarkWidget(questionDetails),
////                    questionWidget(questionDetails),
////                    addAnswerWidget()
////                  ],
////                ),
////              );
////            } else {
////              int numberOfExtraWidget = 1;
////              index = index - numberOfExtraWidget;
////
////              switch (snapshot.connectionState) {
////                case ConnectionState.none:
////                  print("Connection State None!");
////                  _userImageUrl = 'https://i.pravatar.cc/300';
////                  _containsImages = false;
////                  break;
////                case ConnectionState.done:
////                  print("Connection State Done!");
////                  _userImageUrl = 'https://i.pravatar.cc/300';
////                  _containsImages = false;
////                  break;
////                case ConnectionState.waiting:
////                  print("Connection State Waiting!");
////                  _userImageUrl = 'https://i.pravatar.cc/300';
////                  _containsImages = false;
////                  return CircularProgressIndicator();
////                  break;
////                case ConnectionState.active:
////                  print("Connection State Active!");
////                  if (snapshot.hasData) {
////                    print("Snapshot has data!");
////                    _answerSnapshot = snapshot?.data?.documents[index];
////                    // _answerImage = _answerSnapshot["_answerImage"];
////                    // _answerTimeStamp = _answerSnapshot["_answerTimeStamp"];
////                    // _userId = _answerSnapshot["_userID"];
////                    // _answerID = _answerSnapshot["_answerID"];
////                    _containsImages = _answerSnapshot["_containsImages"];
////                    _userImageUrl = _answerSnapshot["_userImageUrl"];
////
////                    print("Answer: $answer");
////                  } else if (snapshot.hasError) {
////                    print(
////                        "Snapshot Has Error: ${snapshot.hasError.hashCode.toString()}");
////                  }
////                  break;
////                default:
////                  break;
////              }
////              return _containsImages
////                  ? InkWell(
////                child: Padding(
////                  padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
////                  child: Container(
////                    width: SizeConfig.blockSizeHorizontal * 100,
////                    child: Column(
////                      children: <Widget>[
////                        Row(
////                          mainAxisAlignment: MainAxisAlignment.start,
////                          crossAxisAlignment: CrossAxisAlignment.center,
////                          children: <Widget>[
////                            Container(
////                              width: SizeConfig.blockSizeHorizontal * 95,
////                              child: Row(
////                                mainAxisAlignment:
////                                MainAxisAlignment.start,
////                                crossAxisAlignment:
////                                CrossAxisAlignment.center,
////                                children: <Widget>[
////                                  Padding(
////                                    padding:
////                                    EdgeInsets.fromLTRB(5, 0, 5, 0),
////                                    child: CircleAvatar(
////                                      radius: 10.0,
////                                      backgroundImage:
////                                      NetworkImage(_userImageUrl),
////                                      backgroundColor: Colors.transparent,
////                                    ),
////                                  ),
////                                  answerUserName(),
////                                  answerUserRecommended(),
////                                  Padding(
////                                    padding: EdgeInsets.all(5),
////                                    child: Row(
////                                      children: <Widget>[
////                                        Padding(
////                                          padding: EdgeInsets.all(10),
////                                          child: InkWell(
////                                            child: Icon(
////                                              Icons.thumb_up,
////                                              color:
////                                              CupertinoColors.black,
////                                              size: 20,
////                                            ),
////                                            onTap: () {
////                                              print("Index: $index");
////                                              _answerSnapshot = snapshot
////                                                  ?.data
////                                                  ?.documents[index];
////                                              _isAnswerLiked =
////                                              _answerSnapshot[
////                                              "_isLiked"];
////                                              if (_isAnswerLiked) {
////                                                Firestore.instance
////                                                    .collection(
////                                                    "questionData")
////                                                    .document(questionID)
////                                                    .collection(
////                                                    "answerData")
////                                                    .document(
////                                                    _answerSnapshot[
////                                                    "_answerID"])
////                                                    .collection(
////                                                    "_userLikes")
////                                                    .getDocuments()
////                                                    .then((value) {
////                                                  _listOfDocumentID =
////                                                  new List();
////                                                  var documentsLength =
////                                                      value.documents
////                                                          .length;
////
////                                                  for (int i = 0;
////                                                  i < documentsLength;
////                                                  i++) {
////                                                    String documentID =
////                                                        value.documents[i]
////                                                            .documentID;
////                                                    _listOfDocumentID
////                                                        .add(documentID);
////                                                  }
////
////                                                  //---------------------------
////                                                  for (int i = 0;
////                                                  i <
////                                                      value.documents
////                                                          .length;
////                                                  i++) {
////                                                    _listOfDocumentID.add(
////                                                        value.documents[i]
////                                                            .documentID);
////                                                    if (_userId ==
////                                                        value.documents[i]
////                                                            .documentID) {
////                                                      if (value.documents[
////                                                      i]
////                                                      ["_isLiked"]) {
////                                                        _unlikeAnswer(
////                                                            questionID,
////                                                            _answerSnapshot[
////                                                            "_answerID"]);
////                                                      } else if (!value
////                                                          .documents[i]
////                                                      ["_isLiked"]) {
////                                                        _likeAnswer(
////                                                            questionID,
////                                                            _answerSnapshot[
////                                                            "_answerID"]);
////                                                      }
////                                                    }
////                                                  }
////
////                                                  if (!_listOfDocumentID
////                                                      .contains(
////                                                      _userId)) {
////                                                    _likeAnswer(
////                                                        questionID,
////                                                        _answerSnapshot[
////                                                        "_answerID"]);
////                                                  } else {
////                                                    print("Contains!");
////                                                  }
////                                                  //----------------------------
////                                                });
////                                              } else {
////                                                _likeAnswer(
////                                                    questionID,
////                                                    _answerSnapshot[
////                                                    "_answerID"]);
////                                              }
////                                            },
////                                          ),
////                                        ),
////                                        StreamBuilder(
////                                          stream: Firestore.instance
////                                              .collection("questionData")
////                                              .document(questionID)
////                                              .collection("answerData")
////                                              .document(_answerSnapshot[
////                                          "_answerID"])
////                                              .collection("_userLikes")
////                                              .where("_isLiked",
////                                              isEqualTo: true)
////                                              .snapshots(),
////                                          builder: (BuildContext context,
////                                              AsyncSnapshot<QuerySnapshot>
////                                              snap) {
////                                            switch (
////                                            snap.connectionState) {
////                                              case ConnectionState.active:
////                                                print(
////                                                    "Likes:: ${snap.data.documents.length.toString()}");
////                                                _likesCount = snap
////                                                    .data.documents.length
////                                                    .toString();
////                                                break;
////                                              case ConnectionState
////                                                  .waiting:
////                                                _likesCount = 0;
////                                                return CircularProgressIndicator();
////                                                break;
////                                              case ConnectionState.done:
////                                                _likesCount = 0;
////                                                break;
////                                              case ConnectionState.none:
////                                                _likesCount = 0;
////                                                return CircularProgressIndicator();
////                                                break;
////                                              default:
////                                                _likesCount = 0;
////                                                break;
////                                            }
////                                            return Text(
////                                              _likesCount,
////                                              style: TextStyle(
////                                                  fontWeight:
////                                                  FontWeight.w400,
////                                                  color: CupertinoColors
////                                                      .black,
////                                                  fontSize: 12),
////                                            );
////                                          },
////                                        )
////                                      ],
////                                    ),
////                                  )
////                                ],
////                              ),
////                            ),
////                          ],
////                        ),
////                        Padding(
////                            padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
////                            child: Container(
////                                width:
////                                SizeConfig.blockSizeHorizontal * 100,
////                                height: SizeConfig.blockSizeVertical * 15,
////                                child: Center(
////                                    child: ListView.builder(
////                                        shrinkWrap: true,
////                                        physics: PageScrollPhysics(),
////                                        addAutomaticKeepAlives: true,
////                                        cacheExtent: 20,
////                                        itemCount: _answerSnapshot[
////                                        "_numberOfImages"],
////                                        scrollDirection: Axis.horizontal,
////                                        itemBuilder:
////                                            (BuildContext context,
////                                            int i) {
////                                          print(
////                                              "questionImage: ${i.toString()}");
////                                          return Center(
////                                              child: Padding(
////                                                padding: EdgeInsets.fromLTRB(
////                                                    5, 0, 5, 0),
////                                                child: CachedNetworkImage(
////                                                  imageUrl: _answerSnapshot[
////                                                  "_answerImages"][i],
////                                                  placeholder: (context,
////                                                      url) =>
////                                                      CircularProgressIndicator(),
////                                                  errorWidget:
////                                                      (context, url, error) =>
////                                                      Icon(Icons.error),
////                                                ),
////                                              ));
////                                        })))),
////                        Padding(
////                            padding: EdgeInsets.all(10),
////                            child: Column(children: <Widget>[
////                              new AnimatedSize(
////                                  vsync: this,
////                                  duration:
////                                  const Duration(milliseconds: 500),
////                                  child: new ConstrainedBox(
////                                      constraints: isExpanded
////                                          ? new BoxConstraints()
////                                          : new BoxConstraints(
////                                          maxHeight: 200.0),
////                                      child: new Text(
////                                        _answerSnapshot["_answer"],
////                                        softWrap: true,
////                                        overflow: TextOverflow.fade,
////                                        style: GoogleFonts.poppins(
////                                            color: new Color(0xff323131),
////                                            fontSize: 14,
////                                            fontWeight: FontWeight.w400),
////                                      ))),
////                              isExpanded
////                                  ? new ConstrainedBox(
////                                  constraints: new BoxConstraints())
////                                  : new FlatButton(
////                                  child: Padding(
////                                    padding: EdgeInsets.all(10),
////                                    child: continueReading(),
////                                  ),
////                                  onPressed: () => setState(
////                                          () => isExpanded = true))
////                            ])),
////                        Padding(
////                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
////                          child: Divider(
////                            height: 2,
////                            color: greyColor,
////                          ),
////                        )
////                      ],
////                    ),
////                  ),
////                ),
////                onTap: () {
////                  // TODO
////                },
////              )
////                  : InkWell(
////                  onTap: () {
////                    // TODO
////                  },
////                  child: Padding(
////                    padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
////                    child: Container(
////                      width: SizeConfig.blockSizeHorizontal * 100,
//////                height: SizeConfig.blockSizeVertical * 50,
////                      child: Column(
////                        children: <Widget>[
////                          Row(
////                            mainAxisAlignment: MainAxisAlignment.start,
////                            crossAxisAlignment: CrossAxisAlignment.center,
////                            children: <Widget>[
////                              Container(
////                                width: SizeConfig.blockSizeHorizontal * 95,
////                                child: Row(
////                                  mainAxisAlignment:
////                                  MainAxisAlignment.start,
////                                  crossAxisAlignment:
////                                  CrossAxisAlignment.center,
////                                  children: <Widget>[
////                                    Padding(
////                                      padding:
////                                      EdgeInsets.fromLTRB(10, 0, 10, 0),
////                                      child: CircleAvatar(
////                                        radius: 20.0,
////                                        backgroundImage: NetworkImage(
////                                            _answerSnapshot[
////                                            "_userImageUrl"]),
////                                        backgroundColor: Colors.transparent,
////                                      ),
////                                    ),
////                                    answerUserName(),
////                                    answerUserRecommended(),
////                                    Padding(
////                                      padding: EdgeInsets.all(5),
////                                      child: Row(
////                                        children: <Widget>[
////                                          Padding(
////                                            padding: EdgeInsets.all(10),
////                                            child: InkWell(
////                                              child: Icon(
////                                                Icons.thumb_up,
////                                                color:
////                                                CupertinoColors.black,
////                                              ),
////                                              onTap: () {
////                                                print("Index: $index");
////                                                _answerSnapshot = snapshot
////                                                    ?.data
////                                                    ?.documents[index];
////                                                _isAnswerLiked =
////                                                _answerSnapshot[
////                                                "_isLiked"];
////                                                if (_isAnswerLiked) {
////                                                  Firestore.instance
////                                                      .collection(
////                                                      "questionData")
////                                                      .document(questionID)
////                                                      .collection(
////                                                      "answerData")
////                                                      .document(
////                                                      _answerSnapshot[
////                                                      "_answerID"])
////                                                      .collection(
////                                                      "_userLikes")
////                                                      .getDocuments()
////                                                      .then((value) {
////                                                    _listOfDocumentID =
////                                                    new List();
////                                                    //----------------------------------------
////                                                    var documentsLength =
////                                                        value.documents
////                                                            .length;
////
////                                                    for (int i = 0;
////                                                    i < documentsLength;
////                                                    i++) {
////                                                      String documentID =
////                                                          value.documents[i]
////                                                              .documentID;
////                                                      _listOfDocumentID
////                                                          .add(documentID);
////                                                    }
////
////                                                    for (int i = 0;
////                                                    i <
////                                                        value.documents
////                                                            .length;
////                                                    i++) {
////                                                      if (_userId ==
////                                                          value.documents[i]
////                                                              .documentID) {
////                                                        if (value.documents[
////                                                        i]
////                                                        ["_isLiked"]) {
////                                                          _unlikeAnswer(
////                                                              questionID,
////                                                              _answerSnapshot[
////                                                              "_answerID"]);
////                                                        } else if (!value
////                                                            .documents[i]
////                                                        ["_isLiked"]) {
////                                                          _likeAnswer(
////                                                              questionID,
////                                                              _answerSnapshot[
////                                                              "_answerID"]);
////                                                        }
////                                                      }
////                                                    }
////
////                                                    if (!_listOfDocumentID
////                                                        .contains(
////                                                        _userId)) {
////                                                      _likeAnswer(
////                                                          questionID,
////                                                          _answerSnapshot[
////                                                          "_answerID"]);
////                                                    } else {
////                                                      print("Contains!");
////                                                    }
////                                                    //----------------------------
////                                                  });
////                                                } else {
////                                                  _likeAnswer(
////                                                      questionID,
////                                                      _answerSnapshot[
////                                                      "_answerID"]);
////                                                }
////                                              },
////                                            ),
////                                          ),
////                                          StreamBuilder(
////                                            stream: Firestore.instance
////                                                .collection("questionData")
////                                                .document(questionID)
////                                                .collection("answerData")
////                                                .document(_answerSnapshot[
////                                            "_answerID"])
////                                                .collection("_userLikes")
////                                                .where("_isLiked",
////                                                isEqualTo: true)
////                                                .snapshots(),
////                                            builder: (BuildContext context,
////                                                AsyncSnapshot<QuerySnapshot>
////                                                snap) {
////                                              switch (
////                                              snap.connectionState) {
////                                                case ConnectionState.active:
////                                                  print(
////                                                      "Likes:: ${snap.data.documents.length.toString()}");
////                                                  _likesCount = snap
////                                                      .data.documents.length
////                                                      .toString();
////                                                  break;
////                                                case ConnectionState
////                                                    .waiting:
////                                                  _likesCount = 0;
////                                                  return CircularProgressIndicator();
////                                                  break;
////                                                case ConnectionState.done:
////                                                  _likesCount = 0;
////                                                  break;
////                                                case ConnectionState.none:
////                                                  _likesCount = 0;
////                                                  return CircularProgressIndicator();
////                                                  break;
////                                                default:
////                                                  _likesCount = 0;
////                                                  break;
////                                              }
////                                              return Text(
////                                                _likesCount,
////                                                style: TextStyle(
////                                                    fontWeight:
////                                                    FontWeight.w400,
////                                                    color: CupertinoColors
////                                                        .black,
////                                                    fontSize: 16),
////                                              );
////                                            },
////                                          )
////                                        ],
////                                      ),
////                                    )
////                                  ],
////                                ),
////                              ),
////                            ],
////                          ),
////                          SizedBox(),
////                          Padding(
////                              padding: EdgeInsets.all(10),
////                              child: Column(children: <Widget>[
////                                new AnimatedSize(
////                                    vsync: this,
////                                    duration:
////                                    const Duration(milliseconds: 500),
////                                    child: new ConstrainedBox(
////                                        constraints: isExpanded
////                                            ? new BoxConstraints()
////                                            : new BoxConstraints(
////                                            maxHeight: 200.0),
////                                        child: new Text(
////                                          _answerSnapshot["_answer"],
////                                          softWrap: true,
////                                          overflow: TextOverflow.fade,
////                                          style: GoogleFonts.poppins(
////                                              color: new Color(0xff323131),
////                                              fontSize: 14,
////                                              fontWeight: FontWeight.w400),
////                                        ))),
////                                isExpanded
////                                    ? new ConstrainedBox(
////                                    constraints: new BoxConstraints())
////                                    : new FlatButton(
////                                    child: Padding(
////                                      padding: EdgeInsets.all(10),
////                                      child: continueReading(),
////                                    ),
////                                    onPressed: () => setState(
////                                            () => isExpanded = true))
////                              ])),
////                          Padding(
////                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
////                            child: Divider(
////                              height: 2,
////                              color: greyColor,
////                            ),
////                          )
////                        ],
////                      ),
////                    ),
////                  ));
////            }
////          },
////        );
////      },
////    );
////  }
////
////  Widget answerUserName() {
////    return Text(
////      _answerSnapshot["_userName"],
////      style: GoogleFonts.poppins(
////          color: CupertinoColors.black,
////          fontSize: 12,
////          fontWeight: FontWeight.w500),
////    );
////  }
////
////  Widget answerUserRecommended() {
////    return Padding(
////      padding: EdgeInsets.all(5),
////      child: Text(
////        '- Recommended',
////        style: GoogleFonts.poppins(
////            color: CupertinoColors.inactiveGray,
////            fontSize: 8,
////            fontWeight: FontWeight.w400),
////      ),
////    );
////  }
////
////  Stream<DocumentSnapshot> getIsLiked(String answerID) {
////    return Firestore.instance
////        .collection('questionData')
////        .document(questionID)
////        .collection('answerData')
////        .document(answerID)
////        .collection('_userLikes')
////        .document(_userId)
////        .snapshots();
////  }
////
////  Widget continueReading() {
////    return Card(
////      clipBehavior: Clip.antiAlias,
////      elevation: 4,
////      shape: RoundedRectangleBorder(
////        borderRadius: BorderRadius.circular(30.0),
////      ),
////      child: Container(
////        color: CupertinoColors.white,
////        width: 150,
////        height: 40,
////        child: Center(
////          child: Padding(
////            padding: EdgeInsets.all(10),
////            child: Text(
////              'continue Reading..',
////              style: GoogleFonts.poppins(
////                  fontWeight: FontWeight.w400,
////                  color: CupertinoColors.black,
////                  fontSize: 12),
////            ),
////          ),
////        ),
////      ),
////    );
////  }
////
////  Widget questionImagesWidget(QuestionDetails questionDetails) {
////    return Padding(
////      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
////      child: Container(
////        width: SizeConfig.blockSizeHorizontal * 100,
////        height: SizeConfig.safeBlockVertical * 25,
////        child: Center(
////          child: ListView.builder(
////              scrollDirection: Axis.horizontal,
////              itemCount: questionDetails?.questionImages?.length,
////              itemBuilder: (context, index) {
////                return Center(
////                    child: Padding(
////                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
////                      child: CachedNetworkImage(
////                        imageUrl: questionDetails?.questionImages[index],
////                        placeholder: (context, url) => CircularProgressIndicator(),
////                        errorWidget: (context, url, error) => Icon(Icons.error),
////                      ),
////                    ));
////              }),
////        ),
////      ),
////    );
////  }
////
////  void _likeAnswer(String questionID, String answerID) {
////    print("LikeAnswer!");
////    Firestore.instance
////        .collection("questionData")
////        .document(questionID)
////        .collection("answerData")
////        .document(answerID)
////        .collection("_userLikes")
////        .document(_userId)
////        .setData({"_isLiked": true}, merge: true).whenComplete(() {
////      print("Liked!");
////      Firestore.instance
////          .collection("questionData")
////          .document(questionID)
////          .collection("answerData")
////          .document(answerID)
////          .updateData({"_isLiked": true}).whenComplete(() {
////        if (_listOfDocumentID != null) {
////          _listOfDocumentID.clear();
////        }
////        print("Liked!");
////      });
////    }).catchError((error) {
////      print("Error: $error");
////    });
////  }
////
////  _unlikeAnswer(String questionID, String answerID) {
////    print("unlikeAnswer!");
////    Firestore.instance
////        .collection("questionData")
////        .document(questionID)
////        .collection("answerData")
////        .document(answerID)
////        .collection("_userLikes")
////        .document(_userId)
////        .updateData({"_isLiked": false}).whenComplete(() {
////      print("UnLiked!");
////    }).catchError((error) {
////      print("Error: $error");
////    });
////  }
////}
//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:gst_application/provider/QuestionDetails.dart';
//import 'package:gst_application/provider/personal_information.dart';
//import 'package:gst_application/utils/SizeConfig.dart';
//import 'package:gst_application/views/add_answer_screen.dart';
//import 'package:provider/provider.dart';
//import 'package:circular_profile_avatar/circular_profile_avatar.dart';
//
//Color greyColor = new Color(0xffA2A2A2);
//Color lightGreyColor = new Color(0xffF3F3F3);
//Color textColor = new Color(0xffAEAEAE);
//Color backgroundColor = new Color(0xffF8F8F8);
//Widget answerWidget;
////ExpandableText(this.text)
////String text;
//bool isExpanded = false;
//ScrollController _scrollController = new ScrollController();
//
//bool _containsImages = false;
//int _numberOfImages = 0;
//int _numberOfLikes = 0;
//bool _isUserLikedAnswer = false;
//var _questionUserImage;
//List<dynamic> answersList = new List();
//bool _isOnTop = true;
//var _containsImage = false;
//
//String questionID;
//String _answer;
//String _answerImage;
//String _questionTimeStamp;
//String _answerTimeStamp;
//String _userImageUrl;
//String _userName;
//String _userId;
//String _answerID;
//
//Map<String, dynamic> _userLikesMap;
//
//List<dynamic> _likesList;
//bool _isAnswerLiked = false;
//DocumentSnapshot _answerSnapshot;
//
//List<String> _listOfDocumentID;
//int answersListLenght = 0;
//
//String sampleQuestion =
//    "What is the best online stock investigation tool for beginners in times of pandemic of Coronavirus ?";
////String sampleAnswer = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo";
//String answer =
//    "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet";
//
//class HomeScreenTwo extends StatefulWidget {
//  final DocumentSnapshot questionData;
//  HomeScreenTwo(this.questionData);
//  @override
//  _HomeScreenTwoState createState() => _HomeScreenTwoState(questionData);
//}
//
//class _HomeScreenTwoState extends State<HomeScreenTwo>
//    with TickerProviderStateMixin {
//  final DocumentSnapshot questionData;
//  var _isQuestionAnswered;
//  _HomeScreenTwoState(this.questionData);
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    isExpanded = false;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    var userDetails = Provider.of<UserDetails>(context);
//    _userId = userDetails.user_id;
//    print("User ID:: $_userId");
//    _containsImages = questionData.data['_containImages'];
//    print("Contains Images: ${_containsImages.toString()}");
//    return Scaffold(
//        resizeToAvoidBottomPadding: true,
//        appBar: AppBar(
//          backgroundColor: CupertinoColors.white,
//          leading: InkWell(
//            child: Icon(
//              Icons.arrow_back,
//              color: CupertinoColors.black,
//            ),
//            onTap: () {
//              Navigator.of(context).pop(true);
//            },
//          ),
//        ),
//        body: Padding(
//            padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
//            child: answersListWidget()));
//  }
//
//  _scrollToTop() {
//    _scrollController.animateTo(_scrollController.position.minScrollExtent,
//        duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
//    setState(() => _isOnTop = true);
//  }
//
//  _scrollToBottom() {
//    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
//        duration: Duration(milliseconds: 1000), curve: Curves.easeOut);
//    setState(() => _isOnTop = false);
//  }
//
//  Widget nameAndBookmarkWidget() {
//    questionID = questionData.documentID;
//    return Container(
//      width: SizeConfig.blockSizeHorizontal * 100,
//      height: SizeConfig.blockSizeVertical * 10,
//      child: Container(
//        width: SizeConfig.blockSizeHorizontal * 85,
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: [
//            Padding(
//              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
//              child: CircularProfileAvatar(
//                '${questionData.data['_userImageUrl']}',
//                radius: 20.0,
//                backgroundColor: Colors.grey,
//              ),
//            ),
//            Text(
//              '${questionData.data['_userName']}',
//              style: GoogleFonts.poppins(
//                  color: CupertinoColors.black,
//                  fontSize: 14,
//                  fontWeight: FontWeight.w500),
//            ),
//            // userNameWidget(name: name),
//            Padding(
//              padding: EdgeInsets.all(5),
//              child: Text(
//                '- Recommended for you',
//                style: GoogleFonts.poppins(
//                    color: CupertinoColors.inactiveGray,
//                    fontSize: 8,
//                    fontWeight: FontWeight.w400),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget questionWidget() {
//    return Padding(
//        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//        child: Expanded(
//          child: Text(
//            '${questionData.data['_question']}',
//            style: GoogleFonts.poppins(
//                color: CupertinoColors.black,
//                fontSize: 16,
//                fontStyle: FontStyle.normal,
//                fontWeight: FontWeight.w600),
//          ),
//        ));
//  }
//
//  Widget addAnswerWidget() {
//    return Padding(
//      padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
//      child: TextField(
//        showCursor: true,
////          readOnly: true,
//        onTap: () {
//          Navigator.of(context).push(MaterialPageRoute(
//              builder: (context) => AddNewAnswerScreen(
//                questionSnapshot: questionData,
//              )));
//        },
//        decoration: new InputDecoration(
//            prefixIcon: Icon(Icons.translate),
//            suffixIcon: Icon(Icons.filter),
//            disabledBorder: InputBorder.none,
//            border: OutlineInputBorder(
//                borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                borderSide: BorderSide.none),
//            filled: true,
//            hintStyle: GoogleFonts.poppins(
//                color: CupertinoColors.inactiveGray,
//                fontSize: 12,
//                fontWeight: FontWeight.w400),
//            hintText: "Share you answer...",
//            fillColor: new Color(0xffFFFFFF)),
//      ),
//    );
//  }
//
//  Widget answersListWidget() {
//    //questionID = questionDetails?.questionID;
//    return StreamBuilder(
//      stream: Firestore.instance
//          .collection("questionData")
//          .document(questionData.documentID)
//          .snapshots(),
//      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//        if (snapshot.connectionState == ConnectionState.done) {
//          print("Connection State Done!");
//        } else if (snapshot.connectionState == ConnectionState.active) {
//          print("Connection State Active!");
//          if (snapshot.hasData) {
//            print("Has Data");
//            _isQuestionAnswered = snapshot?.data["_isAnswered"];
//          } else if (snapshot.hasError) {
//            print("Error: ${snapshot.hasError.hashCode.toString()}");
//          } else {
//            print("No Data");
//          }
//        }
//        return _isQuestionAnswered
//            ? answersWidget()
//            : Center(
//          child: Text('No Answers Yet!',
//              style: GoogleFonts.poppins(
//                  fontSize: 18,
//                  color: CupertinoColors.black,
//                  fontWeight: FontWeight.w500)),
//        );
//      },
//    );
//  }
//
//  Widget answersWidget() {
//    var _likesCount;
//    return StreamBuilder(
//      stream: Firestore.instance
//          .collection("questionData")
//          .document(questionData.documentID)
//          .collection("answerData")
//          .snapshots(),
//      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//        switch (snapshot.connectionState) {
//          case ConnectionState.none:
//            answersListLenght = 0;
//            break;
//          case ConnectionState.done:
//            answersListLenght = 0;
//            break;
//          case ConnectionState.waiting:
//            answersListLenght = 0;
//            break;
//          case ConnectionState.active:
//            answersListLenght = snapshot?.data?.documents?.length;
//            break;
//          default:
//            answersListLenght = 0;
//            break;
//        }
//
//        return ListView.builder(
//          primary: true,
//          shrinkWrap: true,
//          physics: PageScrollPhysics(),
//          padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
//          itemCount: 1 + answersListLenght,
//          itemBuilder: (context, index) {
//            if (index == 0) {
//              return Expanded(
//                flex: 1,
//                child: Column(
//                  children: <Widget>[
//                    nameAndBookmarkWidget(),
//                    questionWidget(),
//                    addAnswerWidget()
//                  ],
//                ),
//              );
//            } else {
//              int numberOfExtraWidget = 1;
//              index = index - numberOfExtraWidget;
//
//              switch (snapshot.connectionState) {
//                case ConnectionState.none:
//                  print("Connection State None!");
//                  _userImageUrl = 'https://i.pravatar.cc/300';
//                  _containsImages = false;
//                  break;
//                case ConnectionState.done:
//                  print("Connection State Done!");
//                  _userImageUrl = 'https://i.pravatar.cc/300';
//                  _containsImages = false;
//                  break;
//                case ConnectionState.waiting:
//                  print("Connection State Waiting!");
//                  _userImageUrl = 'https://i.pravatar.cc/300';
//                  _containsImages = false;
//                  return CircularProgressIndicator();
//                  break;
//                case ConnectionState.active:
//                  print("Connection State Active!");
//                  if (snapshot.hasData) {
//                    print("Snapshot has data!");
//                    _answerSnapshot = snapshot?.data?.documents[index];
//                    // _answerImage = _answerSnapshot["_answerImage"];
//                    // _answerTimeStamp = _answerSnapshot["_answerTimeStamp"];
//                    // _userId = _answerSnapshot["_userID"];
//                    // _answerID = _answerSnapshot["_answerID"];
//                    _containsImages = _answerSnapshot["_containsImages"];
//                    _userImageUrl = _answerSnapshot["_userImageUrl"];
//
//                    print("Answer: $answer");
//                  } else if (snapshot.hasError) {
//                    print(
//                        "Snapshot Has Error: ${snapshot.hasError.hashCode.toString()}");
//                  }
//                  break;
//                default:
//                  break;
//              }
//              return _containsImages
//                  ? InkWell(
//                child: Padding(
//                  padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
//                  child: Container(
//                    width: SizeConfig.blockSizeHorizontal * 100,
//                    child: Column(
//                      children: <Widget>[
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          children: <Widget>[
//                            Container(
//                              width: SizeConfig.blockSizeHorizontal * 95,
//                              child: Row(
//                                mainAxisAlignment:
//                                MainAxisAlignment.start,
//                                crossAxisAlignment:
//                                CrossAxisAlignment.center,
//                                children: <Widget>[
//                                  Padding(
//                                    padding:
//                                    EdgeInsets.fromLTRB(5, 0, 5, 0),
//                                    child: CircleAvatar(
//                                      radius: 10.0,
//                                      backgroundImage:
//                                      NetworkImage(_userImageUrl),
//                                      backgroundColor: Colors.transparent,
//                                    ),
//                                  ),
//                                  answerUserName(),
//                                  answerUserRecommended(),
//                                  Padding(
//                                    padding: EdgeInsets.all(5),
//                                    child: Row(
//                                      children: <Widget>[
//                                        Padding(
//                                          padding: EdgeInsets.all(10),
//                                          child: InkWell(
//                                            child: Icon(
//                                              Icons.thumb_up,
//                                              color:
//                                              CupertinoColors.black,
//                                              size: 20,
//                                            ),
//                                            onTap: () {
//                                              print("Index: $index");
//                                              _answerSnapshot = snapshot
//                                                  ?.data
//                                                  ?.documents[index];
//                                              _isAnswerLiked =
//                                              _answerSnapshot[
//                                              "_isLiked"];
//                                              if (_isAnswerLiked) {
//                                                Firestore.instance
//                                                    .collection(
//                                                    "questionData")
//                                                    .document(questionID)
//                                                    .collection(
//                                                    "answerData")
//                                                    .document(
//                                                    _answerSnapshot[
//                                                    "_answerID"])
//                                                    .collection(
//                                                    "_userLikes")
//                                                    .getDocuments()
//                                                    .then((value) {
//                                                  _listOfDocumentID =
//                                                  new List();
//                                                  var documentsLength =
//                                                      value.documents
//                                                          .length;
//
//                                                  for (int i = 0;
//                                                  i < documentsLength;
//                                                  i++) {
//                                                    String documentID =
//                                                        value.documents[i]
//                                                            .documentID;
//                                                    _listOfDocumentID
//                                                        .add(documentID);
//                                                  }
//
//                                                  //---------------------------
//                                                  for (int i = 0;
//                                                  i <
//                                                      value.documents
//                                                          .length;
//                                                  i++) {
//                                                    _listOfDocumentID.add(
//                                                        value.documents[i]
//                                                            .documentID);
//                                                    if (_userId ==
//                                                        value.documents[i]
//                                                            .documentID) {
//                                                      if (value.documents[
//                                                      i]
//                                                      ["_isLiked"]) {
//                                                        _unlikeAnswer(
//                                                            questionID,
//                                                            _answerSnapshot[
//                                                            "_answerID"]);
//                                                      } else if (!value
//                                                          .documents[i]
//                                                      ["_isLiked"]) {
//                                                        _likeAnswer(
//                                                            questionID,
//                                                            _answerSnapshot[
//                                                            "_answerID"]);
//                                                      }
//                                                    }
//                                                  }
//
//                                                  if (!_listOfDocumentID
//                                                      .contains(
//                                                      _userId)) {
//                                                    _likeAnswer(
//                                                        questionID,
//                                                        _answerSnapshot[
//                                                        "_answerID"]);
//                                                  } else {
//                                                    print("Contains!");
//                                                  }
//                                                  //----------------------------
//                                                });
//                                              } else {
//                                                _likeAnswer(
//                                                    questionID,
//                                                    _answerSnapshot[
//                                                    "_answerID"]);
//                                              }
//                                            },
//                                          ),
//                                        ),
//                                        StreamBuilder(
//                                          stream: Firestore.instance
//                                              .collection("questionData")
//                                              .document(questionID)
//                                              .collection("answerData")
//                                              .document(_answerSnapshot[
//                                          "_answerID"])
//                                              .collection("_userLikes")
//                                              .where("_isLiked",
//                                              isEqualTo: true)
//                                              .snapshots(),
//                                          builder: (BuildContext context,
//                                              AsyncSnapshot<QuerySnapshot>
//                                              snap) {
//                                            switch (
//                                            snap.connectionState) {
//                                              case ConnectionState.active:
//                                                print(
//                                                    "Likes:: ${snap.data.documents.length.toString()}");
//                                                _likesCount = snap
//                                                    .data.documents.length
//                                                    .toString();
//                                                break;
//                                              case ConnectionState
//                                                  .waiting:
//                                                _likesCount = 0;
//                                                return CircularProgressIndicator();
//                                                break;
//                                              case ConnectionState.done:
//                                                _likesCount = 0;
//                                                break;
//                                              case ConnectionState.none:
//                                                _likesCount = 0;
//                                                return CircularProgressIndicator();
//                                                break;
//                                              default:
//                                                _likesCount = 0;
//                                                break;
//                                            }
//                                            return Text(
//                                              _likesCount,
//                                              style: TextStyle(
//                                                  fontWeight:
//                                                  FontWeight.w400,
//                                                  color: CupertinoColors
//                                                      .black,
//                                                  fontSize: 12),
//                                            );
//                                          },
//                                        )
//                                      ],
//                                    ),
//                                  )
//                                ],
//                              ),
//                            ),
//                          ],
//                        ),
//                        Padding(
//                            padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
//                            child: Container(
//                                width:
//                                SizeConfig.blockSizeHorizontal * 100,
//                                height: SizeConfig.blockSizeVertical * 15,
//                                child: Center(
//                                    child: ListView.builder(
//                                        shrinkWrap: true,
//                                        physics: PageScrollPhysics(),
//                                        addAutomaticKeepAlives: true,
//                                        cacheExtent: 20,
//                                        itemCount: _answerSnapshot[
//                                        "_numberOfImages"],
//                                        scrollDirection: Axis.horizontal,
//                                        itemBuilder:
//                                            (BuildContext context,
//                                            int i) {
//                                          print(
//                                              "questionImage: ${i.toString()}");
//                                          return Center(
//                                              child: Padding(
//                                                padding: EdgeInsets.fromLTRB(
//                                                    5, 0, 5, 0),
//                                                child: CachedNetworkImage(
//                                                  imageUrl: _answerSnapshot[
//                                                  "_answerImages"][i],
//                                                  placeholder: (context,
//                                                      url) =>
//                                                      CircularProgressIndicator(),
//                                                  errorWidget:
//                                                      (context, url, error) =>
//                                                      Icon(Icons.error),
//                                                ),
//                                              ));
//                                        })))),
//                        Padding(
//                            padding: EdgeInsets.all(10),
//                            child: Column(children: <Widget>[
//                              new AnimatedSize(
//                                  vsync: this,
//                                  duration:
//                                  const Duration(milliseconds: 500),
//                                  child: new ConstrainedBox(
//                                      constraints: isExpanded
//                                          ? new BoxConstraints()
//                                          : new BoxConstraints(
//                                          maxHeight: 200.0),
//                                      child: new Text(
//                                        _answerSnapshot["_answer"],
//                                        softWrap: true,
//                                        overflow: TextOverflow.fade,
//                                        style: GoogleFonts.poppins(
//                                            color: new Color(0xff323131),
//                                            fontSize: 14,
//                                            fontWeight: FontWeight.w400),
//                                      ))),
//                              isExpanded
//                                  ? new ConstrainedBox(
//                                  constraints: new BoxConstraints())
//                                  : new FlatButton(
//                                  child: Padding(
//                                    padding: EdgeInsets.all(10),
//                                    child: continueReading(),
//                                  ),
//                                  onPressed: () => setState(
//                                          () => isExpanded = true))
//                            ])),
//                        Padding(
//                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//                          child: Divider(
//                            height: 2,
//                            color: greyColor,
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//                onTap: () {
//                  // TODO
//                },
//              )
//                  : InkWell(
//                  onTap: () {
//                    // TODO
//                  },
//                  child: Padding(
//                    padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
//                    child: Container(
//                      width: SizeConfig.blockSizeHorizontal * 100,
////                height: SizeConfig.blockSizeVertical * 50,
//                      child: Column(
//                        children: <Widget>[
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            children: <Widget>[
//                              Container(
//                                width: SizeConfig.blockSizeHorizontal * 95,
//                                child: Row(
//                                  mainAxisAlignment:
//                                  MainAxisAlignment.start,
//                                  crossAxisAlignment:
//                                  CrossAxisAlignment.center,
//                                  children: <Widget>[
//                                    Padding(
//                                      padding:
//                                      EdgeInsets.fromLTRB(10, 0, 10, 0),
//                                      child: CircleAvatar(
//                                        radius: 20.0,
//                                        backgroundImage: NetworkImage(
//                                            _answerSnapshot[
//                                            "_userImageUrl"]),
//                                        backgroundColor: Colors.transparent,
//                                      ),
//                                    ),
//                                    answerUserName(),
//                                    answerUserRecommended(),
//                                    Padding(
//                                      padding: EdgeInsets.all(5),
//                                      child: Row(
//                                        children: <Widget>[
//                                          Padding(
//                                            padding: EdgeInsets.all(10),
//                                            child: InkWell(
//                                              child: Icon(
//                                                Icons.thumb_up,
//                                                color:
//                                                CupertinoColors.black,
//                                              ),
//                                              onTap: () {
//                                                print("Index: $index");
//                                                _answerSnapshot = snapshot
//                                                    ?.data
//                                                    ?.documents[index];
//                                                _isAnswerLiked =
//                                                _answerSnapshot[
//                                                "_isLiked"];
//                                                if (_isAnswerLiked) {
//                                                  Firestore.instance
//                                                      .collection(
//                                                      "questionData")
//                                                      .document(questionID)
//                                                      .collection(
//                                                      "answerData")
//                                                      .document(
//                                                      _answerSnapshot[
//                                                      "_answerID"])
//                                                      .collection(
//                                                      "_userLikes")
//                                                      .getDocuments()
//                                                      .then((value) {
//                                                    _listOfDocumentID =
//                                                    new List();
//                                                    //----------------------------------------
//                                                    var documentsLength =
//                                                        value.documents
//                                                            .length;
//
//                                                    for (int i = 0;
//                                                    i < documentsLength;
//                                                    i++) {
//                                                      String documentID =
//                                                          value.documents[i]
//                                                              .documentID;
//                                                      _listOfDocumentID
//                                                          .add(documentID);
//                                                    }
//
//                                                    for (int i = 0;
//                                                    i <
//                                                        value.documents
//                                                            .length;
//                                                    i++) {
//                                                      if (_userId ==
//                                                          value.documents[i]
//                                                              .documentID) {
//                                                        if (value.documents[
//                                                        i]
//                                                        ["_isLiked"]) {
//                                                          _unlikeAnswer(
//                                                              questionID,
//                                                              _answerSnapshot[
//                                                              "_answerID"]);
//                                                        } else if (!value
//                                                            .documents[i]
//                                                        ["_isLiked"]) {
//                                                          _likeAnswer(
//                                                              questionID,
//                                                              _answerSnapshot[
//                                                              "_answerID"]);
//                                                        }
//                                                      }
//                                                    }
//
//                                                    if (!_listOfDocumentID
//                                                        .contains(
//                                                        _userId)) {
//                                                      _likeAnswer(
//                                                          questionID,
//                                                          _answerSnapshot[
//                                                          "_answerID"]);
//                                                    } else {
//                                                      print("Contains!");
//                                                    }
//                                                    //----------------------------
//                                                  });
//                                                } else {
//                                                  _likeAnswer(
//                                                      questionID,
//                                                      _answerSnapshot[
//                                                      "_answerID"]);
//                                                }
//                                              },
//                                            ),
//                                          ),
//                                          StreamBuilder(
//                                            stream: Firestore.instance
//                                                .collection("questionData")
//                                                .document(questionID)
//                                                .collection("answerData")
//                                                .document(_answerSnapshot[
//                                            "_answerID"])
//                                                .collection("_userLikes")
//                                                .where("_isLiked",
//                                                isEqualTo: true)
//                                                .snapshots(),
//                                            builder: (BuildContext context,
//                                                AsyncSnapshot<QuerySnapshot>
//                                                snap) {
//                                              switch (
//                                              snap.connectionState) {
//                                                case ConnectionState.active:
//                                                  print(
//                                                      "Likes:: ${snap.data.documents.length.toString()}");
//                                                  _likesCount = snap
//                                                      .data.documents.length
//                                                      .toString();
//                                                  break;
//                                                case ConnectionState
//                                                    .waiting:
//                                                  _likesCount = 0;
//                                                  return CircularProgressIndicator();
//                                                  break;
//                                                case ConnectionState.done:
//                                                  _likesCount = 0;
//                                                  break;
//                                                case ConnectionState.none:
//                                                  _likesCount = 0;
//                                                  return CircularProgressIndicator();
//                                                  break;
//                                                default:
//                                                  _likesCount = 0;
//                                                  break;
//                                              }
//                                              return Text(
//                                                _likesCount,
//                                                style: TextStyle(
//                                                    fontWeight:
//                                                    FontWeight.w400,
//                                                    color: CupertinoColors
//                                                        .black,
//                                                    fontSize: 16),
//                                              );
//                                            },
//                                          )
//                                        ],
//                                      ),
//                                    )
//                                  ],
//                                ),
//                              ),
//                            ],
//                          ),
//                          SizedBox(),
//                          Padding(
//                              padding: EdgeInsets.all(10),
//                              child: Column(children: <Widget>[
//                                new AnimatedSize(
//                                    vsync: this,
//                                    duration:
//                                    const Duration(milliseconds: 500),
//                                    child: new ConstrainedBox(
//                                        constraints: isExpanded
//                                            ? new BoxConstraints()
//                                            : new BoxConstraints(
//                                            maxHeight: 200.0),
//                                        child: new Text(
//                                          _answerSnapshot["_answer"],
//                                          softWrap: true,
//                                          overflow: TextOverflow.fade,
//                                          style: GoogleFonts.poppins(
//                                              color: new Color(0xff323131),
//                                              fontSize: 14,
//                                              fontWeight: FontWeight.w400),
//                                        ))),
//                                isExpanded
//                                    ? new ConstrainedBox(
//                                    constraints: new BoxConstraints())
//                                    : new FlatButton(
//                                    child: Padding(
//                                      padding: EdgeInsets.all(10),
//                                      child: continueReading(),
//                                    ),
//                                    onPressed: () => setState(
//                                            () => isExpanded = true))
//                              ])),
//                          Padding(
//                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//                            child: Divider(
//                              height: 2,
//                              color: greyColor,
//                            ),
//                          )
//                        ],
//                      ),
//                    ),
//                  ));
//            }
//          },
//        );
//      },
//    );
//  }
//
//  Widget answerUserName() {
//    return Text(
//      _answerSnapshot["_userName"],
//      style: GoogleFonts.poppins(
//          color: CupertinoColors.black,
//          fontSize: 12,
//          fontWeight: FontWeight.w500),
//    );
//  }
//
//  Widget answerUserRecommended() {
//    return Padding(
//      padding: EdgeInsets.all(5),
//      child: Text(
//        '- Recommended',
//        style: GoogleFonts.poppins(
//            color: CupertinoColors.inactiveGray,
//            fontSize: 8,
//            fontWeight: FontWeight.w400),
//      ),
//    );
//  }
//
//  Stream<DocumentSnapshot> getIsLiked(String answerID) {
//    return Firestore.instance
//        .collection('questionData')
//        .document(questionID)
//        .collection('answerData')
//        .document(answerID)
//        .collection('_userLikes')
//        .document(_userId)
//        .snapshots();
//  }
//
//  Widget continueReading() {
//    return Card(
//      clipBehavior: Clip.antiAlias,
//      elevation: 4,
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(30.0),
//      ),
//      child: Container(
//        color: CupertinoColors.white,
//        width: 150,
//        height: 40,
//        child: Center(
//          child: Padding(
//            padding: EdgeInsets.all(10),
//            child: Text(
//              'continue Reading..',
//              style: GoogleFonts.poppins(
//                  fontWeight: FontWeight.w400,
//                  color: CupertinoColors.black,
//                  fontSize: 12),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//
//  Widget questionImagesWidget(QuestionDetails questionDetails) {
//    return Padding(
//      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//      child: Container(
//        width: SizeConfig.blockSizeHorizontal * 100,
//        height: SizeConfig.safeBlockVertical * 25,
//        child: Center(
//          child: ListView.builder(
//              scrollDirection: Axis.horizontal,
//              itemCount: questionDetails?.questionImages?.length,
//              itemBuilder: (context, index) {
//                return Center(
//                    child: Padding(
//                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
//                      child: CachedNetworkImage(
//                        imageUrl: questionDetails?.questionImages[index],
//                        placeholder: (context, url) => CircularProgressIndicator(),
//                        errorWidget: (context, url, error) => Icon(Icons.error),
//                      ),
//                    ));
//              }),
//        ),
//      ),
//    );
//  }
//
//  void _likeAnswer(String questionID, String answerID) {
//    print("LikeAnswer!");
//    Firestore.instance
//        .collection("questionData")
//        .document(questionID)
//        .collection("answerData")
//        .document(answerID)
//        .collection("_userLikes")
//        .document(_userId)
//        .setData({"_isLiked": true}, merge: true).whenComplete(() {
//      print("Liked!");
//      Firestore.instance
//          .collection("questionData")
//          .document(questionID)
//          .collection("answerData")
//          .document(answerID)
//          .updateData({"_isLiked": true}).whenComplete(() {
//        if (_listOfDocumentID != null) {
//          _listOfDocumentID.clear();
//        }
//        print("Liked!");
//      });
//    }).catchError((error) {
//      print("Error: $error");
//    });
//  }
//
//  _unlikeAnswer(String questionID, String answerID) {
//    print("unlikeAnswer!");
//    Firestore.instance
//        .collection("questionData")
//        .document(questionID)
//        .collection("answerData")
//        .document(answerID)
//        .collection("_userLikes")
//        .document(_userId)
//        .updateData({"_isLiked": false}).whenComplete(() {
//      print("UnLiked!");
//    }).catchError((error) {
//      print("Error: $error");
//    });
//  }
//}
//
//if (_paths != null) {
//if (_paths.length != 0) {
//Firestore.instance
//    .collection("questionData")
//    .document(questionID)
//    .collection("answerData")
//    .document(_answerID)
//    .updateData({
//"_containsImages": true,
//}).whenComplete(() {
//Firestore.instance
//    .collection("questionData")
//    .document(questionID)
//    .collection("answerData")
//    .document(_answerID)
//    .setData({
//"_numberOfImages": _paths.length,
//}, merge: true).whenComplete(() {
//Firestore.instance
//    .collection("questionData")
//    .document(questionID)
//    .collection("answerData")
//    .document(_answerID)
//    .setData({
//"_answerID": _answerID,
//}, merge: true).whenComplete(() => {
//Firestore.instance
//    .collection("questionData")
//    .document(questionID)
//    .collection("answerData")
//    .document(_answerID)
//    .setData({"_isLiked": false},
//merge: true).whenComplete(() {
//uploadToFirebase(questionID, _answerID);
//}).catchError((error) {
//print("Error: $error");
//})
//});
//}).catchError((_) {
//print("Error: $_");
//});
//}).catchError((error) {
//print("Error: $error");
//});
//} else if (_paths.length == 0) {
//Firestore.instance
//    .collection("questionData")
//    .document(questionID)
//    .collection("answerData")
//    .document(_answerID)
//    .updateData({"_containsImages": false}).whenComplete(() {
//Firestore.instance
//    .collection("questionData")
//    .document(questionID)
//    .collection("answerData")
//    .document(_answerID)
//    .setData({
//"_answerID": _answerID,
//}, merge: true).whenComplete(() => {
//Firestore.instance
//    .collection("questionData")
//    .document(questionID)
//    .collection("answerData")
//    .document(_answerID)
//    .setData({"_isLiked": false},
//merge: true).whenComplete(() {
//if (_paths != null) {
//_paths.clear();
//}
//Navigator.of(context).pop();
//}).catchError((error) {
//print("Error: $error");
//})
//});
//}).catchError((error) {
//print("Error: $error");
//});
//}
//} else {
//Firestore.instance
//    .collection("questionData")
//    .document(questionID)
//    .collection("answerData")
//    .document(_answerID)
//    .updateData({"_containsImages": false}).catchError((error) {
//print("Error: $error");
//});
//}
//}).whenComplete(() {
//_firestoreInstance
//    .collection("questionData")
//    .document(questionID)
//    .updateData({"_latestAnswer": answer}).whenComplete(() {
//_firestoreInstance
//    .collection('questionData')
//    .document(questionID)
//    .updateData({
//"_isAnswered": true,
//}).whenComplete(() {
//Firestore.instance
//    .collection("questionData")
//    .document(questionID)
//    .collection("answerData")
//    .document(_answerID)
//    .setData({
//"_answerID": _answerID,
//}, merge: true).whenComplete(() => {
//Firestore.instance
//    .collection("questionData")
//    .document(questionID)
//    .collection("answerData")
//    .document(_answerID)
//    .setData({"_isLiked": false}, merge: true).whenComplete(
//() {
//Navigator.of(context).pop(answer);
//_answerEditingController.clear();
//
//print("questionPostComplete!");
//}).catchError((error) {
//print("Error: $error");
//})
//});
//}).catchError((error) => print("Error: $error.toString()"));
//}).catchError((error) {
//print("Error: $error");
//});
//}).catchError((error) {
//print("Error: $error");
//});
