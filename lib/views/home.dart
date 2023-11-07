import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'inbox.dart';

class Homeview extends StatelessWidget {
  //  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // DocumentSnapshot documentSnapshot = firestore.collection('name').doc('GIhYYEl2Ll4oCiMu5zRp').get();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("wechat"),
          // leading: Icon(Icons.camera),
          actions: const [
            Icon(Icons.search),
            SizedBox(
              width: 15.0,
            ),
            Icon(Icons.camera_alt_outlined),
            SizedBox(
              width: 15.0,
            ),
            Icon(Icons.menu),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person)),
              Tab(
                text: "Chats",
              ),
              Tab(
                text: "Status",
              ),
              Tab(
                text: "Calls",
              ),
            ],
          ), //
        ),
        body: TabBarView(
          children: [
            Icon(Icons.music_note),
            ListView_list(context),
            Icon(Icons.camera_alt),
            Icon(Icons.grade),
          ],
        ),
        endDrawer: Drawer(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('This is the Drawer'),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => InboxView()),
                    // );
                  },
                  child: const Text('Close Drawer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

ListView_list(BuildContext buildContext) {
  return ListView.builder(
    padding: EdgeInsets.all(8),
    itemCount: 10,
    itemBuilder: (BuildContext context, int index) {
      // String itemTitle = "List Item ${list[index]}";
      return Expanded(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            // stream:Firestore.instance.collection('users').limit(_limit).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);

                final data = snapshot.data?.docs.reversed.toList();

                for (var i in data!) {
                  log("data: ${i.data}");

                  print(i.data());
                }
                return ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.docs
                        .map<Widget>((doc) => Buldlistitem(doc, context))
                        .toList());
              }
              //   return ListView.builder(
              //     padding: EdgeInsets.all(10.0),
              //     itemBuilder: snapshot.data!.docs
              //             .map<Widget>((doc) => Buldlistitem(doc, context)),
              //     // itemBuilder: (context, index) =>
              //     //     Buldlistitem(document, context),
              //     itemCount: snapshot.data?.docs.length,
              //   );
              // }
              else {
                return Container(child: CircularProgressIndicator());
              }
              // return ListView(
              //     children: snapshot.data!.docs
              //         .map<Widget>((doc) => Buldlistitem(doc))
              //         .toList());

              // ListView.builder(
              // itemCount: snapshot.data?.docs.length,
              // itemBuilder: (context, index) {},
              // buildItem(context, snapshot.data?.docs[index]),
              // ),
              // ListTile(
              //       title: Text("snapshot.data!.docs[index]"),
              //       leading: CircleAvatar(
              //         radius: 20.0,
              //         backgroundColor: Colors.green,
              //       ),
              //       subtitle: Text("Subtitle of list item"),
              //       trailing: Text("17:00 ")),

              // ),
            }),
      );
    },
  );
}

Widget Buldlistitem(DocumentSnapshot document, context) {
  // Map<String, dynamic> data2 = data as Map<String, dynamic>;
  var data = FirebaseAuth.instance.currentUser;

  // print(document.data());
  log("dayta----${data}");
  log("dayta- email ---${data?.email}");
  // log("email data: ${data2["name"]}");
  return ListTile(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InboxView(
                  recieverUid: data.displayName ?? "",
                  recieveremail: data.email ?? "",
                )),
      );
    },
    leading: CircleAvatar(backgroundColor: Colors.amber),
    title: Text(data!.email ?? ""),
    subtitle: Text(data.displayName ?? "aisha"),
    // trailing: Text(data.metadata.lastSignInTime?.minute ),
  );
}
