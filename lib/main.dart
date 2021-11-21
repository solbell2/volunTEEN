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
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Color(0xFFEDD098), //Green
        accentColor: Color(0xFF97BFD8), // Blue
        shadowColor: Color(0xFF8CC090), //Brown

        // Define the default font family.
        fontFamily: 'Raleway',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0),
          headline6: TextStyle(fontSize: 36.0),
          bodyText2: TextStyle(fontSize: 14.0),
        ),
      ),
      home: homePage
    );
  }

  getRootPage() async {
    // FirebaseAuth.instance.signOut();
    if (FirebaseAuth.instance.currentUser == null)
      homePage = Welcome(title: 'Welcome');
    else {
      homePage = DefaultTabController(
        length: 5,
        initialIndex: 0,
        child: Scaffold(
          backgroundColor: Colors.indigo,
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
                  // text: 'Discover',
                  icon: Icon(Icons.search),
                ),
                Tab(
                  // text: 'Opportunities',
                  icon: Icon(Icons.list),
                ),
                Tab(
                  // text: 'Create',
                  icon: Icon(Icons.add),
                ),
                Tab(
                  // text: 'Home',
                  icon: Icon(Icons.home),
                ),
                Tab(
                  // text: 'Profile',
                  icon: Icon(Icons.person),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              // Home(),
              FindOpps(),
              FindOpps(),
              CreateOpp(),
              FindOpps(),
              Profile()
            ],
          ),
        ),
      );
    }
    print(homePage);
  }
}
