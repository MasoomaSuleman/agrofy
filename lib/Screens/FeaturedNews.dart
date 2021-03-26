import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// added dependencies
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//app dependencies
import '../Models/News.dart';
import '../provider/user_details.dart';
import 'package:kisaanCorner/src/view/my_account_screen/my_account_landing_page.dart';
import 'package:kisaanCorner/src/view/my_account_screen/widgets/custom_circular_profile_avatar.dart';

class FeaturedScreen extends StatefulWidget {
  final FirebaseUser firebaseUser;
  FeaturedScreen({this.firebaseUser});
  @override
  _FeaturedScreenState createState() => _FeaturedScreenState(firebaseUser);
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  final FirebaseUser firebaseUser;
  _FeaturedScreenState(this.firebaseUser);
  Stream _stream = Firestore.instance.collection('featuredNews').snapshots();
  int check;
    @override
    void initState() {
      // TODO: implement initState
      check = 0;
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String userImageURL = Provider.of<UserDetails>(context).user_image_url;
    String userID = Provider.of<UserDetails>(context).user_id;
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.lightGreen[900],
      leading: Padding(
        padding: EdgeInsets.all(10),
        child: InkWell(
            onTap: () {
               Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyAccountLandingPage()));
            },
            child: CustomCircularProfileAvatar(30.0)),
      ),
      title: Center(
        child: Text(
          "News",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ),),
      backgroundColor: Color(0xFFF8F8F8),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  splashColor: Colors.lightGreen[900],
                  onTap: () {
                    setState(() {
                      check = 0;
                    });
                  },
                  child: Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: check == 0
                                      ? Colors.lightGreen[900]
                                      : Colors.white,
                                  width: 3.0))),
                      child: Text(
                        'News',
                        style: TextStyle(
                            color: check==0? Colors.lightGreen[900]: Colors.black, fontSize: 14.0),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.lightGreen[900],
                  onTap: () {
                    setState(() {
                      check = 1;
                    });
                  },
                  child: Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: check == 1
                                      ? Colors.lightGreen[900]
                                      : Colors.white,
                                  width: 3.0))),
                      child: Text(
                        'Opinions',
                        style: TextStyle(
                            color: check==1? Colors.lightGreen[900]:Colors.black, fontSize: 14.0),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.lightGreen[900],
                  onTap: () {
                    setState(() {
                      check = 2;
                    });
                  },
                  child: Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: check == 2
                                      ? Colors.lightGreen[900]
                                      : Colors.white,
                                  width: 3.0))),
                      child: Text(
                        'Tools',
                        style: TextStyle(
                            color:check==2? Colors.lightGreen[900]: Colors.black, fontSize: 14.0),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.lightGreen[900],
                  onTap: () {
                    setState(() {
                      check = 3;
                    });
                  },
                  child: Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: check == 3
                                      ? Colors.lightGreen[900]
                                      : Colors.white,
                                  width: 3.0))),
                      child: Text(
                        'Acts',
                        style: TextStyle(
                            color:check==3? Colors.lightGreen[900]: Colors.black, fontSize: 14.0),
                      ),
                    ),
                  ),
                ), Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: check != 3 &&
                                            check != 0 &&
                                            check != 1&& check!=2
                                        ? Colors.lightGreen[900]
                                        : Colors.white,
                                    width: 3.0))),
                        alignment: Alignment.centerRight,
                        child: Tab(
                          child: PopupMenuButton(
                            icon: Icon(Icons.menu,
                            color: check != 3 &&
                                check != 0 &&
                                check != 1&& check!=2
                            ? Colors.lightGreen[900]
                            : Colors.black
                            ),
                            onSelected: (val){
                              setState(() {
                                check = val;
                              });
                            },
                            itemBuilder: (BuildContext context)=>[
                              PopupMenuItem(child: Text("News"),
                              value: 0,

                              ),
                              PopupMenuItem(child: Text("Opinions"),
                              value: 1,

                              ),
                              PopupMenuItem(child: Text("Tools"),
                              value: 2,

                              ),
                              PopupMenuItem(child: Text("Acts"),
                              value: 3,

                              ),
                              PopupMenuItem(child: Text("Rules"),
                              value: 4,

                              ),
                              PopupMenuItem(child: Text("Forms"),
                              value: 5,

                              ),

                            ],
                          )
                        )),
              ],
            ),
          ),Expanded(
                      child:check==0? StreamBuilder(
                stream: _stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  if (!snapshot.hasData) {
                    print("FeaturedNews()''': no News added ");
                    return Text("No News added");
                  }
                  return  ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot docData = snapshot.data.documents[index];
                            News temp = News().fromMap(docData);
                            return newsPostCard(temp, size);
                          });
                },
              ): Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            /* Image(
               image:AssetImage(
              'assets/images/comingSoon.png',
                
            ),
             ) ,*/
              SizedBox(
                height: 10,
              ),
              Text(
                'We are coming for this news too.',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.lightGreen[900]),
              )
            ],
          )),
          ),
          
        ],
      ),
    );
  }

  Widget newsPostCard(News temp, Size size) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: Card(
          elevation: 2.0,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (temp.imageUrl?.isEmpty ?? true)
                    ? Container()
                    : Container(
                        height: 100.0,
                        width: size.width - 10,
                        child: Image.network(
                          '${temp.imageUrl}',
                          fit: BoxFit.contain,
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                  child: Text(
                    "${temp.headlineText}",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                  child: Text(
                    "${temp.text}",
                    style: GoogleFonts.poppins(),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
