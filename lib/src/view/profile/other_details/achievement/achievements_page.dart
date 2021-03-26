import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/src/model/user/other_details/achievment_model.dart';
import 'package:kisaanCorner/src/view/profile/personal_information/widgets/custom_editfield_wrapper.dart';

import 'package:intl/intl.dart';
enum TextFiledTypeEnum {
  titleA,
  occupationName,
  issuer
}
class AchievmentsPage extends StatefulWidget {
  final Achievements achievmentsItem;
  AchievmentsPage({
    @required this.achievmentsItem,
  });
  @override
  _AchievmentsPageState createState() => _AchievmentsPageState();
}

class _AchievmentsPageState extends State<AchievmentsPage> {
  String enumToString(Object o) => o.toString().split('.').last;
  DateTime _selectedStartDate = DateTime.now();
  void initState(){
     super.initState();
    _selectedStartDate = widget.achievmentsItem.honorDate==null? DateTime.now() :DateTime.parse(widget.achievmentsItem.honorDate);
   }  

  Future<void> _presentDatePicker() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(2021),
    );
    if (picked != null) {
      setState(() {
        _selectedStartDate = picked;
      });
    }
    print(_selectedStartDate);
  }

  @override
  Widget build(BuildContext context) {
    widget.achievmentsItem.honorDate  = _selectedStartDate.toString();
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(children: <Widget>[
        CustomEditFieldWrapper(
            achievmentsModel: widget.achievmentsItem,
            textFieldType: enumToString(TextFiledTypeEnum.titleA),
            fieldHeight: 35)
        .addEditText(),
        Divider(
          color: Colors.transparent,
        ),
        CustomEditFieldWrapper(
            achievmentsModel: widget.achievmentsItem,
            textFieldType: enumToString(TextFiledTypeEnum.occupationName),
            fieldHeight: 35)
        .addEditText(),
        Divider(
          color: Colors.transparent,
        ),
        CustomEditFieldWrapper(
            achievmentsModel: widget.achievmentsItem,
            textFieldType: enumToString(TextFiledTypeEnum.issuer),
            fieldHeight: 35)
        .addEditText(),
        Divider(
          color: Colors.transparent,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () => _presentDatePicker(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: new TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: 'Honor Date ',
                          style: GoogleFonts.poppins(
                              color: Colors.grey, fontSize: 10),
                        ),
                        TextSpan(
                          text: '*',
                          style: GoogleFonts.poppins(
                              color: Colors.red, fontSize: 10),
                        )
                      ]),
                    ),
                    InputDecorator(
                      decoration: InputDecoration(
                        labelText: null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(_selectedStartDate == null
                              ? 'No Date Chosen'
                              : DateFormat.yMd().format(_selectedStartDate)),
                          Icon(Icons.arrow_drop_down,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.grey.shade700
                                  : Colors.white70),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.0),
          ],
        ),
        Divider(
          color: Colors.transparent,
        ),
      ]),
    );
  }
}
