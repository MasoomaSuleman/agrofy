import 'package:flutter/material.dart';

import 'package:kisaanCorner/src/constants.dart';
import 'package:kisaanCorner/src/view/my_account_screen/my_account_landing_page.dart';
import 'package:kisaanCorner/views/ask_question_screen.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// added dependencies
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:kisaanCorner/provider/user_details.dart';
import 'package:kisaanCorner/utils/SizeConfig.dart';
import 'package:kisaanCorner/Screens/Home/ui_components/AskAQuestion.dart';
import 'package:kisaanCorner/src/view/home/widgets/questions_card/questions_card.dart';
import 'package:kisaanCorner/Screens/Home/ui_components/QuestionCard.dart';
import 'package:kisaanCorner/src/view/my_account_screen/widgets/custom_circular_profile_avatar.dart';
import 'package:kisaanCorner/src/view/home/widgets/filter_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String _filterselectedvalue = 'all';
  Stream _currentStream;
  String _myUID;
  List<String> _followingUserId = [];
  int _selectedCategory = 0;
  TabController _tabController;

  int category;
  String subcategory;
  int _selectedRadio;
  int check = -1;

  GlobalKey<ScaffoldState> _homeMainScreenScaffoldKey =
      GlobalKey<ScaffoldState>();
  FilterBottomSheet _filterBottomSheet = FilterBottomSheet();

  Stream _all;
//  = Firestore.instance
//      .collection('questionData')
//      .orderBy('questionTimeStamp', descending: true)
//      .where('category', isEqualTo: check)
//      .snapshots();

  Stream _answeredStream = Firestore.instance
      .collection('questionData')
      .where('isAnswered', isEqualTo: true)
      .orderBy('questionTimeStamp', descending: true)
      //.limit(15)
      .snapshots();

  Stream _unAnsweredStream = Firestore.instance
      .collection('questionData')
      .where('isAnswered', isEqualTo: false)
      .orderBy('questionTimeStamp', descending: true)
      // .limit(15)
      .snapshots();
  Stream _recomemdedStream = Firestore.instance
      .collection('questionData')
      .orderBy('questionTimeStamp', descending: true)
      .snapshots();
  Stream _allQStream = Firestore.instance
      .collection('questionData')
      .orderBy('questionTimeStamp', descending: true)
      .snapshots();

  void callSetStateOFHome() {
    this.setState(() {
      print("The homeMainScreen()''': is getting rebuilt");
      _currentStream = _all = Firestore.instance
          .collection('questionData')
          .orderBy('questionTimeStamp', descending: true)
          .snapshots();
      _filterselectedvalue = 'all';
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
      print(
          "HomeMainScreen()''': Printing the list of following data: ${_followingUserId.toString()}");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // _currentStream = _all;
    _selectedRadio = -1;
    category = -1;
    _currentStream = Firestore.instance
        .collection('questionData')
        .orderBy('questionTimeStamp', descending: true)
        .where('category', isEqualTo: -1)
        .snapshots();
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

  @override
  Widget build(BuildContext context) {
    UserDetails userDetails = Provider.of<UserDetails>(context);
    _myUID = userDetails.user_id;
    Size _size = MediaQuery.of(context).size;
    _selectedCategory = check + 1;
    AppBar _kAppBar = AppBar(
        backgroundColor: Colors.lightGreen[900],
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: InkWell(
              onTap: () {
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => MyAccountScreen()));
                pushNewScreen(
                  context,
                  screen: MyAccountLandingPage(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: CustomCircularProfileAvatar(30.0)),
        ),
        title: Text(
          "Home",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                // push to search screen
              }),
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
      body:
          /*SingleChildScrollView(
        physics: ScrollPhysics(),
        child:*/
          DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                            maxHeight: 150, maxWidth: _size.width),
                        child: Material(
                          color: Color(0xfff8f8f8),
                          child: TabBar(
                            isScrollable: true,
                            indicatorColor: Colors.lightGreen[900],
                            indicatorWeight: 6.0,
                            onTap: (index) {
                              setState(() {
                                switch (index) {
                                }
                              });
                            },
                            tabs: <Widget>[
                              Container(
                                width: 20,
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.0),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  child: Text(
                                    categories[0].name,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14.0),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  child: Text(
                                    categories[1].name,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14.0),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                    child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: IconButton(
                                      icon: Icon(Icons.menu),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(
                                                  builder: (context, setState) {
                                                return AlertDialog(
                                                    scrollable: true,
                                                    titlePadding: EdgeInsets
                                                        .fromLTRB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                    contentPadding: EdgeInsets
                                                        .fromLTRB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                    backgroundColor: Colors
                                                        .white,
                                                    title: Container(
                                                        height: 63,
                                                        width: double.infinity,
                                                        color: Color(
                                                            0xFFF5F5F5),
                                                        child: ListTile(
                                                            leading: Icon(Icons
                                                                .search),
                                                            trailing:
                                                                IconButton(
                                                                    icon: Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: Colors
                                                                            .black,
                                                                        size:
                                                                            16),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(
                                                                              true);
                                                                    }),
                                                            title: Text(
                                                              'Search',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          14),
                                                            ))),
                                                    content: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          12, 8, 10, 8),
                                                      child:
                                                          SingleChildScrollView(
                                                              child: Column(
                                                                  children: <
                                                                      Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                      'Select tag',
                                                                      style: GoogleFonts.poppins(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w600)),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                      'Not sure ',
                                                                      style: GoogleFonts.poppins(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w600)),
                                                                  Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Icon(
                                                                              Icons.error_outline_rounded,
                                                                              color: Colors.red,
                                                                              size: 6),
                                                                        ],
                                                                      )),
                                                                  Radio(
                                                                      value: -1,
                                                                      groupValue:
                                                                          _selectedRadio,
                                                                      activeColor:
                                                                          Color(
                                                                              0xffd42917),
                                                                      onChanged: (val) =>
                                                                          setState(
                                                                              () {
                                                                            _selectedRadio =
                                                                                val;
                                                                            category =
                                                                                val;
                                                                          })),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0.0),
                                                              child: Divider(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            for (int i = 0;
                                                                i <
                                                                    categories
                                                                        .length;
                                                                i++)
                                                              if (categories[i]
                                                                      .subcategory ==
                                                                  null)
                                                                buildMainCategory(
                                                                    categories[i].name,
                                                                    (val) {
                                                                  setState(() {
                                                                    categories[
                                                                            i]
                                                                        .isChecked = !categories[
                                                                            i]
                                                                        .isChecked;
                                                                    _selectedRadio =
                                                                        val;
                                                                    category =
                                                                        i;
                                                                    subcategory =
                                                                        null;
                                                                  });
                                                                  print(
                                                                      _selectedRadio);
                                                                },
                                                                    categories[i]
                                                                        .isChecked,
                                                                    i)
                                                              else if (!categories[i]
                                                                  .isChecked)
                                                                buildMainSubCategory(
                                                                    categories[i]
                                                                        .name,
                                                                    () =>
                                                                        setState(
                                                                            () {
                                                                          categories[i].isChecked =
                                                                              !categories[i].isChecked;
                                                                        }),
                                                                    categories[i]
                                                                        .isChecked)
                                                              else
                                                                for (int j = -1;
                                                                    j <
                                                                        categories[i]
                                                                            .subcategory
                                                                            .length;
                                                                    j++)
                                                                  if (j == -1)
                                                                    buildMainSubCategory(
                                                                        categories[i]
                                                                            .name,
                                                                        () =>
                                                                            setState(
                                                                                () {
                                                                              categories[i].isChecked = !categories[i].isChecked;
                                                                            }),
                                                                        categories[i]
                                                                            .isChecked)
                                                                  else
                                                                    buildSubCategory(
                                                                        categories[i]
                                                                            .subcategory[
                                                                                j]
                                                                            .name,
                                                                        (val) {
                                                                      setState(
                                                                          () {
                                                                        categories[i]
                                                                            .subcategory[
                                                                                j]
                                                                            .isChecked = !categories[
                                                                                i]
                                                                            .subcategory[j]
                                                                            .isChecked;
                                                                        _selectedRadio =
                                                                            val;
                                                                        category =
                                                                            i;
                                                                        subcategory = categories[i]
                                                                            .subcategory[j]
                                                                            .name;
                                                                      });
                                                                    },
                                                                        categories[i]
                                                                            .subcategory[j]
                                                                            .isChecked,
                                                                        i * (j + 2) * 4),
                                                          ])),
                                                    ));
                                              });
                                            }).then((value) => setState(() {
                                              check = _selectedRadio;
                                            }));
                                      }),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //AskAQuestion(_size),
                  Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('questionData')
                        .where('containsImage', isEqualTo: !null)
                        // .orderBy('questionTimeStamp', descending: true)
                        .snapshots(),
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
                        return
