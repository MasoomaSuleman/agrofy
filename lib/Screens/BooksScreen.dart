import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisaanCorner/provider/user_details.dart';
import 'package:provider/provider.dart';

//installed packages
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

//models
import '../Models/Book.dart';
import 'package:kisaanCorner/src/view/my_account_screen/my_account_landing_page.dart';

// app dependencies
import 'package:kisaanCorner/src/view/my_account_screen/widgets/custom_circular_profile_avatar.dart';

class BooksScreen extends StatefulWidget {
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

// use mixin to create tab alive
// use youtube video reference
//https://www.youtube.com/watch?v=YJEMMhA9udQ

class _BooksScreenState extends State<BooksScreen> {
  @override
  Widget build(BuildContext context) {
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
          title: Text(
            "Books",
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
        backgroundColor: Color(0xFFF8F8F8),
        body: GridView.count(
            childAspectRatio: 0.65,
            crossAxisCount: 2,
            // mainAxisSpacing: 5.0,
            padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            children: List.generate(Book.books.length, (index) {
              return bookGridCard(Book.books[index]);
            })));
  }

  // card tile of the books
  Widget bookGridCard(Book book) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      height: 220.0,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffA2A2A2), width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Image.asset(
              '${book.url}',
              width: double.infinity,
              height: 160,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
//            Text(
//              '${book.name}',
//              style:
//                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//            ),
          SizedBox(
            width: double.infinity - 20,
            height: 30.0,
            child: RaisedButton(
              onPressed: () {
                //to go tthe external link
                launch(book.buyPath);
              },
              color: Color(0xff2B2828),
              child: Text(
                "Buy",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  //indicator function for cached image place holder
  Widget _loader(BuildContext context, String url) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
