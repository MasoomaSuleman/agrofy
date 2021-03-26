import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisaanCorner/Screens/AddAnswer/ui_components/FullScreenImageView.dart';
import 'package:kisaanCorner/Screens/otherUserProfile.dart';
import 'package:kisaanCorner/src/constants.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/view/home/widgets/filter_bottom_sheet.dart';
import 'package:kisaanCorner/src/view/home/widgets/other_user/other_user_landing_page.dart';
import 'package:kisaanCorner/src/view/home/widgets/question_details/answer_main_listing.dart';
import 'package:kisaanCorner/src/view/home/widgets/question_details/filter_sheet.dart';
import 'package:kisaanCorner/src/view/home/widgets/question_details/question_image.dart';
import 'package:kisaanCorner/src/view/home/widgets/questions_card/question_files.dart';
import 'package:kisaanCorner/src/view/home/widgets/questions_card/question_images.dart';
import 'package:kisaanCorner/src/view/home/widgets/user_profile_image.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'question_toolbar.dart';
class QuestionDetailsLandingScreen extends StatefulWidget {
  final DocumentSnapshot questionData;
  QuestionDetailsLandingScreen({
    @required this.questionData,
  });
  @override
  _QuestionDetailsLandingScreenState createState() => _QuestionDetailsLandingScreenState();
}

class _QuestionDetailsLandingScreenState extends State<QuestionDetailsLandingScreen>
     {
  FilterSheet _filterSheet;
  void callSetStateOFHome() {
    this.setState(() {
      print("The questionMiainScreen()''': is getting rebuilt");
    });
  }
  
  void initState() {
      
      _filterSheet =
          FilterSheet(callSetStateOFHome: callSetStateOFHome);
      super.initState();
    }
  String getNameToDisplay(String name) {
    if (name.length >= 15) {
      // split the name by spaces
      List nameTemp = name.split(" ");
      String second = nameTemp[1];
      String nameToReturn = '${nameTemp[0]}' + ' ${second[0]}';
      // print the first name
      return nameToReturn;
      // print the initials of the remaining name

    } else
      return name;
  }
  @override
  Widget build(BuildContext context) {
    print(_filterSheet.selectedAllFiltersMap['relevant']);
    print(_filterSheet.selectedAllFiltersMap['latest']);
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[900],
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop(true);
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          (widget.questionData.data['category']!=null&&widget.questionData.data['category']!=-1)?"${categories[widget.questionData.data['category']].name}":"Not sure",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
        ),
        actions: <Widget>[
           IconButton(
                        icon: Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _filterSheet.showFilterBottomSheet(context);

                          //open question details filter list
                        }),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          // add name, profession and the image url here
          SizedBox(
            height: 18.0,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 16,
              ),
              UserProfileImage(
                  widget.questionData['questionByImageURL'], 18.0),
              SizedBox(
                width: 4.0,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>OtherUsersProfileLandingPage(
                        uid: Provider.of<User>(context, listen: false)
                        .userId,
                        otherUserUid:
                            widget.questionData['questionByUID'],
                        ), ));
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            '${getNameToDisplay(widget.questionData.data['questionByName'])}' +
                                //             '${widget.questionData.data['questionByName']} '
                                ' (${widget.questionData['questionByProfession']})',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '${widget.questionData.data['questionByProfession']}',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              
            ],
          ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: RichText(
              maxLines: 30,
              overflow: TextOverflow.ellipsis,
              text:
              TextSpan(
                text:  '${widget.questionData.data['questionText']}',
                 style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                children:[
                  TextSpan(
                  text: '  - ${timeago.format(DateTime.parse(widget.questionData['questionTimeStamp']))}',
                  style: GoogleFonts.poppins(
                      color: Colors.grey, fontSize: 10),
                  ),
                  
                ]
              )
            ) 
          ),
          GestureDetector(
            onTap: (){
               Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FullScreenImageView(widget.questionData)));
            },
                      child: QuestionImages(
              questionImagesList: widget.questionData['questionImages'],
              size: _size,
            ),
          ),
          /*for(int i=0;i<widget.questionData['questionImages'].length;i++)
          QuestionImage(
          questionImagesList: widget.questionData['questionImages'],
          size: _size,
          index: i,
          ),*/
          QuestionFiles(
            questionFile: widget.questionData['questionPdf'],
            
          ),
          SizedBox(
            height: 10,
          ),
          QuestionDetailsToolbar(pagecontext: context,questionData: widget.questionData,),
          SizedBox(
            height: 15,
          ),
          AnswerMainListing(questionData: widget.questionData,
          relevant: _filterSheet.selectedAllFiltersMap['relevant'],
          latest: _filterSheet.selectedAllFiltersMap['latest'],)
        ]
      )
    );
  }

}