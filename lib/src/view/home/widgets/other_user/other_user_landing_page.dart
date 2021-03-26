import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/Models/FollowModel.dart';
import 'package:kisaanCorner/Screens/OtherUsersFollowersScreen.dart';
import 'package:kisaanCorner/Screens/OtherUsersFollowingScreen.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/view/home/widgets/other_user/onClickFollow.dart';
import 'package:kisaanCorner/src/view/home/widgets/other_user/onClickUnfollow.dart';
import 'package:kisaanCorner/src/view/home/widgets/other_user/other_user_contribution.dart';
import 'package:kisaanCorner/src/view/home/widgets/other_user/other_user_professional_details.dart';
import 'package:kisaanCorner/src/view/my_followers_following/following_screen.dart';
import 'package:kisaanCorner/src/view/my_followers_following/my_followers_screen.dart';
import 'package:kisaanCorner/src/view/my_profile/personal_information/widgets/custom_tile.dart';
import 'package:provider/provider.dart';

bool isLoading = true;
bool fetchquestions = true;
bool fetchfollowers = true;
bool fetchfollowing = true;
bool isFollowing = false;
bool isProfileLoading=true;
var myBookmarked = [];

Firestore _firestore = Firestore.instance;
class OtherUsersProfileLandingPage extends StatefulWidget {
  final String uid;
  final String otherUserUid;
  OtherUsersProfileLandingPage({
    @required this.otherUserUid,
    @required this.uid
    });

  @override
  _OtherUsersProfileLandingPageState createState() => _OtherUsersProfileLandingPageState();
}

class _OtherUsersProfileLandingPageState extends State<OtherUsersProfileLandingPage> {
  // create a funstion to get user details call in inti function
  bool _professional=true;
  bool _contribution=false;
  String _followId;
  String otherUserName;
  String otherUserImage;
  String otherUserProfession;
  
  int otherUserQuestionsCount;
  String otherUserOrganization;
  String otherUserWebsite;
  String otherUserAboutme;
  List otherUserAchievementList;
  List otherUserExperienceList;
  var myProvider;
  //funtion to get all the details

  int _questionsAskedCount = 0;
  int _followersCount = 0;
  int _followingCount = 0;
  void onClickFollowSetState(var followid){
    getOtherUserFollowing();
    getOtherUserFollower();
    setState(() {
      _followId=followid;
    });
    myProvider.addFollowingCount();
  }
  void onClickUnFollowSetState(){
    getOtherUserFollowing();
    getOtherUserFollower();
    setState(() {
      _followId=null;
    });
    myProvider.subFollowingCount();
  }
  Stream _stream;
  void getStream() {
    _stream = Firestore.instance
        .collection('questionData')
        .where('questionByUID', isEqualTo: widget.otherUserUid)
        .snapshots();
  }
  void getDetails() async {
    // get name, profession, question count, followeercount, following count
    _firestore
      .collection('userData')
      .document(widget.otherUserUid)
      .get()
      .then((value2) {

        print(value2.data);
    otherUserName = value2.data['fullName'];
    otherUserImage = value2.data['profileImageUrl'];
    otherUserProfession = value2.data['profession'];
    otherUserOrganization= value2.data['organization'];
    otherUserWebsite=value2.data['website'];
    otherUserAboutme=value2.data['aboutMe'];
    otherUserAchievementList = value2.data['achievementList'];
    otherUserExperienceList=value2.data['experienceList'];
    setState(() {
      isProfileLoading=false;
    });
    });
  }
  void otherUserQuestionCountFunction() async{
    _firestore
        .collection('questionData')
        .where('questionByUID', isEqualTo: widget.otherUserUid)
        .getDocuments()
        .then((value3) {
      _questionsAskedCount = value3.documents.length;
      setState(() {
        fetchquestions = false;
      });
    });
  }

