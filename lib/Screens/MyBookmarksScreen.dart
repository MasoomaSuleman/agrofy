//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:circular_profile_avatar/circular_profile_avatar.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:get/get.dart';
//
////added Dependencies
//import 'package:google_fonts/google_fonts.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:gst_application/Models/Question.dart';
//import 'package:gst_application/main.dart';
//import 'package:gst_application/provider/user_details.dart';
//
////app dependencies
//import 'package:gst_application/utils/SizeConfig.dart';
//import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
//import 'package:provider/provider.dart';
//import '../utils/TimeStamp.dart';
//import '../loading.dart';
//import 'AddAnswer/AddAnswerScreen.dart';
//import 'Home/ui_components/QuestionCard.dart';
//import 'QuestionDetailsScreen.dart';
//import 'otherUserProfile.dart';
//import 'package:timeago/timeago.dart' as timeago;
//
//bool _isBookmarked = true;
//bool isAnswered = true;
//
//bool isMultipleImages = false;
//
//final _firestore = Firestore.instance;
//
//class MyBookmarksScreen extends StatefulWidget {
//  final String uid;
//  MyBookmarksScreen({@required this.uid});
//  @override
//  _MyBookmarksScreenState createState() => _MyBookmarksScreenState();
//}
//
//class _MyBookmarksScreenState extends State<MyBookmarksScreen> {
//  CollectionReference questionData =
//      Firestore.instance.collection('questionData');
//  Query query;
//  bool isBookmarked = true;
//  // var myBookMarkedQ;
//  Padding buildBookmarks() {
//    var userDetails = Provider.of<UserDetails>(context);
//
//    return Padding(
//      padding: const EdgeInsets.all(0.0),
//      child: Container(
//        decoration: BoxDecoration(
//          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0)),
//        ),
//        child: Container(
//            child: FutureBuilder(
//          // stream: bookmarkQStream,
//          future: questionData
//              .where('bookmarks', arrayContains: userDetails.user_id)
//              .getDocuments(),
//          builder: (context, snapshot) {
//            if (!snapshot.hasData) {
//              return Center(child: CircularProgressIndicator());
//            } else {
//              return ListView.builder(
//                physics: ClampingScrollPhysics(),
//                itemCount: snapshot.data.documents.length,
//                shrinkWrap: true,
//                itemBuilder: (context, index) {
//                  print("=============INDEX$index");
//                  DocumentSnapshot docSnap = snapshot.data.documents[index];
//                  // myBookMarkedQ = docSnap['bookmarks'] ?? [];
//
//                  // Event event = Event.fromDocument(docSnap);
//                  // return eventTemplate2(context, event);
//                  // Question question= Question.fromSnapshot(docSnap),
//                  return QuestionCard(
//                      questionData: docSnap, size: MediaQuery.of(context).size);
//                  // return Get.find();
//                },
//              );
//            }
//          },
//        )),
//      ),
//    );
//  }
//
////  user= FirebaseAuth.instance.user;
//  // Stream bookmarkQStream = Firestore.instance
//  //     .collection('questionData')
//  //     .where('bookmarks', arrayContains: )
//  //     .snapshots();
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    // call function to get the stream of bookmarked questions here
//    //isLoading = true;
//  }
//
//  Widget questionCard(DocumentSnapshot questionData) {
//    var userDetails = Provider.of<UserDetails>(context);
//
//    String _latestAnswer;
//    if (questionData["latestAnswerText"] == null)
//      _latestAnswer = "No Answers Yet";
//    else
//      _latestAnswer = questionData["latestAnswerText"];
//    return InkWell(
//      onTap: () {
//        pushNewScreen(
//          context,
//          screen: QuestionDetailsScreen(questionData),
//          withNavBar: false,
//          pageTransitionAnimation: PageTransitionAnimation.cupertino,
//        );
//      },
//      child: Padding(
//        padding: EdgeInsets.all(5),
//        child: Card(
//            clipBehavior: Clip.antiAlias,
//            elevation: 4,
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(15.0),
//            ),
//            child: Container(
//              color: CupertinoColors.white,
//              width: SizeConfig.blockSizeHorizontal * 100,
////                          height: SizeConfig.blockSizeVertical * 55,
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.start,
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Container(
//                    width: SizeConfig.blockSizeHorizontal * 100,
////                                height: SizeConfig.blockSizeVertical * 22,
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        Container(
//                          width: SizeConfig.blockSizeHorizontal * 72,
////                                      height: SizeConfig.blockSizeVertical * 20,
//                          color: CupertinoColors.white,
//                          child: Column(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            children: <Widget>[
//                              Container(
//                                width: SizeConfig.blockSizeHorizontal * 90,
////                                            height: SizeConfig.blockSizeVertical * 7,
//                                color: CupertinoColors.white,
//                                child: Padding(
//                                  padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
//                                  child: GestureDetector(
//                                    onTap: () {
//                                      //TODO: go to other person profile
//                                      pushNewScreen(
//                                        context,
//                                        screen: OtherUserProfile(
//                                          uid: userDetails.user_id,
//                                          otherUserUid:
//                                              questionData['questionByUID'],
//                                        ),
//                                        withNavBar: false,
//                                        pageTransitionAnimation:
//                                            PageTransitionAnimation.cupertino,
//                                      );
//                                    },
//                                    child: Row(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.start,
//                                      crossAxisAlignment:
//                                          CrossAxisAlignment.start,
//                                      children: <Widget>[
//                                        Padding(
//                                          padding: EdgeInsets.all(4),
//                                          child: CircularProfileAvatar(
//                                            '${questionData['questionByImageURL'] ?? ''}',
//                                            radius: 15.0,
//                                            borderWidth: 0,
//                                            elevation: 0,
//                                            backgroundColor: Colors.grey,
//                                          ),
//                                        ),
//                                        Padding(
//                                          padding:
//                                              EdgeInsets.fromLTRB(5, 0, 2, 0),
//                                          child: Column(
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.start,
//                                            children: [
//                                              Text(
//                                                questionData['questionByName'],
//                                                style: GoogleFonts.poppins(
//                                                    color:
//                                                        CupertinoColors.black,
//                                                    fontSize: 13,
//                                                    fontWeight:
//                                                        FontWeight.w500),
//                                              ),
//                                              Text(
//                                                questionData[
//                                                    'questionByProfession'],
//                                                style: GoogleFonts.poppins(
//                                                    color: CupertinoColors.black
//                                                        .withOpacity(.5),
//                                                    fontSize: 10),
//                                              ),
//                                            ],
//                                          ),
//                                        ),
//                                        Padding(
//                                          // TODO: Timestamp to be converterd now
//                                          // timestamp is to be converted right now
//                                          padding:
//                                              EdgeInsets.fromLTRB(0, 4, 5, 0),
//                                          child: Text(
//                                            //  '${questionData['questionTimeStamp']}',
//                                            " - " +
//                                                '${timeago.format(DateTime.parse(questionData['questionTimeStamp']))}',
//                                            style: GoogleFonts.poppins(
//                                                color: CupertinoColors
//                                                    .inactiveGray,
//                                                fontSize: 8,
//                                                fontWeight: FontWeight.w400),
//                                          ),
//                                        )
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                              ),
//                              Container(
//                                width: SizeConfig.blockSizeHorizontal * 90,
////                                            height: SizeConfig.blockSizeVertical * 12,
//                                color: CupertinoColors.white,
//                                child: Padding(
//                                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
//                                  child: Flexible(
//                                    child: RichText(
//                                      maxLines: 3,
//                                      overflow: TextOverflow.ellipsis,
//                                      text: TextSpan(
//                                          text: questionData['questionText'],
//                                          style: GoogleFonts.poppins(
//                                              color: CupertinoColors.black,
//                                              fontSize: 14,
//                                              fontStyle: FontStyle.normal,
//                                              fontWeight: FontWeight.w600)),
//                                    ),
//                                  ),
//                                ),
//                              )
//                            ],
//                          ),
//                        ),
//                        Container(
//                          width: SizeConfig.blockSizeHorizontal * 13,
////                                      height: SizeConfig.blockSizeVertical * 20,
//                          color: CupertinoColors.white,
//                          child: Column(
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              Container(
//                                height: 35,
//                                width: 35,
//                                alignment: Alignment.center,
//                                margin: EdgeInsets.all(10),
//                                padding: EdgeInsets.all(5),
//                                decoration: BoxDecoration(
//                                    color: Colors.grey.withOpacity(.2),
//                                    borderRadius:
//                                        BorderRadius.all(Radius.circular(5))),
//                                // child: InkWell(
//                                //     onTap: () {
//                                //       setState(() {
//                                //         isBookmarked = !isBookmarked;
//                                //       });
//                                //     },
//                                //     child: myBookMarkedQ.contains(userID)
//                                //         ? Icon(
//                                //             Icons.bookmark,
//                                //             size: 20,
//                                //           )
//                                //         : Icon(
//                                //             Icons.bookmark_border,
//                                //             size: 20,
//                                //           )),
//                              ),
//                              InkWell(
//                                child: Container(
//                                  height: 35,
//                                  width: 35,
//                                  alignment: Alignment.center,
//                                  margin: EdgeInsets.only(left: 10),
//                                  padding: EdgeInsets.all(5),
//                                  decoration: BoxDecoration(
//                                      color: Colors.grey.withOpacity(.2),
//                                      borderRadius:
//                                          BorderRadius.all(Radius.circular(5))),
//                                  child: Text(
//                                    'A',
//                                    style: TextStyle(
//                                        decoration: TextDecoration.underline,
//                                        fontSize: 18),
//                                  ),
//                                ),
//                                onTap: () {
//                                  // go to the new add answer screen
//
//                                  pushNewScreen(
//                                    context,
//                                    screen: AddAnswerScreen(
//                                      questionData,
//                                    ),
//                                    withNavBar:
//                                        false, // OPTIONAL VALUE. True by default.
//                                    pageTransitionAnimation:
//                                        PageTransitionAnimation.cupertino,
//                                  );
//                                },
//                              )
//                            ],
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                  (questionData["questionImages"] == "" ||
//                          questionData["questionImages"].length == 0 ||
//                          questionData["questionImages"] == null)
//                      ? Container()
//                      : Padding(
//                          padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
//                          child: Container(
//                            width: SizeConfig.blockSizeHorizontal * 100,
//                            height: SizeConfig.blockSizeVertical * 15,
//                            child: Center(
//                              child: ListView.builder(
//                                shrinkWrap: true,
//                                physics: ClampingScrollPhysics(),
//                                addAutomaticKeepAlives: true,
//                                cacheExtent: 20,
//                                itemCount:
//                                    questionData['questionImages'].length,
//                                scrollDirection: Axis.horizontal,
//                                itemBuilder: (BuildContext context, int i) {
//                                  print(
//                                      "questionImages=========>>>: ${i.toString()}");
//                                  return Center(
//                                      child: Padding(
//                                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
//                                    child: CachedNetworkImage(
//                                      imageUrl: questionData["questionImages"]
//                                          [i]['url'],
//                                      placeholder: (context, url) =>
//                                          CircularProgressIndicator(),
//                                      errorWidget: (context, url, error) =>
//                                          Icon(Icons.error),
//                                    ),
//                                  ));
//                                },
//                              ),
//                            ),
//                          ),
//                        ),
//                  Container(
//                    width: SizeConfig.blockSizeHorizontal * 100,
////                                height: SizeConfig.blockSizeVertical * 12,
//                    color: CupertinoColors.white,
//                    child: Padding(
//                      padding: EdgeInsets.all(15),
//                      child: Text(
//                        "$_latestAnswer",
//                        maxLines: 4,
//                        overflow: TextOverflow.ellipsis,
//                        style: GoogleFonts.poppins(
//                            color: new Color(0xff323131),
//                            fontSize: 14,
//                            fontWeight: FontWeight.w400),
//                      ),
//                    ),
//                  )
//                ],
//              ),
//            )),
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    Size size = MediaQuery.of(context).size;
//    return SafeArea(
//        child: Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.lightGreen[900],
//        leading: IconButton(
//          icon: Icon(
//            Icons.arrow_back,
//            color: Colors.white,
//          ),
//          onPressed: () {
//            Navigator.pop(context);
//          },
//        ),
//        centerTitle: true,
//        title: Text(
//          "My Bookmarks",
//          style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
//        ),
//      ),
//      body: buildBookmarks(),
//    ));
//  }
//}
