import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisaanCorner/src/constants.dart';
import 'package:kisaanCorner/src/view/my_account_screen/my_account_landing_page.dart';
import 'package:kisaanCorner/views/ask_question_screen.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// added dependencies
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// app dependencies
import 'package:kisaanCorner/provider/user_details.dart';
import 'package:kisaanCorner/utils/SizeConfig.dart';
import 'AskAQuestion.dart';
import 'package:kisaanCorner/src/view/home/widgets/questions_card/questions_card.dart';
import 'QuestionCard.dart';
import 'package:kisaanCorner/src/view/my_account_screen/widgets/custom_circular_profile_avatar.dart';
import 'package:kisaanCorner/src/view/home/widgets/filter_bottom_sheet.dart';

import 'package:kisaanCorner/src/view/add_new_answer/add_new_answer_screen.dart';
import 'package:kisaanCorner/src/core/widgets/alert_dialogs.dart';

class HomeMainScreen extends StatefulWidget {
  @override
  _HomeMainScreenState createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen>
    with TickerProviderStateMixin {
  String _myUID;
  List<String> _followingUserId = [];
  GlobalKey<ScaffoldState> _homeMainScreenScaffoldKey =
      GlobalKey<ScaffoldState>();

  FilterBottomSheet _filterBottomSheet;

  void callSetStateOFHome() {
    this.setState(() {
      print("The homeMainScreen()''': is getting rebuilt");
    });
  }

  Future<void> _getListOfFollowingUsersForRecomemdedStream() async {
    _followingUserId = [];
    await Firestore.instance
        .collection('followData')
        .where('uidUserFollower', isEqualTo: _myUID)
        .getDocuments()
        .then((value) {
      // not checked if I am following no one
      value.documents.forEach((element) {
        _followingUserId.add(element.data['uidUserFollowing']);
      });
//      print(
//          "HomeMainScreen()''': Printing the list of following data: ${_followingUserId.toString()}");
    });
  }

  int _selectedRadio;
  int check;
  @override
  void initState() {
    // TODO: implement initState
//    _currentStream = _all;
    _selectedRadio = null;
    _getListOfFollowingUsersForRecomemdedStream();
    check = null;
    _filterBottomSheet =
        FilterBottomSheet(callSetStateOFHome: callSetStateOFHome);
    super.initState();
  }

  Widget buildMainCategory(String name, Function action, bool ac, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text('$name',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ),
          Radio(
              value: index,
              groupValue: _selectedRadio,
              activeColor: Colors.lightGreen[900],
              onChanged: action),
        ],
      ),
    );
  }

  Widget buildSubCategory(String name, Function action, bool ac, int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8.0, 8.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text('$name',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ),
          Radio(
              //activeColor: Colors.white,

              value: index,
              groupValue: _selectedRadio,
              activeColor: Colors.lightGreen[900],
              onChanged: action),
        ],
      ),
    );
  }

  Widget buildMainSubCategory(String name, Function action, bool ac) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text('$name ',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ),
          IconButton(
            icon: Icon(ac
                ? Icons.arrow_drop_up_outlined
                : Icons.arrow_drop_down_outlined),
            onPressed: action,
          )
        ],
      ),
    );
  }

  Stream getSelectedStream() {
    if (check == null) {
      if (_filterBottomSheet.selectedAllFiltersMap['answered'] &&
          _filterBottomSheet.selectedAllFiltersMap['unAnswered']) {
        //show both the answered and unanswered
        return Firestore.instance
            .collection('questionData')
            //.where('category', isEqualTo: check)
            .where('questionTimeStamp',
                isGreaterThan:
                    _filterBottomSheet.getSeletedTimeStampForFilter())
            .orderBy('questionTimeStamp', descending: true)
            // .limit(15)
            .snapshots();
      } else if (_filterBottomSheet.selectedAllFiltersMap['answered'] &&
          !_filterBottomSheet.selectedAllFiltersMap['unAnswered']) {
        // show only the answered questions
        return Firestore.instance
            .collection('questionData')
            .where('isAnswered', isEqualTo: true)
            //.where('category', isEqualTo: check)
            .where('questionTimeStamp',
                isGreaterThan:
                    _filterBottomSheet.getSeletedTimeStampForFilter())
            .orderBy('questionTimeStamp', descending: true)
            // .limit(15)
            .snapshots();
      } else if (!_filterBottomSheet.selectedAllFiltersMap['answered'] &&
          _filterBottomSheet.selectedAllFiltersMap['unAnswered']) {
        // show only unanswered questions
        return Firestore.instance
            .collection('questionData')
            .where('isAnswered', isEqualTo: false)
            //.where('category', isEqualTo: check)
            .where('questionTimeStamp',
                isGreaterThan:
                    _filterBottomSheet.getSeletedTimeStampForFilter())
            .orderBy('questionTimeStamp', descending: true)
            // .limit(15)
            .snapshots();
      } else if (!_filterBottomSheet.selectedAllFiltersMap['answered'] &&
          !_filterBottomSheet.selectedAllFiltersMap['unAnswered']) {
        // this shouldnt be the case
        // because then no posts will be displayed
        return Firestore.instance
            .collection('questionData')
            //.where('category', isEqualTo: check)
            .where('questionTimeStamp',
                isGreaterThan:
                    _filterBottomSheet.getSeletedTimeStampForFilter())
            .orderBy('questionTimeStamp', descending: true)
            // .limit(15)
            .snapshots();
      }
    } else {
      if (_filterBottomSheet.selectedAllFiltersMap['answered'] &&
          _filterBottomSheet.selectedAllFiltersMap['unAnswered']) {
        //show both the answered and unanswered
        return Firestore.instance
            .collection('questionData')
            .where('category', isEqualTo: check)
            .where('questionTimeStamp',
                isGreaterThan:
                    _filterBottomSheet.getSeletedTimeStampForFilter())
            .orderBy('questionTimeStamp', descending: true)
            // .limit(15)
            .snapshots();
      } else if (_filterBottomSheet.selectedAllFiltersMap['answered'] &&
          !_filterBottomSheet.selectedAllFiltersMap['unAnswered']) {
        // show only the answered questions
        return Firestore.instance
            .collection('questionData')
            .where('isAnswered', isEqualTo: true)
            .where('category', isEqualTo: check)
            .where('questionTimeStamp',
                isGreaterThan:
                    _filterBottomSheet.getSeletedTimeStampForFilter())
            .orderBy('questionTimeStamp', descending: true)
            // .limit(15)
            .snapshots();
      } else if (!_filterBottomSheet.selectedAllFiltersMap['answered'] &&
          _filterBottomSheet.selectedAllFiltersMap['unAnswered']) {
        // show only unanswered questions
        return Firestore.instance
            .collection('questionData')
            .where('isAnswered', isEqualTo: false)
            .where('category', isEqualTo: check)
            .where('questionTimeStamp',
                isGreaterThan:
                    _filterBottomSheet.getSeletedTimeStampForFilter())
            .orderBy('questionTimeStamp', descending: true)
            // .limit(15)
            .snapshots();
      } else if (!_filterBottomSheet.selectedAllFiltersMap['answered'] &&
          !_filterBottomSheet.selectedAllFiltersMap['unAnswered']) {
        // this shouldnt be the case
        // because then no posts will be displayed
        return Firestore.instance
            .collection('questionData')
            .where('category', isEqualTo: check)
            .where('questionTimeStamp',
                isGreaterThan:
                    _filterBottomSheet.getSeletedTimeStampForFilter())
            .orderBy('questionTimeStamp', descending: true)
            // .limit(15)
            .snapshots();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    UserDetails userDetails = Provider.of<UserDetails>(context);
    _myUID = userDetails.user_id;
    Size _size = MediaQuery.of(context).size;

    AppBar _kAppBar = AppBar(
        backgroundColor: Colors.lightGreen[900],
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyAccountLandingPage()));
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => MyAccountScreen()));
//                pushNewScreen(
//                  context,
//                  screen: MyAccountLandingPage(),
//                  withNavBar: false,
//                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
//                );
              },
              child: CustomCircularProfileAvatar(30.0)),
        ),
        title: Text(
          "Home",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
//          IconButton(
//              icon: Icon(
//                Icons.search,
//                color: Colors.white,
//              ),
//              onPressed: () {
//                // push to search screen
//                // temporarily going to add answer screen
//                AlertDialogs _alert = AlertDialogs();
//                _alert.showAlertDialogWithOKbutton(
//                    context, 'Search functionality coming soon', 1);
////                pushNewScreen(
////                  context,
////                  screen: AddNewAnswerScreen(),
////                  withNavBar: false, // OPTIONAL VALUE. True by default.
////                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
////                );
////                Navigator.push(
////                    context,
////                    MaterialPageRoute(
////                        builder: (context) => AddNewAnswerScreen()));
//              }),
          IconButton(
              icon: Icon(
                Icons.filter_list,
                color: Colors.white,
              ),
              onPressed: () {
                // show the bottom sheet for filters
//                _filterBottomSheet.showPersistentFilterBottomSheet(
//                    context, _homeMainScreenScaffoldKey);
                _filterBottomSheet.showFilterBottomSheet(context);
              }),
        ]);

    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      appBar: _kAppBar,
      body:SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Check current condition of your field",style: TextStyle(
              fontSize: 14
            )),
          ),
          Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(

                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/temperature.png",
                                height: 25,
                                width: 25,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Temperature",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),

                          Text(
                            "Critical",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                            ),
                          ),
          //
                        ],
                      ),
                    ),

         
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: Text(
                        "29 C",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red ,
                          fontSize: 100,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
        
                    ),


                  ],
                ),
              ),
          Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(

                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/humidity.png",
                                height: 25,
                                width: 25,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Humidity",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),

                          Text(
                            "Normal",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.lightBlue,
                            ),
                          ),
          //
                        ],
                      ),
                    ),

         
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: Text(
                        "56",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.lightBlueAccent ,
                          fontSize: 100,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
        
                    ),


                  ],
                ),
              ),
          Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(

                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/drip.png",
                                height: 25,
                                width: 25,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Moisture",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),

                          Text(
                            "Critically low",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                            ),
                          ),
          //
                        ],
                      ),
                    ),

         
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: Text(
                        "0 %",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blueAccent,
                          fontSize: 100,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
        
                    ),


                  ],
                ),
              )
        ],
      )
      ),
          /*SingleChildScrollView(
        physics: ScrollPhysics(),
        child:*/
        /*  DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          splashColor: Colors.lightGreen[900],
                          onTap: () {
                            setState(() {
                              check = null;
                            });
                          },
                          child: Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: check == null
                                              ? Colors.lightGreen[900]
                                              : Colors.white,
                                          width: 3.0))),
                              child: Text(
                                'All',
                                style: TextStyle(
                                    color: check == null
                                        ? Colors.lightGreen[900]
                                        : Colors.black,
                                    fontSize: 14.0),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.lightGreen[900],
                          onTap: () {
                            setState(() {
                              check = 0;
                              _selectedRadio = 0;
                            });
                          },
                          child: Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: check == 0
                                              ? Colors.lightGreen[900]
                                              : Colors.white,
                                          width: 3.0))),
                              child: Text(
                                categories[0].name,
                                style: TextStyle(
                                    color: check == 0
                                        ? Colors.lightGreen[900]
                                        : Colors.black,
                                    fontSize: 14.0),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.lightGreen[900],
                          onTap: () {
                            setState(() {
                              check = 1;
                              _selectedRadio = 1;
                            });
                          },
                          child: Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: check == 1
                                              ? Colors.lightGreen[900]
                                              : Colors.white,
                                          width: 3.0))),
                              child: Text(
                                categories[1].name,
                                style: TextStyle(
                                    color: check == 1
                                        ? Colors.lightGreen[900]
                                        : Colors.black,
                                    fontSize: 14.0),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                            splashColor: Colors.lightGreen[900],
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return AlertDialog(
                                          scrollable: true,
                                          titlePadding: EdgeInsets.fromLTRB(
                                              0.0, 0.0, 0.0, 0.0),
                                          contentPadding: EdgeInsets.fromLTRB(
                                              0.0, 0.0, 0.0, 0.0),
                                          backgroundColor: Colors.white,
                                          title: Container(
                                              height: 63,
                                              width: double.infinity,
                                              color: Color(0xFFF5F5F5),
                                              child: ListTile(
                                                  leading: Icon(Icons.search),
                                                  trailing: IconButton(
                                                      icon: Icon(Icons.close,
                                                          color: Colors.black,
                                                          size: 16),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(true);
                                                      }),
                                                  title: Text(
                                                    'Search',
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 14),
                                                  ))),
                                          content: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                12, 8, 10, 8),
                                            child: SingleChildScrollView(
                                                child:
                                                    Column(children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text('Select tag',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text('Not sure ',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .error_outline_rounded,
                                                                color:
                                                                    Colors.red,
                                                                size: 6),
                                                          ],
                                                        )),
                                                    Radio(
                                                        value: -1,
                                                        groupValue:
                                                            _selectedRadio,
                                                        activeColor:
                                                            Colors.lightGreen[900],
                                                        onChanged: (val) {
                                                          setState(() {
                                                            _selectedRadio =
                                                                val;
                                                          });
                                                          Navigator.of(context)
                                                              .pop(true);
                                                        }),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child:
                                                    Divider(color: Colors.grey),
                                              ),
                                              for (int i = 0;
                                                  i < categories.length;
                                                  i++)
                                                buildMainCategory(
                                                    categories[i].name, (val) {
                                                  setState(() {
                                                    categories[i].isChecked =
                                                        !categories[i]
                                                            .isChecked;
                                                    _selectedRadio = val;
                                                  });
                                                  print(_selectedRadio);
                                                  Navigator.of(context)
                                                      .pop(true);
                                                }, categories[i].isChecked, i)
                                            ])),
                                          ));
                                    });
                                  }).then((value) => setState(() {
                                    check = _selectedRadio;
                                  }));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: check != null &&
                                                    check != 0 &&
                                                    check != 1
                                                ? Colors.lightGreen[900]
                                                : Colors.white,
                                            width: 3.0))),
                                alignment: Alignment.centerRight,
                                child: Tab(
                                  child: Icon(Icons.menu,
                                      color: check != null &&
                                              check != 0 &&
                                              check != 1
                                          ? Colors.lightGreen[900]
                                          : Colors.black),
                                ))),
                      ],
                    ),
                  ),
                  //AskAQuestion(_size),
                  Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                    stream:
//                    check == null
//                        ? Firestore.instance
//                            .collection('questionData')
//                            .orderBy('questionTimeStamp', descending: true)
//                            .snapshots()
//                        :
                        getSelectedStream(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Something went wrong'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData) {
                        return Center(child: Text("No Posts Yet"));
                      } else {
                        return (snapshot.data.documents.isEmpty)
                            ? Center(child: Text("No Posts Yet"))
                            : (_filterBottomSheet
                                    .selectedAllFiltersMap['recomended'])
                                ? (_followingUserId == [])
                                    ? Center(
                                        child:
                                            Text('Currently following no one'),
                                      )
                                    : ListView.builder(
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            snapshot.data.documents.length,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot questionsData =
                                              snapshot.data.documents[index];
                                          print(
                                              "HomeMainScreen()''': Printing the list of following data: ${_followingUserId.toString()}");
                                          return _followingUserId.contains(
                                                  questionsData
                                                      .data['questionByUID'])
                                              ? QuestionsCard(
                                                  questionData: questionsData)
                                              : Container();
                                        },
                                      )
                                : ListView.builder(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.documents.length,
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot questionsData =
                                          snapshot.data.documents[index];
                                      return QuestionsCard(
                                          questionData: questionsData);
                                    },
                                  );
                      }
                    },
                  )),
                  // AskAQuestion(_size),
                ],
              )),*/
      // ),
      
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        backgroundColor: Colors.lightGreen[900],
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 26,
        ),
        onPressed: () {
          pushNewScreen(
            context,
            screen: AskQuestionScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
    );
  }
}