  void getOtherUserFollowing() async{
    _firestore
        .collection('followData')
        .where('uidUserFollowing', isEqualTo: widget.otherUserUid)
        .getDocuments()
        .then((value4) {
      _followingCount = value4.documents.length;
      setState(() {
        fetchfollowing = false;
      });
       
       _firestore.collection("userData").document(widget.otherUserUid).updateData({
          'followersCount': _followingCount,
        });
    });

  }
  void getOtherUserFollower() async{

    _firestore
        .collection('followData')
        .where('uidUserFollower', isEqualTo: widget.otherUserUid)
        .getDocuments()
        .then((value5) {
      _followersCount = value5.documents.length;
      setState(() {
        fetchfollowers = false;
      });

     _firestore.collection("userData").document(widget.otherUserUid).updateData({
        'followingCount': _followersCount,
      });
    });
  }
  void getOtherUserDetails() async{

      _firestore
          .collection('followData')
          .where('uidUserFollower', isEqualTo: widget.uid)
          .where('uidUserFollowing', isEqualTo: widget.otherUserUid)
          .getDocuments()
          .then((onValue) {
        // execute another query for folower count and following count and questions asked
        
        

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
    getOtherUserDetails();
    getOtherUserFollower();
    getOtherUserFollowing();
    otherUserQuestionCountFunction();
     isProfileLoading=true;
    //retrieveMyBookmarked();
  }
  @override
  Widget build(BuildContext context) {
    myProvider = Provider.of<User>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.lightGreen[900],
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop(true);
        },
        child: /*Padding(
          padding: EdgeInsets.all(10),
          child:*/ Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
       // ),
      ),
      title:  Text(
          
          "User Profile",
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
        
      )
      
    ),
    body: (isLoading || fetchquestions || fetchfollowers || fetchfollowing||isProfileLoading)
      ? Center(child: CircularProgressIndicator())
      : SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10
          ),
          Center(
            child: CircularProfileAvatar(
              '$otherUserImage',
              radius: (size.height * 0.2) * 0.3,
              borderWidth: 0,
              elevation: 0,
              backgroundColor: Colors.white
            ),
          ),
          Text(
            "$otherUserName",
          style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black
          )
          ),
          Text(
            "$otherUserProfession",
          style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black
          )
          ),
          if(otherUserOrganization!=null)
          Text(
            "$otherUserOrganization",
          style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black
          )
          ),
          SizedBox(
            height: 9,
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
                        color: Colors.black,
                        fontSize: 19
                        ),
                  ),
                  Text(
                    "Questions",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                  fontSize: 16),
                  ),
                ],
              ),
              InkWell(
                onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyFollowersScreen(
                        widget.otherUserUid,
                        ))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "$_followingCount",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                    fontSize: 19),
                    ),
                    Text(
                      "Followers",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                    fontSize: 16),
                    ),
                  ],
                ),
              ),
              InkWell(
                  onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FollowingScreen(
                          widget.otherUserUid,
                          ))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "$_followersCount",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                      fontSize: 19),
                      ),
                      Text(
                        "Following",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                      fontSize: 16),
                      ),
                    ],
                  ))
            ],
          ),
          if(this.widget.uid != this.widget.otherUserUid)
          SizedBox(height: 12),
          (this.widget.uid == this.widget.otherUserUid)
          ? Container()
          : ((_followId?.isEmpty ?? true)
              ? OnClickFollow(
                imageUserFollower: myProvider.personalInformation.profileImageUrl,
                  nameUserFollower:  myProvider.personalInformation.fullName,
                  professionUserFollower: myProvider.personalInformation.profession,
                  professionUserFollowing:otherUserProfession,
                  nameUserFollowing:otherUserName,
                  uidUserFollower:this.widget.uid,
                  uidUserFollowing: this.widget.otherUserUid,
                imageUserFollowing: otherUserImage,
                size:  size,
                action: onClickFollowSetState)
              : OnCLickUnfollow(followId: _followId, size: size, action:onClickUnFollowSetState )),
          SizedBox(height: 8),
          CustomTile(
          Icons.open_in_new,
          'Website',
          (otherUserWebsite != null)
              ? '$otherUserWebsite'
              : null,
          size),
          Padding(
          padding: EdgeInsets.symmetric(
              horizontal: (size.width * 0.05), vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            //mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.person_outline,
                color: Colors.black,
                size: 22,
              ),
              SizedBox(
                width: 30,
              ),
              Flexible(
                              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('About me',
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                       otherUserAboutme!=null
                        ?// Flexible(
                         // flex: 1,
                                 //               child:
                                                 Text(
                              '$otherUserAboutme',
                              style: GoogleFonts.poppins(fontSize: 12),
                              maxLines: 4,
                            softWrap:true,
                            overflow: TextOverflow.ellipsis
                        //    ),
                        )
                        : Text('')
                  ],
                ),
              )
            ],
          )),
          SizedBox(height: 15),
          Container(
            color: Color(0xFFF8F8F8),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        setState(() {
                          _professional=true;
                          _contribution=false;
                        });
                      },
                                          child: Container(
                                            height: 40,
                                            width: size.width*0.5,
                        decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: _professional
                                    ? Colors.grey
                                    : Color(0xFFF8F8F8),
                                width: 3.0))),
                        child: Text("Professional",
                        textAlign: TextAlign.center ,
                         style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color:_professional? Color(0xFF6984FF): Colors.black,
                        fontSize: 15
                        ))
                      ),
                    ),
                    InkWell(
                                          onTap: (){
                                            setState(() {
                                              _professional=false;
                                              _contribution=true;
                                            });
                                          },
                                          child: Container(
                                            height: 40,
                                            width: size.width*0.5,
                                            decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: _contribution
                                                        ? Colors.grey
                                                        : Color(0xFFF8F8F8),
                                                    width: 3.0))),
                                            child: Text("Contribution",
                                            textAlign: TextAlign.center ,
                                             style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color:_contribution?Color(0xFF6984FF): Colors.black,
                    fontSize: 15)),
                                          )
                    )
                  ],
                ),
                if(_professional)
                OtherUserProfessionalDetails(achievementList: otherUserAchievementList,
                 experienceList: otherUserExperienceList,),
                if(_contribution)
                OtherUserContribution(stream: _stream),
              ]
            )
          )
        ],
      )
    )
    );
  }
}