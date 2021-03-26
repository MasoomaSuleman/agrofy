import 'package:flutter/material.dart';

// added dependencies
import 'package:google_fonts/google_fonts.dart';

class FilterBottomSheet {
  final Function callSetStateOFHome;

  FilterBottomSheet({this.callSetStateOFHome});

  List<String> _dateFilterValue = [
    '1 Month',
    '3 Months',
    '6 Months',
    '1 Year',
  ];
  int selectedDateFilterSelectedIndex = 2;
  int tepDateFilterSelectedIndex = 2;

  // for strteam filter and collections use selectedAllFilterMap
  // need to add a functionality where not both the answered and unanswered can be false
  Map<String, dynamic> selectedAllFiltersMap = {
    'recomended': false,
    'answered': true,
    'unAnswered': true,
  };

  Map<String, dynamic> tempAllFiltersMap = {
    'recomended': false,
    'answered': true,
    'unAnswered': true,
  };

  String getSeletedTimeStampForFilter() {
    switch (selectedDateFilterSelectedIndex) {
      case 0:
        {
          // 1 month ago
          //DateTime oneMonthAgo = ;
          return DateTime.now().subtract(Duration(days: 31)).toString();
        }
      case 1:
        {
          // 3 months ago
          //DateTime threeMonthsAgo = ;
          return DateTime.now().subtract(Duration(days: 93)).toString();
        }
      case 2:
        {
          // 6 months ago
          // DateTime sixMonthsAgo = ;
          return DateTime.now().subtract(Duration(days: 184)).toString();
        }
      case 3:
        {
          // 1 year ago
          // DateTime oneYearAgo = ;
          return DateTime.now().subtract(Duration(days: 366)).toString();
        }
      default:
        return DateTime.now().subtract(Duration(days: 366)).toString();
    }
  }

  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        isScrollControlled: false,
        backgroundColor: Colors.transparent,
        isDismissible: false,
        builder: (BuildContext buildContext) {
          return StatefulBuilder(
            builder: (BuildContext context2, StateSetter setState) {
              return Wrap(
                children: [
                  Container(
                    decoration: new BoxDecoration(
                      color: Color(0xFFF8F8F8),
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(20.0),
                          topRight: const Radius.circular(20.0)),
                    ),
                    child: Container(
                        child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: GestureDetector(
                                onTap: () {
                                  if (selectedAllFiltersMap !=
                                          tempAllFiltersMap &&
                                      selectedDateFilterSelectedIndex !=
                                          tepDateFilterSelectedIndex) {
                                    tempAllFiltersMap = selectedAllFiltersMap;
                                    tepDateFilterSelectedIndex =
                                        selectedDateFilterSelectedIndex;
                                    Navigator.pop(buildContext);
                                  } else if (selectedAllFiltersMap !=
                                      tempAllFiltersMap) {
                                    tempAllFiltersMap = selectedAllFiltersMap;
                                    Navigator.pop(buildContext);
                                  } else if (selectedDateFilterSelectedIndex !=
                                      tepDateFilterSelectedIndex) {
                                    tepDateFilterSelectedIndex =
                                        selectedDateFilterSelectedIndex;
                                    Navigator.pop(buildContext);
                                  } else
                                    Navigator.pop(buildContext);
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                      color: Color(0XFFE8E8E8),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Icon(
                                    Icons.close,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Filters',
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Color(0xFFDFDFDF),
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: DropdownButton<String>(
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    iconSize: 15,
                                    value: _dateFilterValue[
                                        tepDateFilterSelectedIndex],
                                    style: GoogleFonts.poppins(),
                                    underline: Container(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        tepDateFilterSelectedIndex =
                                            _dateFilterValue.indexOf(newValue);
                                      });
                                    },
                                    items: _dateFilterValue
                                        .map<DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                      );
                                    }).toList(),
                                  )),
                            )
                          ],
                        ),
                        Divider(),
                        Container(
                          height: 30,
                          child: CheckboxListTile(
                            title: Text(
                              'Recomended',
                              style: GoogleFonts.poppins(),
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                            value: tempAllFiltersMap['recomended'],
                            onChanged: (value) {
                              setState(() {
                                tempAllFiltersMap['recomended'] = value;
                              });
                              //allFiltersMap['latest'] = value;
                            },
                            activeColor: Colors.lightGreen[900],
                            checkColor: Colors.white,
                            dense: true,
                            isThreeLine: false,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 30,
                          child: CheckboxListTile(
                            title: Text(
                              'Answered',
                              style: GoogleFonts.poppins(),
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                            value: tempAllFiltersMap['answered'],
                            onChanged: (value) {
                              if (!value && !tempAllFiltersMap['unAnswered']) {
                                setState(() {
                                  tempAllFiltersMap['unAnswered'] = !value;
                                  tempAllFiltersMap['answered'] = value;
                                });
                              }
                              setState(() {
                                tempAllFiltersMap['answered'] = value;
                              });
                            },
                            activeColor: Colors.lightGreen[900],
                            checkColor: Colors.white,
                            dense: true,
                            isThreeLine: false,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 30,
                          child: CheckboxListTile(
                            title: Text(
                              'Unanswered',
                              style: GoogleFonts.poppins(),
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                            value: tempAllFiltersMap['unAnswered'],
                            onChanged: (value) {
                              if (!value && !tempAllFiltersMap['answered']) {
                                setState(() {
                                  tempAllFiltersMap['answered'] = !value;
                                  tempAllFiltersMap['unAnswered'] = value;
                                });
                              }
                              setState(() {
                                tempAllFiltersMap['unAnswered'] = value;
                              });
                            },
                            activeColor: Colors.lightGreen[900],
                            checkColor: Colors.white,
                            dense: true,
                            isThreeLine: false,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            GestureDetector(
                              onTap: () {
                                // apply button functionality
                                // if selected is diffferent from temp then make selected equal to temp and then pop
                                if (selectedAllFiltersMap !=
                                        tempAllFiltersMap &&
                                    selectedDateFilterSelectedIndex !=
                                        tepDateFilterSelectedIndex) {
                                  selectedDateFilterSelectedIndex =
                                      tepDateFilterSelectedIndex;
                                  selectedAllFiltersMap = tempAllFiltersMap;
                                  Navigator.pop(buildContext);
                                  callSetStateOFHome();
                                } else if (selectedDateFilterSelectedIndex !=
                                    tepDateFilterSelectedIndex) {
                                  selectedDateFilterSelectedIndex =
                                      tepDateFilterSelectedIndex;
                                  Navigator.pop(buildContext);
                                  callSetStateOFHome();
                                } else if (selectedAllFiltersMap !=
                                    tempAllFiltersMap) {
                                  selectedAllFiltersMap = tempAllFiltersMap;
                                  Navigator.pop(buildContext);
                                  callSetStateOFHome();
                                } else {
                                  Navigator.pop(buildContext);
                                  callSetStateOFHome();
                                }
                                // call setstate of home to change stream
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                decoration: BoxDecoration(
                                    color: Colors.lightGreen[900],
                                    borderRadius: BorderRadius.all(
                                        const Radius.circular(20.0))),
                                child: Center(
                                  child: Text(
                                    'Apply',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    )),
                  )
                ],
              );
            },
          );
        });
  }
//
//  void showPersistentFilterBottomSheet(BuildContext context,
//      GlobalKey<ScaffoldState> _homeMainScreenScaffoldKey) {
//    //Scaffold.of(context)
//    _homeMainScreenScaffoldKey.currentState
//        .showBottomSheet<void>((BuildContext context) {
//      return Wrap(
//        children: [
//          Container(
//            decoration: new BoxDecoration(
//              color: Color(0xFFF8F8F8),
//              borderRadius: new BorderRadius.only(
//                  topLeft: const Radius.circular(20.0),
//                  topRight: const Radius.circular(20.0)),
//            ),
//            child: Container(
//                child: Column(
//              children: [
//                SizedBox(
//                  height: 10,
//                ),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: [
//                    Padding(
//                      padding: const EdgeInsets.only(left: 10),
//                      child: Container(
//                        height: 20,
//                        width: 20,
//                        decoration: const BoxDecoration(
//                            color: Color(0XFFE8E8E8),
//                            borderRadius:
//                                const BorderRadius.all(Radius.circular(10))),
//                        child: Icon(
//                          Icons.close,
//                          size: 15,
//                        ),
//                      ),
//                    ),
//                    Text(
//                      'Filters',
//                      style: GoogleFonts.poppins(),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.only(right: 15),
//                      child: Container(
//                          padding: EdgeInsets.only(
//                              left: 10, right: 10, top: 5, bottom: 5),
//                          height: 30,
//                          decoration: BoxDecoration(
//                              color: Colors.white,
//                              border: Border.all(
//                                color: Color(0xFFDFDFDF),
//                              ),
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(5))),
//                          child: DropdownButton<String>(
//                            icon: Icon(Icons.keyboard_arrow_down),
//                            iconSize: 15,
//                            value: _dateFilterValue[dateFilterSelectedIndex],
//                            style: GoogleFonts.poppins(),
//                            underline: Container(),
//                            onChanged: (newValue) {},
//                            items: _dateFilterValue
//                                .map<DropdownMenuItem<String>>((value) {
//                              return DropdownMenuItem<String>(
//                                value: value,
//                                child: Text(
//                                  value,
//                                  style: GoogleFonts.poppins(
//                                      color: Colors.black, fontSize: 10),
//                                ),
//                              );
//                            }).toList(),
//                          )),
//                    )
//                  ],
//                ),
//                Divider(),
//                Container(
//                  height: 20,
//                  child: CheckboxListTile(
//                    title: Text(
//                      'Latest',
//                      style: GoogleFonts.poppins(),
//                    ),
//                    controlAffinity: ListTileControlAffinity.trailing,
//                    value: true,
//                    onChanged: (value) {},
//                    activeColor: Colors.lightGreen[900],
//                    checkColor: Colors.white,
//                    dense: true,
//                    isThreeLine: false,
//                  ),
//                ),
//                SizedBox(
//                  height: 10,
//                ),
//                Container(
//                  height: 20,
//                  child: CheckboxListTile(
//                    title: Text(
//                      'Answered',
//                      style: GoogleFonts.poppins(),
//                    ),
//                    controlAffinity: ListTileControlAffinity.trailing,
//                    value: true,
//                    onChanged: (value) {},
//                    activeColor: Colors.lightGreen[900],
//                    checkColor: Colors.white,
//                    dense: true,
//                    isThreeLine: false,
//                  ),
//                ),
//                SizedBox(
//                  height: 10,
//                ),
//                Container(
//                  height: 20,
//                  child: CheckboxListTile(
//                    title: Text(
//                      'Unanswered',
//                      style: GoogleFonts.poppins(),
//                    ),
//                    controlAffinity: ListTileControlAffinity.trailing,
//                    value: false,
//                    onChanged: (value) {},
//                    activeColor: Colors.lightGreen[900],
//                    checkColor: Colors.white,
//                    dense: true,
//                    isThreeLine: false,
//                  ),
//                ),
//                SizedBox(
//                  height: 20,
//                ),
//                Divider(),
//                Row(
//                  children: [
//                    Expanded(
//                      child: Container(),
//                    ),
//                    GestureDetector(
//                      onTap: () {
//                        // apply button functionality
//                      },
//                      child: Container(
//                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
//                        decoration: BoxDecoration(
//                            color: Colors.lightGreen[900],
//                            borderRadius:
//                                BorderRadius.all(const Radius.circular(20.0))),
//                        child: Center(
//                          child: Text(
//                            'Apply',
//                            style: GoogleFonts.poppins(color: Colors.white),
//                          ),
//                        ),
//                      ),
//                    ),
//                    SizedBox(
//                      width: 15,
//                    )
//                  ],
//                ),
//              ],
//            )),
//          )
//        ],
//      );
//    });
//  }
}
