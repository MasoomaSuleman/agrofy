import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
class OtherUsersExperienceList extends StatelessWidget {
  final List experienceList;
  OtherUsersExperienceList({
   @required this.experienceList
    });
  @override
  Widget build(BuildContext context) {
    
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
              ListView.builder(itemCount: experienceList.length,
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
               
            ]
            
          ),
        ),
      ),
    );
  }
}