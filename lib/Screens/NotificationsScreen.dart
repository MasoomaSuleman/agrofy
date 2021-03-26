import 'package:flutter/material.dart';

//added Dependencies
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationsScreen extends StatefulWidget {
  final String uid;
  NotificationsScreen(this.uid);
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState(uid);
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final String uid;
  _NotificationsScreenState(this.uid);
  // ful votifications logic has to be changed
  // wherein they should be stored to local storage when recieved and tehn displayed
  // but for now they are stored in firebase under this users id and retrieved as a stream
  Firestore _firestore = Firestore.instance;
  Stream _stream;
  Future<void> getStream() async {
    _stream = _firestore
        .collection('notificationData')
        .where('userId', isEqualTo: uid)
        .snapshots();
  }

  @override
  void initState() {
    // TODO: implement initState
    getStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xFFF8F8F8),
            appBar: AppBar(
              backgroundColor: Colors.lightGreen[900],
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              title: Text(
                "Notifications",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: _stream,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  if (!snapshot.hasData) {
                    return Text("no Notifications to show");
                  }
                  return (snapshot.data.documents.isEmpty)
                      ? Center(child: Text("no Notifications to show"))
                      : ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot _temp =
                                snapshot.data.documents[index];
                            return NotificationTile(
                              notifyText: _temp['notifyText'],
                              date: _temp['notificationDate'],
                            );
                          });
                },
              ),
            )));
  }
}

class NotificationTile extends StatelessWidget {
  NotificationTile({
    this.date,
    this.notifyText,
  });

  final String notifyText;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
          dense: false,
          title: Text(
            "$notifyText",
            style: GoogleFonts.poppins(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  //"${timeago.format(DateTime.parse(date))}",
                  "${date.toString()}",
                  style:
                      GoogleFonts.poppins(color: Colors.grey, fontSize: 10.0),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
        )
      ],
    );
  }
}
