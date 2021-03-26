import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//added dependencies
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisaanCorner/Screens/AddAnswer/AddAnswerScreen.dart';
import 'package:kisaanCorner/Screens/OtherUsersFollowersScreen.dart';
import 'package:kisaanCorner/Screens/OtherUsersFollowingScreen.dart';
import 'package:kisaanCorner/utils/SizeConfig.dart';
import 'package:kisaanCorner/utils/TimeStamp.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:timeago/timeago.dart' as timeago;

// app deoeddencies
import '../loading.dart';
import '../constants.dart';
import '../Models/FollowModel.dart';
import '../Models/Question.dart';
import '../Screens/QuestionDetailsScreen.dart';
import 'package:kisaanCorner/Screens/Home/ui_components/QuestionCard.dart';

bool isLoading = true;
bool fetchquestions = true;
bool fetchfollowers = true;
bool fetchfollowing = true;
bool isFollowing = false;

var myBookmarked = [];

Firestore _firestore = Firestore.instance;

class OtherUserProfile extends StatefulWidget {
  final String uid;
  final String otherUserUid;
  OtherUserProfile({this.uid, this.otherUserUid});
  @override
  _OtherUserProfileState createState() =>
      _OtherUserProfileState(uid, otherUserUid);
}

class _OtherUserProfileState extends State<OtherUserProfile> {
  final String uid;
  final String otherUserUid;

  _OtherUserProfileState(this.uid, this.otherUserUid);

  // create a funstion to get user details call in inti function
  String _followId;
  String otherUserName;
  String otherUserImage;
  String otherUserProfession;
  String thisUserName;
  String thisUserImage;
  String thisUserProfession;
  int otherUserQuestionsCount;
  //funtion to get all the details

  int _questionsAskedCount = 0;
  int _followersCount = 0;
  int _followingCount = 0;

  Stream _stream;
  void getStream() {
    _stream = Firestore.instance
        .collection('questionData')
        .where('questionByUID', isEqualTo: otherUserUid)
        .snapshots();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    fetchquestions = true;
    fetchfollowers = true;
    fetchfollowing = true;
    getDetails();
    getStream();
    //retrieveMyBookmarked();
  }

//  void retrieveMyBookmarked() {
//    // for now the userDetails uid may be null as the provider has not been initialized yey_firestore
//    _firestore
//        .collection('userData')
//        .document('${this.widget.uid}')
//        .collection('bookmarks')
//        .getDocuments()
//        .then((value) {
//      if (value.documents.isEmpty) {
//        // do nothing
//      } else {
//        value.documents.forEach((element) {
//          myBookmarked.add(element.documentID);
//        });
//        print(
//            "OtherUserProfiel()''': List of bookmarks ${myBookmarked[0].toString()}");
//      }
//    });
//  }

