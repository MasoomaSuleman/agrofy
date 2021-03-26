import 'package:flutter/material.dart';
import 'package:kisaanCorner/src/view/my_profile/other_details/achievement/edit_one_achievment.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/src/view/my_profile/other_details/achievement/addNewAchievments.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:provider/provider.dart';
class EditAchievmentsList extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[900],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            // go to previous page
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            "Edit Achievments",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children:<Widget> [
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
              
                child: 
                  Text(
                    "Achievments",
                    style: GoogleFonts.poppins(color: Colors.black,fontSize: 16),
                  )
                
            ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Divider(color: Colors.grey,),
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
                   trailing: IconButton(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(0),
                  iconSize: 20,
                  icon: Icon(Icons.edit),
                  color: Color(0xB32D2D2D),
                  onPressed:()=>Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditAchievment(ach: currentUser.achievementList[index],index:index)))),
                    
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
                onTap: ()=>Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddNewAchievments(currentUser: currentUser,))),
                                  child: Center(
                  child: Text("ADD NEW",style: GoogleFonts.poppins(
                   fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.lightGreen[900]),)
                  ),
              ),
            )
          ]
          
        ),
      ),
    );
  }
}