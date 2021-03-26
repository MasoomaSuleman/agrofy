import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/src/view/home/widgets/other_user/other_user_experience_list.dart';

import 'package:intl/intl.dart';
class OtherUserExperience extends StatelessWidget {
  final List experienceList;
  OtherUserExperience({
   @required this.experienceList
    });
  @override
  Widget build(BuildContext context) {
    print(experienceList);
    return experienceList.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                          top: BorderSide(color: Color(0x40707070)),
                          bottom: BorderSide(color: Color(0x40707070)),
                          left: BorderSide(color: Color(0x40707070)),
                          right: BorderSide(color: Color(0x40707070)))),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Experience",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 16),
                        ),
                      ),
                      Divider(
                        color: Color(0x40707070),
                        thickness: 1.0,
                      ),
                     
                    ],
                  ),
                ),
              ],
            ),
          )
        : experienceList.length <=2? Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                          top: BorderSide(color: Color(0x40707070)),
                          bottom: BorderSide(color: Color(0x40707070)),
                          left: BorderSide(color: Color(0x40707070)),
                          right: BorderSide(color: Color(0x40707070)))),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Experience",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 16),
                        ),
                      ),
                      Divider(
                        color: Color(0x40707070),
                        thickness: 1.0,
                      ),
                      ListView.builder(itemCount: experienceList.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                      itemBuilder: (ctx, index){
                        
                        var monthname= DateFormat.MMM().format(DateTime.parse(experienceList[index]['startDate']));
                                var endmonthname= experienceList[index]['lastDate']=='null'? 'Present':DateFormat.MMM().format(DateTime.parse(experienceList[index]['lastDate'])) ;    
                                int mos =  experienceList[index]['lastDate']=='null'?( DateTime.now().difference(DateTime.parse(experienceList[index]['startDate'])).inDays/30).round() :(DateTime.parse(experienceList[index]['lastDate']).difference(DateTime.parse(experienceList[index]['startDate'])).inDays/30).round();
                                if(mos==0)
                                mos++;
                               return  Container(
                                height: 100,
                              child: Column(
                                children:<Widget>[
                                  ListTile(
                                     leading: Icon( Icons.card_travel,color: Colors.black,size: 40),
                    
                                     title: Text(experienceList[index]['companyName'] ,style: GoogleFonts.poppins(color: Colors.black,
                                                fontSize: 16),),
                                     subtitle: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(experienceList[index]['employmentType'] ,style: GoogleFonts.poppins(color: Colors.black,
                                                fontSize: 12),),
                                        Text('$monthname ${DateTime.parse(experienceList[index]['startDate']).year} - $endmonthname ${experienceList[index]['lastDate']!='null'? DateTime.parse(experienceList[index]['lastDate']).year: ""}  | $mos mos',style: GoogleFonts.poppins(color: Colors.black,
                                        fontSize: 10),)
                                       ],
                                     ),
                                   )
                                ]
                              )
                              );
                      }),
                     
                    ],
                  ),
                ),
              ],
            ),
          ): Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border(
                    top: BorderSide(color: Color(0x40707070)),
                    bottom: BorderSide(color: Color(0x40707070)),
                    left: BorderSide(color: Color(0x40707070)),
                    right: BorderSide(color: Color(0x40707070)))),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Experience",
                    style: GoogleFonts.poppins(
                        color: Colors.black, fontSize: 16),
                  ),
                ),
                Divider(
                  color: Color(0x40707070),
                  thickness: 1.0,
                ),
                 ListView.builder(itemCount:2,
                        shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index){

                  var monthname= DateFormat.MMM().format(DateTime.parse(experienceList[index]['startDate']));
                          var endmonthname= experienceList[index]['lastDate']=='null'? 'Present':DateFormat.MMM().format(DateTime.parse(experienceList[index]['lastDate'])) ;    
                          int mos =  experienceList[index]['lastDate']=='null'?( DateTime.now().difference(DateTime.parse(experienceList[index]['startDate'])).inDays/30).round() :(DateTime.parse(experienceList[index]['lastDate']).difference(DateTime.parse(experienceList[index]['startDate'])).inDays/30).round();
                          if(mos==0)
                          mos++;
                         return  Container(
                          height: 100,
                        child: Column(
                          children:<Widget>[
                            ListTile(
                               leading: Icon( Icons.card_travel,color: Colors.black,size: 40),
                    
                               title: Text(experienceList[index]['companyName'] ,style: GoogleFonts.poppins(color: Colors.black,
                                          fontSize: 16),),
                               subtitle: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(experienceList[index]['employmentType'] ,style: GoogleFonts.poppins(color: Colors.black,
                                          fontSize: 12),),
                                  Text('$monthname ${DateTime.parse(experienceList[index]['startDate']).year} - $endmonthname ${experienceList[index]['lastDate']!='null'? DateTime.parse(experienceList[index]['lastDate']).year: ""}  | $mos mos',style: GoogleFonts.poppins(color: Colors.black,
                                  fontSize: 10),)
                                 ],
                               ),
                             )
                          ]
                        )
                        );
                }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtherUsersExperienceList(
                            experienceList: experienceList,
                            ))),
                    child: Center(
                        child: Text(
                      "SEE ALL",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.lightGreen[900]),
                    )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
