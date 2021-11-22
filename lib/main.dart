import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackathon_11_21_21/Auth/Login.dart';
import 'package:hackathon_11_21_21/CreateOpp.dart';
import 'package:hackathon_11_21_21/Profile.dart';
import 'package:hackathon_11_21_21/Welcome.dart';
import 'FindOpps.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(volunTEEN());
}

class volunTEEN extends StatelessWidget {
  late Widget homePage;
  @override
  Widget build(BuildContext context) {
    getRootPage();
    return new MaterialApp(
      home: homePage
    );
  }

  getRootPage() async {
    // FirebaseAuth.instance.signOut();
    if (FirebaseAuth.instance.currentUser == null)
      homePage = Welcome(title: 'Welcome');
    else {
      homePage = DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          backgroundColor: Colors.blue,
          bottomNavigationBar: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(10),
              // gradient: LinearGradient(
              //   colors: [Color(0xFFEDD098), Color(0xFF97BFD8)],
              // ),
            ),
            child: TabBar(
              labelColor: Colors.white,
              tabs: [
                // Tab(
                //   text: 'Home',
                //   icon: Icon(Icons.home),
                // ),
                Tab(
                  text: 'Home',
                  icon: Icon(Icons.search),
                ),
                Tab(
                  text: 'Add',
                  icon: Icon(Icons.add),
                ),
                Tab(
                  text: 'Profile',
                  icon: Icon(Icons.person),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              // Home(),
              FindOpps(),
              CreateOpp(),
              Profile()
            ],
          ),
        ),
      );
    }
    print(homePage);
  }
}