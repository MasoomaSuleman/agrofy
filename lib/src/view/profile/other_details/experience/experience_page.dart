import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/src/model/user/other_details/experience_model.dart';
import 'package:kisaanCorner/src/view/profile/personal_information/widgets/custom_editfield_wrapper.dart';

import 'package:intl/intl.dart';
enum TextFiledTypeEnum {
  title,
  companyName,
  location
}
class ExperiencePage extends StatefulWidget {
  final Experience experienceItem;
  ExperiencePage({
    @required this.experienceItem,
  });
  @override
  _ExperiencePageState createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  String enumToString(Object o) => o.toString().split('.').last;
  var _types = ['Part time', 'Full time'];
  var _currentItemSelected ='Full time';
  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate;
  bool _currentrole = true;
   @override
   void initState(){
     super.initState();
     _currentItemSelected= widget.experienceItem.employmentType==null? 'Full time':widget.experienceItem.employmentType ;
    _currentrole = widget.experienceItem.showProfile==null? true: widget.experienceItem.showProfile;
    _selectedStartDate = widget.experienceItem.startDate==null? DateTime.now() :DateTime.parse(widget.experienceItem.startDate);
   _selectedEndDate = widget.experienceItem.lastDate==null||widget.experienceItem.lastDate=="null"? null: DateTime.parse(widget.experienceItem.lastDate);
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

  Future<void> _presentEndDatePicker() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime(1999),
      lastDate: DateTime(2021),
    );
    if (picked != null) {
      setState(() {
        _selectedEndDate = picked;
      });
    }
    print(_selectedEndDate);
  }

  @override
  Widget build(BuildContext context) {
    widget.experienceItem.employmentType= _currentItemSelected;
    widget.experienceItem.lastDate = _selectedEndDate.toString();
    widget.experienceItem.startDate = _selectedStartDate.toString();
    widget.experienceItem.showProfile= _currentrole;
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          CustomEditFieldWrapper(
              experienceModel: widget.experienceItem,
              textFieldType: enumToString(TextFiledTypeEnum.title),
              fieldHeight: 35)
          .addEditText(),
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  text: new TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: 'Employment Type ',
                      style:
                          GoogleFonts.poppins(color: Colors.grey, fontSize: 10),
                    ),
                    TextSpan(
                      text: '*',
                      style:
                          GoogleFonts.poppins(color: Colors.red, fontSize: 10),
                    )
                  ]),
                ),
              ],
            ),
          ),
         
              SizedBox(
                  height: 35,
                  child: DropdownButton(
                    items: _types.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Container(
                        width: MediaQuery.of(context).size.width*0.7,
                       child: Text(
                          '$dropDownStringItem ',
                          style: TextStyle(color: Colors.black),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ));
                    }).toList(),
                    onChanged: (String newValueSelected) {
                      setState(() {
                        this._currentItemSelected = newValueSelected;
                      });
                    },
                    value: _currentItemSelected,
                  )),
            
          Divider(
            color: Colors.transparent,
          ),
          Divider(
            color: Colors.transparent,
          ),
          CustomEditFieldWrapper(
              experienceModel: widget.experienceItem,
              textFieldType: enumToString(TextFiledTypeEnum.companyName),
              fieldHeight: 35)
          .addEditText(),
          /*Divider(
            color: Colors.transparent,
          ),*/
          CustomEditFieldWrapper(
              experienceModel: widget.experienceItem,
              textFieldType: enumToString(TextFiledTypeEnum.location),
              fieldHeight: 70)
          .addEditText(),
          /*Divider(
            color: Colors.transparent,
          ),*/
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: InkWell(
                  onTap: () => _presentDatePicker(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        text: new TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: 'Start Date ',
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
                   
           
              Expanded(
                flex: 3,
                child: InkWell(
                  onTap: () => _presentEndDatePicker(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        text: new TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: 'Last Date ',
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
                            Text(_selectedEndDate == null
                                ? 'Present'
                                : DateFormat.yMd().format(_selectedEndDate)),
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
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),
          Row(
            children: <Widget>[
              Checkbox(
                  activeColor: Colors.lightGreen[900],
                  checkColor: Colors.white,
                  hoverColor: Colors.lightGreen[900],
                  focusColor: Colors.lightGreen[900],
                  value: _currentrole,
                  onChanged: (val) {
                    setState(() {
                      _currentrole = val;
                    });
                  }),
              Flexible(
                child: Text(
                  'I currently work in this role and this will be on my headline',
                  style: GoogleFonts.poppins(
                      fontSize: 10, fontWeight: FontWeight.w500),
                  maxLines: 4,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
