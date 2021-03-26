import 'package:flutter/material.dart';
import 'package:kisaanCorner/src/model/user/user_model.dart';
import 'package:kisaanCorner/src/view/my_profile/other_details/experience/editExperience.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/src/view/my_profile/other_details/experience/addNewExperience.dart';
import 'package:provider/provider.dart';

class MyExperienceList extends StatelessWidget {
  
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
            "Experience",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
            onTap: ()  {
              Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditExperienceList()));
            },
            child: Center(
              child: Text(
                "Edit",
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        )
      ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
                  child: Column(
            children:<Widget> [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
                
                  child: 
                    Text(
                      "Experience",
                      style: GoogleFonts.poppins(color: Colors.black,fontSize: 16),
                    )
                  
              ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Divider(color: Colors.grey,),
                 ),
              ListView.builder(itemCount: currentUser.experienceList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
                  onTap: ()=>Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddNewExperience(currentUser: currentUser,) )),
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
      ),
    );
  }
}