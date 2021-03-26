import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/view/my_profile/other_details/experience/addNewExperience.dart';
import 'package:kisaanCorner/src/view/my_profile/other_details/experience/editExperience.dart';
import 'package:kisaanCorner/src/view/my_profile/other_details/experience/myExperienceList.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
class MyExperience extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<User>(context);
    return currentUser.experienceList.isEmpty
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
                        trailing: IconButton(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(0),
                            iconSize: 20,
                            icon: Icon(Icons.edit),
                            color: Color(0xB32D2D2D),
                            onPressed: ()=>Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditExperienceList()))),
                      ),
                      Divider(
                        color: Color(0x40707070),
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddNewExperience(currentUser: currentUser))),
                          child: Center(
                              child: Text(
                            "ADD NEW",
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
          )
        : currentUser.experienceList.length <=2? Padding(
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
                        trailing: IconButton(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(0),
                            iconSize: 20,
                            icon: Icon(Icons.edit),
                            color: Color(0xB32D2D2D),
                            onPressed: ()=>Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditExperienceList()))),
                      ),
                      Divider(
                        color: Color(0x40707070),
                        thickness: 1.0,
                      ),
                      ListView.builder(itemCount: currentUser.experienceList.length,
                              shrinkWrap: true,
                      itemBuilder: (ctx, index){
                        
                        var monthname= DateFormat.MMM().format(DateTime.parse(currentUser.experienceList[index].startDate));
                                var endmonthname= currentUser.experienceList[index].lastDate=='null'? 'Present':DateFormat.MMM().format(DateTime.parse(currentUser.experienceList[index].lastDate)) ;    
                                int mos =  currentUser.experienceList[index].lastDate=='null'?( DateTime.now().difference(DateTime.parse(currentUser.experienceList[index].startDate)).inDays/30).round() :(DateTime.parse(currentUser.experienceList[index].lastDate).difference(DateTime.parse(currentUser.experienceList[index].startDate)).inDays/30).round();
                                if(mos==0)
                                mos++;
                               return  Container(
                                height: 100,
                              child: Column(
                                children:<Widget>[
                                  ListTile(
                                     leading: Icon( Icons.card_travel,color: Colors.black,size: 40),
                    
                                     title: Text(currentUser.experienceList[index].companyName ,style: GoogleFonts.poppins(color: Colors.black,
                                                fontSize: 16),),
                                     subtitle: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(currentUser.experienceList[index].employmentType ,style: GoogleFonts.poppins(color: Colors.black,
                                                fontSize: 12),),
                                        Text('$monthname ${DateTime.parse(currentUser.experienceList[index].startDate).year} - $endmonthname ${currentUser.experienceList[index].lastDate!='null'? DateTime.parse(currentUser.experienceList[index].lastDate).year: ""}  | $mos mos',style: GoogleFonts.poppins(color: Colors.black,
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
                                builder: (context) => AddNewExperience(currentUser: currentUser))),
                        child: Center(
                            child: Text(
                          "ADD NEW",
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
                  trailing: IconButton(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(0),
                      iconSize: 20,
                      icon: Icon(Icons.edit),
                      color: Color(0xB32D2D2D),
                      onPressed: ()=>Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditExperienceList()))),
                ),
                Divider(
                  color: Color(0x40707070),
                  thickness: 1.0,
                ),
                 ListView.builder(itemCount:2,
                        shrinkWrap: true,
                itemBuilder: (ctx, index){
                        var monthname= DateFormat.MMM().format(DateTime.parse(currentUser.experienceList[index].startDate));
                        var endmonthname= currentUser.experienceList[index].lastDate=='null'? 'Present':DateFormat.MMM().format(DateTime.parse(currentUser.experienceList[index].lastDate)) ;    
                        int mos =  currentUser.experienceList[index].lastDate=='null'? (DateTime.now().difference(DateTime.parse(currentUser.experienceList[index].startDate)).inDays/30).round() :(DateTime.parse(currentUser.experienceList[index].lastDate).difference(DateTime.parse(currentUser.experienceList[index].startDate)).inDays/30).round();
                        if(mos==0)
                        mos++;
                         return  Container(
                          height: 100,
                        child: Column(
                          children:<Widget>[
                            ListTile(
                               leading: Icon( Icons.card_travel,color: Colors.black,size: 40),
                    
                               title: Text(currentUser.experienceList[index].companyName ,style: GoogleFonts.poppins(color: Colors.black,
                                          fontSize: 16),),
                               subtitle: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(currentUser.experienceList[index].employmentType ,style: GoogleFonts.poppins(color: Colors.black,
                                          fontSize: 12),),
                                  Text('$monthname ${DateTime.parse(currentUser.experienceList[index].startDate).year} - $endmonthname ${currentUser.experienceList[index].lastDate!='null'? DateTime.parse(currentUser.experienceList[index].lastDate).year: ""}  | $mos mos',style: GoogleFonts.poppins(color: Colors.black,
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
                            builder: (context) => MyExperienceList())),
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
