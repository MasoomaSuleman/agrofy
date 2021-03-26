import 'package:flutter/material.dart';

// added dependencies
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
//screens
import 'Screens/signIn_screen.dart';
// app dependencies
import 'utils/AuthServices.dart';
import 'loading.dart';

import 'provider/user_details.dart';

import 'utils/SizeConfig.dart';
import 'utils/routers.dart';
import 'constants.dart';
import 'provider/MyLikesAndBookmarks.dart';
import 'Screens/Home/HomeScreen.dart';
import 'src/model/user/user_model.dart';
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final Firestore _firestore = Firestore.instance;
FirebaseUser firebaseUser;

DocumentSnapshot _temp;
List<String> _myLikes = [];

var userID;
String _linkMessage;
bool _isCreatingLink = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserDetails()),
        ChangeNotifierProvider.value(
          value: MyLikesAnsBookmarks(),
        ),
        ChangeNotifierProvider.value(
          value: User(),
        ),
      ],
      child: MaterialApp(
        title: 'Agrofy',
        theme: ThemeData(
          primaryColor: Colors.white,
          primarySwatch: generateMaterialColor(Colors.lightGreen[900]),
          visualDensity: VisualDensity.adaptivePlatformDensity
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
        onGenerateRoute: generateRoute,
      
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  void getUser() async {
    _firebaseAuth.currentUser().then((value) {
      if (value != null) {
        firebaseUser = value;
        _firestore
            .collection('userData')
            .document('${firebaseUser.uid}')
            .get()
            .then((snap) {
          _temp = snap;

          // set all the likes and bookmarks to a list

          _firestore
              .collection('likesData')
              .where('userId', isEqualTo: '${firebaseUser.uid}')
              .getDocuments()
              .then((value2) {
            if (value2.documents.isEmpty) {
              return null;
            } else {
              // adding all my liked answers to the list
              value2.documents.forEach((element) {
                _myLikes.add(element['answerId']);
              });
            }
          });

          setState(() {
            AuthServices.isLoading = false;
          });
        }).catchError((e) {
          print("main()''': error getting in user details $e");
        });
      } else {
        print("main()''':    No One Logged In");
        AuthServices.isLoading = false;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Signin()));
      }
    }).catchError((e) {
      print("main()''': error getting in user auth $e");
    });
  }

//  void postDummyQuestionsToFirebase() async {
//    for (var i in DummyQuestionsToUpload.QuestionListTOUpload) {
//      _firestore.collection('questionData').add(i.toMap());
//    }
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthServices.isLoading = true;
    getUser();
    // postDummyQuestionsToFirebase();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //TODO: remove the comments
    var userDetails = Provider.of<UserDetails>(context);
    User loggedInUser = Provider.of<User>(context);
//    MyLikesAnsBookmarks myLikesAnsBookmarks =
//        Provider.of<MyLikesAnsBookmarks>(context);
    try{
      if (AuthServices.isLoading == false && _temp != null) {
      loggedInUser.fromSnap(_temp);
      //TODO: The following statements will be removed after the previous implemnetaion is removed completely
      userDetails.setUserDetails(
          userID: _temp.documentID,
          userName: _temp['name'],
          userPhoneNumber: _temp['phoneNumber'],
          imageUrl: _temp['profileImageURl'],
          userOrganization: _temp['organization'],
          userProfession: _temp['profession'],
          userEmailID: _temp['email']);
      //myLikesAnsBookmarks.storeMyLikesAnswers(_myLikes);

    }
    // return ProfileSetupStep1();
    return AuthServices.isLoading ? LoadingFullScreen() : HomeScreen();
    }catch(e , t){
      return Signin();
    }
    //return MyProfileLandingPage();
  }
}