//                          (snapshot.data.documents.isEmpty)
//                            ? Center(child: Text("No Posts Yet"))
//                            : (_currentStream == _recomemdedStream)
//                                ? (_followingUserId == [])
//                                    ? Center(
//                                        child:
//                                            Text('Currently following no one'),
//                                      )
//                                    :
                            ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot questionsData =
                                snapshot.data.documents[index];
                            print("HomeMainScreen()''': calling if statement");
                            return _followingUserId.contains(questionsData
                                    .data['questionByUID']
                                    .toString())
                                ? QuestionsCard(questionData: questionsData)
                                //                                    QuestionCard(
                                //                                            questionData: questionsData,
                                //                                            size: _size,
                                //                                          )
                                : Container();
                          },
                        );
//                                :
//                      ListView.builder(
//                                    physics: ScrollPhysics(),
//                                    shrinkWrap: true,
//                                    itemCount: snapshot.data.documents.length,
//                                    itemBuilder: (context, index) {
//                                      DocumentSnapshot questionsData =
//                                          snapshot.data.documents[index];
//                                      return QuestionsCard(
//                                          questionData: questionsData);
//                                      //                                  QuestionCard(
//                                      //                                  questionData: questionsData,
//                                      //                                  size: _size,
//                                      //                                  callsetStateHome: callSetStateOFHome,
//                                      //                                );
//                                    },
//                                  );
                      }
                    },
                  )),
                  // AskAQuestion(_size),
                ],
              )),
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
