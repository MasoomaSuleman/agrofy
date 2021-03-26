import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/src/network/user_signIn_functions.dart';
import 'package:kisaanCorner/utils/AuthServices.dart';

class OtpPage extends StatefulWidget {
  final String verificationId;
  final String number;

  OtpPage({this.verificationId, this.number});

  @override
  OtpPageState createState() => OtpPageState();
}

class OtpPageState extends State<OtpPage> {
  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();
  TextEditingController controller4 = new TextEditingController();
  TextEditingController controller5 = new TextEditingController();
  TextEditingController controller6 = new TextEditingController();
  TextEditingController currController = new TextEditingController();

  UserSignInFunctions _userSignInFunctions = UserSignInFunctions();

  @override
  void dispose() {
    super.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currController = controller1;
  }

  double _boxHeight = 50;
  double _boxWeight = 50;
  double boxMarginLeft = 10;
  bool isTimerOn = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> widgetList = [
      Container(
          width: _boxWeight,
          height: _boxHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xFFF8F8F8)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            enabled: false,
            controller: controller1,
            autofocus: false,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          )),
      Container(
          width: _boxWeight,
          height: _boxHeight,
          margin: EdgeInsets.only(left: boxMarginLeft),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xFFF8F8F8)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            controller: controller2,
            autofocus: false,
            enabled: false,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          )),
      Container(
          width: _boxWeight,
          height: _boxHeight,
          margin: EdgeInsets.only(left: boxMarginLeft),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xFFF8F8F8)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            controller: controller3,
            autofocus: false,
            enabled: false,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          )),
      Container(
          width: _boxWeight,
          height: _boxHeight,
          margin: EdgeInsets.only(left: boxMarginLeft),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xFFF8F8F8)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            controller: controller4,
            autofocus: false,
            enabled: false,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          )),
      Container(
          width: _boxWeight,
          height: _boxHeight,
          margin: EdgeInsets.only(left: boxMarginLeft),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xFFF8F8F8)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            controller: controller5,
            autofocus: false,
            enabled: false,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          )),
      Container(
          width: _boxWeight,
          height: _boxHeight,
          margin: EdgeInsets.only(left: boxMarginLeft),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xFFF8F8F8)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            controller: controller6,
            autofocus: false,
            enabled: false,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          )),
    ];

    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
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
          "Continue with phone",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: [
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Code is sent to " + widget.number,
                    style: GoogleFonts.poppins(color: Colors.black54),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Change Number?",
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widgetList,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Receive code?",
                        style: GoogleFonts.poppins(color: Colors.black54),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      isTimerOn
                          ? startTimer()
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  isTimerOn = true;
                                  _userSignInFunctions
                                      .phoneNumberVerify(
                                          context, widget.number, null)
                                      .then((value) => {});
//                            AuthServices.verifyPhoneNumber(widget.number, context,null).then((value) =>
//                            {
//
//                            });
                                });
                              },
                              child: Text(
                                "Request again",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(bottom: 20),
                color: Color(0Xfff8f8f8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(.1),
                              blurRadius: 4.0,
                              offset: Offset(0.0, 6.0))
                        ],
                      ),
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .1,
                          right: MediaQuery.of(context).size.width * .1,
                          bottom: MediaQuery.of(context).size.width * .05),
                      child: Container(
                        height: 50,
                        child: InkWell(
                          onTap: () {
                            if (controller1.text.isNotEmpty &&
                                controller2.text.isNotEmpty &&
                                controller3.text.isNotEmpty &&
                                controller4.text.isNotEmpty &&
                                controller5.text.isNotEmpty &&
                                controller6.text.isNotEmpty) {
                              setState(() {
                                isLoading = true;
                              });
                              String sms = controller1.text +
                                  controller2.text +
                                  controller3.text +
                                  controller4.text +
                                  controller5.text +
                                  controller6.text;
                              _userSignInFunctions
                                  .customSignInWithOTP(
                                      verificationId: widget.verificationId,
                                      smsCode: sms,
                                      context: context,
                                      onResult: onClickResult)
                                  .then((value) => {});
//                              AuthServices.signInWithOTP(
//                                  verificationId: widget.verificationId,
//                                  smsCode: sms,
//                                  context: context,onResult: onClickResult).then((value) => {});
                            }
                          },
                          child: Opacity(
                            opacity: isLoading ? 0.3 : 1,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  color: Color(0xFF323131),
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Verify your Account",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 16.0, right: 8.0, bottom: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            MaterialButton(
                              onPressed: () {
                                inputTextToField("1");
                              },
                              child: Text("1",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center),
                            ),
                            MaterialButton(
                              onPressed: () {
                                inputTextToField("2");
                              },
                              child: Text("2",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center),
                            ),
                            MaterialButton(
                              onPressed: () {
                                inputTextToField("3");
                              },
                              child: Text("3",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 4.0, right: 8.0, bottom: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            MaterialButton(
                              onPressed: () {
                                inputTextToField("4");
                              },
                              child: Text("4",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center),
                            ),
                            MaterialButton(
                              onPressed: () {
                                inputTextToField("5");
                              },
                              child: Text("5",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center),
                            ),
                            MaterialButton(
                              onPressed: () {
                                inputTextToField("6");
                              },
                              child: Text("6",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 4.0, right: 8.0, bottom: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            MaterialButton(
                              onPressed: () {
                                inputTextToField("7");
                              },
                              child: Text("7",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center),
                            ),
                            MaterialButton(
                              onPressed: () {
                                inputTextToField("8");
                              },
                              child: Text("8",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center),
                            ),
                            MaterialButton(
                              onPressed: () {
                                inputTextToField("9");
                              },
                              child: Text("9",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 4.0, right: 8.0, bottom: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            MaterialButton(
                                onPressed: () {
                                  //deleteText();
                                },
                                child: Icon(
                                  Icons.backspace,
                                  color: Colors.transparent,
                                )),
                            MaterialButton(
                              onPressed: () {
                                inputTextToField("0");
                              },
                              child: Text("0",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center),
                            ),
                            MaterialButton(
                                onPressed: () {
                                  deleteText();
                                },
                                child: Icon(Icons.backspace)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void inputTextToField(String str) {
    //Edit first textField
    if (currController == controller1) {
      controller1.text = str;
      currController = controller2;
    }

    //Edit second textField
    else if (currController == controller2) {
      controller2.text = str;
      currController = controller3;
    }

    //Edit third textField
    else if (currController == controller3) {
      controller3.text = str;
      currController = controller4;
    }

    //Edit fourth textField
    else if (currController == controller4) {
      controller4.text = str;
      currController = controller5;
    }

    //Edit fifth textField
    else if (currController == controller5) {
      controller5.text = str;
      currController = controller6;
    }

    //Edit sixth textField
    else if (currController == controller6) {
      controller6.text = str;
      currController = controller6;
    }
  }

  onClickResult() {
    setState(() {
      isLoading = false;
    });
  }

  void deleteText() {
    if (currController.text.length == 0) {
    } else {
      currController.text = "";
      currController = controller5;
      return;
    }

    if (currController == controller1) {
      controller1.text = "";
    } else if (currController == controller2) {
      controller1.text = "";
      currController = controller1;
    } else if (currController == controller3) {
      controller2.text = "";
      currController = controller2;
    } else if (currController == controller4) {
      controller3.text = "";
      currController = controller3;
    } else if (currController == controller5) {
      controller4.text = "";
      currController = controller4;
    } else if (currController == controller6) {
      controller5.text = "";
      currController = controller5;
    }
  }

  Widget startTimer() {

    //return Container();
    // Start the periodic timer which prints something after 5 seconds and then stop it .
    return CountdownTimer(
      endTime: DateTime.now().millisecondsSinceEpoch + (2 * 60 * 1000),
      onEnd: () {
        setState(() {
          isTimerOn = false;
        });
      },
      widgetBuilder: (_, CurrentRemainingTime time){
        if(time==null){
          return Text("Game Over");
        }
        return Text('days:[ ${time.days} ],hours:[ ${time.hours} ],min:[ ${time.min} ],sec:[ ${time.sec} ] ');
      },
      //daysSymbol: Text("days "),
      //hoursSymbol: Text(":"),
      //minSymbol: Text(":"),
      //secSymbol: Text(""),
      textStyle: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold), 
      //emptyWidget: Text("-- : --"),
    );
  }
}
