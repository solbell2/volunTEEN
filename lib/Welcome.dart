import 'package:flutter/material.dart';

import 'Auth/Login.dart';

class Welcome extends StatefulWidget {

  const Welcome({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  WelcomeState createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> {
  final String _appName = 'volunTEEN';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome To $_appName!",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Our mission is to provide students with volunteering opportunities through the community. Lets get started!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(30),
            ),
            SizedBox(
                height: 30,
                width: 200,
                child:TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)){
                            return Colors.blue.withOpacity(0.04);}
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.pressed)){
                            return Colors.blue.withOpacity(0.12);}
                          return null;
                        },
                      ),
                    ),
                    onPressed: () => {Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()))},
                    child: const Text('Let\'s Get Started!')
                )
            )
          ],
        ),
      ),
    );
  }
}