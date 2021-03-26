import 'package:flutter/material.dart';

// added dependencies
import 'package:provider/provider.dart';

// app dependencies
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/network/bookmark_functionality.dart';

class BookmarkButton extends StatefulWidget {
  final String questionId;
  final bool forDetails;
  BookmarkButton({
    this.questionId,
    @required this.forDetails
  });
  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  List<String> myBookmarksList;
  BookmarkFunctionality _bookmarkFunctionality = BookmarkFunctionality();

  // get list of my bookmarks right now

  bool getIsBookmarked() {
    if (myBookmarksList.contains(widget.questionId)) {
//      print(
//          "BookmarkButton()''': getIsBookmarked()''': the provider list is ${myBookmarksList.toString()}");
      return true;
    } else
      return false;
  }

  // get details in provider
  // create a function to check wheter this is my bookmarked or not

  @override
  Widget build(BuildContext context) {
    myBookmarksList = Provider.of<User>(context).bookmarkList;
    String _userId = Provider.of<User>(context).userId;
//    print(
//        "BookmarkButton()''': build()''': the provider list is ${myBookmarksList.toString()}");
    return getIsBookmarked()
        ? (widget.forDetails? IconButton(
              padding: EdgeInsets.all(0.0),
              alignment: Alignment.bottomCenter,
              icon: Icon(Icons.bookmark,color: Colors.grey, size: 16),
              onPressed: (){
                print("BookmarkButton()''': bookark this question");
                // call function to unbookmark this question
                setState(() {
                  _bookmarkFunctionality.unBookmarkQuestion(
                      widget.questionId, _userId, context);
                  // widget.callSetStateOfQuestionCard();
                });
              }
            ): GestureDetector(
            onTap: () {
              print("BookmarkButton()''': bookark this question");
              // call function to unbookmark this question
              setState(() {
                _bookmarkFunctionality.unBookmarkQuestion(
                    widget.questionId, _userId, context);
                // widget.callSetStateOfQuestionCard();
              });
            },
            child: Container(
              child:  Icon(Icons.bookmark, size: 25, color: Color(0xFFFA5B5B)),
            ),
          ))
        :(widget.forDetails? IconButton(
              padding: EdgeInsets.all(0.0),
              alignment: Alignment.bottomCenter,
              icon: Icon(Icons.bookmark_border,color: Colors.grey, size: 16),
              onPressed: (){

                print("BookmarkButton()''': bookark this question");
                // call function to unbookmark this question

                setState(() {
                  _bookmarkFunctionality.bookmarkQuestion(
                      widget.questionId, _userId, context);
                  //widget.callSetStateOfQuestionCard();
                });
              }
            ): GestureDetector(
            onTap: () {
              // call function to bookmark this question Id

              print("BookmarkButton()''': bookark this question");
              // call function to unbookmark this question

              setState(() {
                _bookmarkFunctionality.bookmarkQuestion(
                    widget.questionId, _userId, context);
                //widget.callSetStateOfQuestionCard();
              });
            },
            child: Container(
              child: Icon(Icons.bookmark_border,
                  size: 25, color: Color(0xFFFA5B5B)),
            ),
          ));
  }
}
