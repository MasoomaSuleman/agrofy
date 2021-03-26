import 'package:flutter/material.dart';
// added dependencies
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kisaanCorner/Screens/QuestionDetails/ui_components/FullScreenImageView.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kisaanCorner/provider/user_details.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

// app dependencies
import 'package:kisaanCorner/Screens/AddAnswer/AddAnswerScreen.dart';
import 'QuestionImages.dart';

class QuestionDetails extends StatefulWidget {
  final DocumentSnapshot questionData;
  final Size _size;
  final Function homeScreenSetStateCall;
  QuestionDetails(this.questionData, this._size, this.homeScreenSetStateCall);

  @override
  _QuestionDetailsState createState() => _QuestionDetailsState();
}

class _QuestionDetailsState extends State<QuestionDetails> {
  getBookmarks() async {
    await Firestore.instance
        .collection("questionData")
        .document(widget.questionData.documentID)
        .get()
        .then((value) {
      setState(() {
        myBookMarkedQ = value?.data['bookmarks'] ?? [];
      });

      print(value?.data);
    });
    // myBookMarkedQ = widget?.questionData['bookmarks'] ?? [];
    print("myBookmaeked q === $myBookMarkedQ");
    return myBookMarkedQ;
  }

  @override
  void initState() {
    getBookmarks();

    super.initState();
    print(" in Question Details..... init State==========");
  }

  void bookmarkQuestion(DocumentSnapshot questionData) async {
    print(
        "--------------------------Question BookMarked------------------------------");
    await Firestore.instance
        .collection("questionData")
        .document(questionData.documentID)
        .updateData(
      {"bookmarks": myBookMarkedQ, "isQBookmarked": true},
    );
    this.widget.homeScreenSetStateCall();
  }

  void unbookmarkQuestion(DocumentSnapshot questionData) async {
    // setState(() {});
    print(
        "------------------------Question unBookMarked---------------------------------");
    await Firestore.instance
        .collection("questionData")
        .document(questionData.documentID)
        .updateData(
      {"bookmarks": myBookMarkedQ, "isQBookmarked": false},
    );
    this.widget.homeScreenSetStateCall();
  }

  var myBookMarkedQ = [];
  bool isQuestionBookmarked = false;

  @override
  Widget build(BuildContext context) {
    // getBookmarks();

    final userDetails = Provider.of<UserDetails>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(4.0),
          width: widget._size.width,
          height: widget._size.height * 0.07,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProfileAvatar(
                '${widget.questionData.data['questionByImageURL']}',
                radius: 15,
                backgroundColor: Colors.grey,
                //TODO: Add a default image avatar if imaage not there
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: '${widget.questionData.data['questionByName']}',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: "  - " +
                          '${timeago.format(DateTime.parse(widget.questionData['questionTimeStamp']))}',
                      style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    )
                  ])),
                  Text(
                    '${widget.questionData.data['questionByProfession']}',
                    style: GoogleFonts.poppins(
                        color: Colors.black54,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Container(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (myBookMarkedQ.contains(userDetails.user_id)) {
                        myBookMarkedQ.remove(userDetails.user_id);
                        unbookmarkQuestion(widget.questionData);
                        isQuestionBookmarked = false;
                        print(
                            "inside if:::::::::::::::::::::::$isQuestionBookmarked::::::::::::");
                        // Icon(
                        //   Icons.bookmark,
                        //   size: 20,
                        // );
                      } else {
                        myBookMarkedQ.add(userDetails.user_id);
                        bookmarkQuestion(widget.questionData);
                        isQuestionBookmarked = true;
                        print(
                            ":::::::::::::::::::::::$isQuestionBookmarked::::::::::::");

                        // Icon(
                        //   Icons.bookmark_border,
                        //   size: 20,
                        // );
                      }

                      print(
                          "=========Bookmarked value is: $isQuestionBookmarked=========");
                    });
                  },
                  child: myBookMarkedQ.contains(userDetails.user_id)
                      ? Center(
                          child: Icon(
                            Icons.bookmark,
                            size: 20,
                            color: Color(0xff707070),
                          ),
                        )
                      : Center(
                          child: Icon(
                          Icons.bookmark_border,
                          size: 20.0,
                          color: Color(0xff707070),
                        )),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: widget._size.width - 20,
          child: Text(
            '${widget.questionData.data['questionText']}',
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FullScreenImageView(widget.questionData)));
          },
          child: Hero(
            tag: 'questionImages_tag',
            child: QuestionImages(
                widget.questionData.data['questionImages'], widget._size),
          ),
        ),
        //questionImagesWidget(),
        SizedBox(
          height: 10.0,
        ),
        Material(
          elevation: 2.0,
          child: Container(
            height: 40.0,
            width: widget._size.width - 24,
            child: TextField(
              showCursor: true,
//          readOnly: true,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddAnswerScreen(
                          widget.questionData,
                        )));
              },
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      'assets/images/ic_format_color_text_24px.svg',
                      height: 5.0,
                      width: 5.0,
                    ),
                  ),
                  disabledBorder: InputBorder.none,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide.none),
                  filled: true,
                  hintStyle: GoogleFonts.poppins(
                    color: Color(0xff393939),
                    fontSize: 9,
                  ),
                  hintText: "Share you answer...",
                  fillColor: new Color(0xffFFFFFF)),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Container(
                width: 80.0,
                height: 30.0,
                child: Center(
                  child: Text(
                    '${widget.questionData["replyCount"]} replies',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Color(0xffdfdfdf),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
              ),
            ),
            Expanded(child: Container())
          ],
        ),
        SizedBox(
          height: 5.0,
        )
      ],
    );
  }

  Widget questionImagesWidget() {
    // traverse throufght the array of images
    List<dynamic> _questionImagesList = [];
    _questionImagesList = widget.questionData.data['questionImages'];
    return _questionImagesList.length == 0
        ? Container()
        : Container(
            width: widget._size.width - 20,
            height: widget._size.height * 0.2,
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                addAutomaticKeepAlives: true,
                cacheExtent: 20,
                itemCount: widget.questionData['questionImages'].length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int i) {
                  return Center(
                      child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: CachedNetworkImage(
                      imageUrl: widget.questionData["questionImages"][i]['url'],
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ));
                },
              ),
            ),
          );
  }
}