  void getDetails() async {
    // get name, profession, question count, followeercount, following count
    _firestore.collection('userData').document(uid).get().then((value) {
      thisUserName = value.data['fullName'];
      thisUserImage = value.data['profileImageUrl'];
      thisUserProfession = value.data['profession'];

      _firestore
          .collection('userData')
          .document(otherUserUid)
          .get()
          .then((value2) {
        otherUserName = value2.data['fullName'];
        otherUserImage = value2.data['profileImageURl'];
        otherUserProfession = value2.data['profession'];
        _firestore
            .collection('followData')
            .where('uidUserFollower', isEqualTo: uid)
            .where('uidUserFollowing', isEqualTo: otherUserUid)
            .getDocuments()
            .then((onValue) {
          // execute another query for folower count and following count and questions asked
          _firestore
              .collection('questionData')
              .where('questionByUID', isEqualTo: otherUserUid)
              .getDocuments()
              .then((value3) {
            _questionsAskedCount = value3.documents.length;
            setState(() {
              fetchquestions = false;
            });
          });
          _firestore
              .collection('followData')
              .where('uidUserFollowing', isEqualTo: otherUserUid)
              .getDocuments()
              .then((value4) {
            _followingCount = value4.documents.length;
            setState(() {
              fetchfollowing = false;
            });
          });
          _firestore
              .collection('followData')
              .where('uidUserFollower', isEqualTo: otherUserUid)
              .getDocuments()
              .then((value5) {
            _followersCount = value5.documents.length;
            setState(() {
              fetchfollowers = false;
            });
          });

          if (onValue.documents.isEmpty) {
            setState(() {
              isLoading = false;
            });
          } else {
            _followId = onValue.documents[0].documentID;
            print("The follow id is $_followId");
            setState(() {
              isLoading = false;
            });
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return (isLoading || fetchquestions || fetchfollowers || fetchfollowing)
        ? LoadingFullScreen()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                "User Profile",
                style: GoogleFonts.poppins(color: Colors.black),
              ),
            ),
            backgroundColor: Color(0xFFF8F8F8),
            body: SingleChildScrollView(
              child: Container(
                child: Column(children: [
                  Container(
                    height: size.height * 0.40,
                    width: size.width,
                    color: Color(0xFFE9E9E9),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              CircularProfileAvatar(
                                '$otherUserImage',
                                radius: (size.height * 0.2) * 0.3,
                                borderWidth: 0,
                                elevation: 0,
                                backgroundColor: Colors.grey,
                              ),
                              Text(
                                "$otherUserName",
                                style: GoogleFonts.poppins(color: Colors.black),
                              ),
                              Text(
                                "$otherUserProfession",
                                style: GoogleFonts.poppins(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "$_questionsAskedCount",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Questions",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OtherUsersFollowingScreen(
                                            uid: otherUserUid,
                                          ))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "$_followersCount",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "Followers",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OtherUsersFollowersScreen(
                                              uid: otherUserUid,
                                            ))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "$_followingCount",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "Following",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        //add a button
                        (this.widget.uid == this.widget.otherUserUid)
                            ? Container()
                            : ((_followId?.isEmpty ?? true)
                                ? onClickFollow(
                                    thisUserImage,
                                    thisUserName,
                                    thisUserProfession,
                                    otherUserProfession,
                                    otherUserName,
                                    this.widget.uid,
                                    this.widget.otherUserUid,
                                    otherUserImage,
                                    size)
                                : onClickUnFollow(_followId, size)),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 40,
                    color: Color(0xFFF8F8F8),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Text(
                        "Asked Questions",
                        style: GoogleFonts.poppins(fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Divider(
                      thickness: 2.0,
                      color: Colors.black54,
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: _stream,
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
                      if (!snapshot.hasData) {
                        return Text("No Posts by this user");
                      }
                      return (snapshot.data.documents.isEmpty)
                          ? Center(child: Text("No Posts by this user"))
                          : Container(
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot questionsData =
                                      snapshot.data.documents[index];
                                  print(
                                      "OtherUserProfile()''': Calling questions tile with ${snapshot.data.documents[index].documentID}");
                                  return QuestionCard(
                                      questionData: questionsData, size: size);
                                },
                              ),
                            );
                    },
                  )
                ]),
              ),
            ),
          );
  }

  Widget onClickFollow(
      String imageUserFollower,
      String nameUserFollower,
      String professionUserFollower,
      String professionUserFollowing,
      String nameUserFollowing,
      String uidUserFollower,
      String uidUserFollowing,
      String imageUserFollowing,
      Size size) {
    FollowModel _toPass = FollowModel();
    // create a model class for follow request
    _toPass.uidUserFollower = uidUserFollower;
    _toPass.nameUserFollower = nameUserFollower;
    _toPass.imageUserFollower = imageUserFollower;
    _toPass.professionUserFollower = professionUserFollower;
    _toPass.uidUserFollowing = uidUserFollowing;
    _toPass.nameUserFollowing = nameUserFollowing;
    _toPass.imageUserFollowing = imageUserFollowing;
    _toPass.professionUserFollowing = professionUserFollowing;
    return Container(
      width: size.width * 0.8,
      height: 40.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: RaisedButton(
          onPressed: () {
            // add a follow request data here
            _firestore
                .collection("followData")
                .add(_toPass.toMapFollowing())
                .then((value) {
              // call the function to setstate and udate the button
              setState(() {
                _followId = value.documentID;
              });
            });
          },
          child: Text(
            "Follow",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          color: kPrimaryButton,
        ),
      ),
    );
  }

  Widget onClickUnFollow(String followId, Size size) {
    return Container(
      width: size.width * 0.8,
      height: 40.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FlatButton(
          onPressed: () {
            // add a follow request data here
            _firestore
                .collection("followData")
                .document(followId)
                .delete()
                .then((value) {
              // call the function to setstate and udate the button
              setState(() {
                _followId = null;
              });
            });
          },
          child: Text(
            "Unfollow",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          color: kPrimaryButton,
        ),
      ),
    );
  }
}

class questionCard extends StatefulWidget {
  final String uid;
  final DocumentSnapshot questionData;
  questionCard({this.questionData, this.uid});

  @override
  _questionCardState createState() => _questionCardState(questionData);
}

class _questionCardState extends State<questionCard> {
  bool _isBookmarked = false;
  var answer;
  final DocumentSnapshot questionData;
  _questionCardState(this.questionData);
  @override
  Widget build(BuildContext context) {
//    int postedTime = questionsData['_timeStamp'];
    List<dynamic> imagesList = questionData['questionImages'];
    int _numberOfImages = imagesList?.length;
    String _latestAnswer;
    if (questionData["latestAnswerText"] == null)
      _latestAnswer = "No Answers Yet";
    else
      _latestAnswer = questionData["latestAnswerText"];
    return InkWell(
      onTap: () {
        pushNewScreen(
          context,
          screen: QuestionDetailsScreen(questionData),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              color: CupertinoColors.white,
              width: SizeConfig.blockSizeHorizontal * 100,
//                          height: SizeConfig.blockSizeVertical * 55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
//                                height: SizeConfig.blockSizeVertical * 22,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 72,
//                                      height: SizeConfig.blockSizeVertical * 20,
                          color: CupertinoColors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 90,
//                                            height: SizeConfig.blockSizeVertical * 7,
                                color: CupertinoColors.white,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(4),
                                        child: CircularProfileAvatar(
                                          '${questionData['questionByImageURL']}',
                                          radius: 15.0,
                                          borderWidth: 0,
                                          elevation: 0,
                                          backgroundColor: Colors.grey,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 0, 5, 0),
                                        child: Text(
                                          questionData['questionByName'],
                                          style: GoogleFonts.poppins(
                                              color: CupertinoColors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Padding(
                                        //TODO: Timestamp to be converterd now
                                        // timestamp is to be converted right now
                                        padding:
                                            EdgeInsets.fromLTRB(5, 0, 5, 0),
                                        child: Text(
                                          //  '${questionData['questionTimeStamp']}',
                                          '${timeago.format(DateTime.parse(questionData['questionTimeStamp']))}',
                                          style: GoogleFonts.poppins(
                                              color:
                                                  CupertinoColors.inactiveGray,
                                              fontSize: 8,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 90,
//                                            height: SizeConfig.blockSizeVertical * 12,
                                color: CupertinoColors.white,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                  child: Flexible(
                                    child: RichText(
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                          text: questionData['questionText'],
                                          style: GoogleFonts.poppins(
                                              color: CupertinoColors.black,
                                              fontSize: 14,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 13,
//                                      height: SizeConfig.blockSizeVertical * 20,
                          color: CupertinoColors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: InkWell(
                                    onTap: () {},
                                    child: _isBookmarked
                                        ? Icon(Icons.bookmark)
                                        : Icon(Icons.bookmark_border)),
                              ),
                              InkWell(
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Icon(
                                    Icons.edit,
                                    color: new Color(0xff939393),
                                  ),
                                ),
                                onTap: () {
                                  pushNewScreen(
                                    context,
                                    screen: AddAnswerScreen(
                                      questionData,
                                    ),
                                    withNavBar:
                                        false, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  questionData["containsImage"]
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                          child: Container(
                              width: SizeConfig.blockSizeHorizontal * 100,
                              height: SizeConfig.blockSizeVertical * 15,
                              child: Center(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      addAutomaticKeepAlives: true,
                                      cacheExtent: 20,
                                      itemCount: _numberOfImages,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        print("questionImage: ${i.toString()}");
                                        return Center(
                                            child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 0, 5, 0),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                questionData["questionImages"]
                                                    [i],
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ));
                                      }))))
                      : SizedBox(),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
//                                height: SizeConfig.blockSizeVertical * 12,
                    color: CupertinoColors.white,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "$_latestAnswer",
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: new Color(0xff323131),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget onClickBookmark(
    String qid,
    DocumentSnapshot questionData,
  ) {
    Question _toPass = Question();
    _toPass.isAnswered = questionData['_isAnswered'];
    // for latest answer
//    _toPass.question = questionData['_question'];
////    _toPass.questionImage = questionData['_questionImage'];
//    _toPass.timeStamp = questionData['_timeStamp'];
//    _toPass.userID = questionData['_userID'];
//    _toPass.userImageUrl = questionData['_userImageUrl'];
//    _toPass.userName = questionData['_userName'];
//    _toPass.userProfession = questionData['_userProfession'];

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: IconButton(
        icon: Icon(Icons.bookmark_border),
        onPressed: () {
          // as this is not a part of the bookmarks list save it to bookmarks
          _firestore
              .collection('userData')
              .document(this.widget.uid)
              .collection('bookmarks')
              .document(questionData.documentID)
              .setData(_toPass.toMap())
              .then((value) {
            // the question has been bookmarked update in ui and list above
            this.setState(() {
              _isBookmarked = true;
            });
          });
        },
      ),
    );
  }

  Widget onClickUnBookmark(
    String qid,
  ) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: IconButton(
        icon: Icon(Icons.bookmark),
        onPressed: () {
          // as this is already bookmarked remove from bookmarks
          _firestore
              .collection('userData')
              .document(this.widget.uid)
              .collection('bookmarks')
              .document('$qid')
              .delete()
              .then((value) {
            // the question has been unbookmarked now update in ui also
            this.setState(() {
              _isBookmarked = false;
            });
          });
        },
      ),
    );
  }
}
