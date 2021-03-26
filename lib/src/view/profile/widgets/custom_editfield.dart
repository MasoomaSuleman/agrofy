import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// added dependedncies
import 'package:google_fonts/google_fonts.dart';

// app dependencies
import 'package:kisaanCorner/utils/SizeConfig.dart';

class CustomEditField extends StatefulWidget {
  final bool isRequired;
  final double fieldHeight;
  final String lableText;
  final int maxLines;
  final List inputFormatter;
  final Function validatorFunction;
  final TextInputType textInputType;
  final String errorText;
  final TextInputAction textInputAction;
  final String validatorType;
  Function onFieldUpdate;
  final String initialValue;
  final bool isEditable;

  CustomEditField(
      {@required this.isRequired,
      @required this.fieldHeight,
      @required this.lableText,
      this.maxLines,
      this.inputFormatter,
      this.validatorFunction,
      this.textInputType,
      this.errorText,
      this.textInputAction,
      this.validatorType,
      this.onFieldUpdate,
      this.initialValue,
      this.isEditable = true});
  @override
  _CustomEditFieldState createState() => _CustomEditFieldState();
}

class _CustomEditFieldState extends State<CustomEditField> {
  TextEditingController _controller = TextEditingController();

  bool hasError = false;
  bool _isMultiline;

  String validatorFunction(String value) {
    if (_controller.text.isEmpty) {
      setState(() {
        hasError = true;
        return null;
      });
    }
    return null;
  }

  void callSetStateWithError() {
    setState(() {
      hasError = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.initialValue;
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isMultiline = (this.widget.maxLines == null) ? false : true;
    return Container(
      width: SizeConfig.screenWidth * 0.8,
      height: widget.fieldHeight + 20 + 30,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // also check if controller doesnt have any value then dont show
          _controller.text.isEmpty
              ? Container()
              : widget.isRequired
                  ? RichText(
                      text: new TextSpan(children: <TextSpan>[
                        TextSpan(
                          text:
                              '${widget.lableText.substring(0, (widget.lableText.length - 2))}',
                          style: GoogleFonts.poppins(
                              color: Colors.grey, fontSize: 12),
                        ),
                        TextSpan(
                          text: ' *',
                          style: GoogleFonts.poppins(
                              color: Colors.red, fontSize: 12),
                        )
                      ]),
                    )
                  : Text(
                      '${widget.lableText}',
                      style:
                          GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
                    ),
          SizedBox(
            height: 2,
          ),
          Container(
            width: SizeConfig.screenWidth * 0.8,
            height: widget.fieldHeight,
            child: TextFormField(
              controller: _controller,
              //focusNode: widget._focusNode,
              //onFieldSubmitted: widget._focusChangeFunction,
              readOnly: !widget.isEditable,
              //readOnly: (widget.initialValue != null) ? true : false,
              textInputAction: widget.textInputAction,
              keyboardType: widget.textInputType,
              autocorrect: false,
              inputFormatters: widget.inputFormatter,
              style: GoogleFonts.poppins(
                fontSize: 16,
              ),
              cursorColor: Colors.black,
              maxLines: (!_isMultiline) ? 1 : widget.maxLines,
              onSaved: widget.onFieldUpdate,
              validator: (value) {
                switch (widget.validatorType) {
                  case 'isRequired':
                    if (value.isEmpty) {
                      setState(() {
                        hasError = true;
                      });
                      return '';
                    } else {
                      return null;
                    }
                    break;
                  case 'phoneNumber':
                    if (value.isNotEmpty && value.length != 10) {
                      setState(() {
                        hasError = true;
                      });
                      return '';
                    } else {
                      return null;
                    }
                    break;
                  case 'email':
                    Pattern _emailPattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(_emailPattern);
                    if (value.isNotEmpty && (!regex.hasMatch(value))) {
                      setState(() {
                        hasError = true;
                      });
                      return '';
                    } else {
                      return null;
                    }
                    break;
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: widget.lableText,
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 16, color: Color(0x80323131)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0x66707070))),
                  contentPadding: EdgeInsets.fromLTRB(2, 5, 2, 12),
                  filled: false,
                  errorStyle: TextStyle(height: 0)),
              onChanged: (value) {
                // save the name value here
              },
            ),
          ),
          hasError
              ? Container(
                  height: 15,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 12,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${widget.errorText}',
                        style: GoogleFonts.poppins(
                            color: Colors.red, fontSize: 10),
                      )
                    ],
                  ),
                )
              : Container(
                  height: 15,
                ),
          SizedBox(
            height: 5,
            child: Container(
                //color: Colors.white,
                ),
          )
        ],
      ),
    );
  }
}
