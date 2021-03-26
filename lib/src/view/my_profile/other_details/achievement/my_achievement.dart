import 'package:flutter/material.dart';
import 'package:kisaanCorner/src/view/my_profile/other_details/achievement/editAchievments.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/view/my_profile/other_details/achievement/addNewAchievments.dart';
import 'package:kisaanCorner/src/view/my_profile/other_details/achievement/myAchievmentsList.dart';
import 'package:provider/provider.dart';

class MyAchievement extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<User>(context);
    return currentUser.achievementList.length<=2
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
                          "Achievments",
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
                          builder: (context) => EditAchievmentsList())))
                      ),
                      Divider(
                        color: Color(0x40707070),
                        thickness: 1.0,
                      ),
                      ListView.builder(itemCount: currentUser.achievementList.length,
                              shrinkWrap: true,
                      itemBuilder: (ctx, index){
                               var monthname= DateFormat.MMM().format(DateTime.parse(currentUser.achievementList[index].honorDate));
            
                               return  Container(
                                height: 100,
                              child: Column(
                                children:<Widget>[
                                   ListTile(
                                     leading: Container(
                                       width:40,
                                       height: 40,
                                       decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border(
                                    top: BorderSide(
                                        color: Colors.black,),
                                    bottom: BorderSide(
                                        color:  Colors.black),
                                    left: BorderSide(
                                        color: Colors.black),
                                    right: BorderSide(
                                        color: Colors.black))
                                    ),
                                     ),
              
                                     title: Text(currentUser.achievementList[index].occupation ,style: GoogleFonts.poppins(color: Colors.black,
                                                fontSize: 16),),
                                     subtitle: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(currentUser.achievementList[index].title ,style: GoogleFonts.poppins(color: Colors.black,
                                                fontSize: 12),),
                                         Text('$monthname ${DateTime.parse(currentUser.achievementList[index].honorDate).year}',style: GoogleFonts.poppins(color: Colors.black,
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
                                builder: (context) => AddNewAchievments(currentUser: currentUser,))),
                        child: Center(
                          child: Text("ADD NEW",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.lightGreen[900])),
                        ),
                      ),
                      )
                    ],
                  ),
                ),
                
              ],
            ),
          )
        :currentUser.achievementList.length>2
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
                              "Achievments",
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
                              builder: (context) => EditAchievmentsList()))),
                          ),
                          Divider(
                            color: Color(0x40707070),
                            thickness: 1.0,
                          ),
                          ListView.builder(itemCount:2,
                                  shrinkWrap: true,
                          itemBuilder: (ctx, index){
                                   var monthname= DateFormat.MMM().format(DateTime.parse(currentUser.achievementList[index].honorDate));
            
                                   return  Container(
                                    height: 100,
                                  child: Column(
                                    children:<Widget>[
                                       ListTile(
                                         leading: Container(
                                           width:40,
                                           height: 40,
                                           decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border(
                                        top: BorderSide(
                                            color: Colors.black,),
                                        bottom: BorderSide(
                                            color:  Colors.black),
                                        left: BorderSide(
                                            color: Colors.black),
                                        right: BorderSide(
                                            color: Colors.black))
                                        ),
                                         ),
              
                                         title: Text(currentUser.achievementList[index].occupation ,style: GoogleFonts.poppins(color: Colors.black,
                                                    fontSize: 16),),
                                         subtitle: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text(currentUser.achievementList[index].title ,style: GoogleFonts.poppins(color: Colors.black,
                                                    fontSize: 12),),
                                             Text('$monthname ${DateTime.parse(currentUser.achievementList[index].honorDate).year}',style: GoogleFonts.poppins(color: Colors.black,
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
                                      builder: (context) => MyAchievmentsList())),
                              child: Center(
                                  child: Text(
                                "SEE ALL",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.lightGreen[900],
                                ),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                
                  ],
                ),
              )
            : Padding(
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
                          "Achievments",
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
                          builder: (context) => EditAchievmentsList()))),
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
                                    builder: (context) => AddNewAchievments(currentUser: currentUser,))),
                            child: Center(
                              child: Text("ADD NEW",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.lightGreen[900])),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
