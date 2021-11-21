import 'package:hackathon_11_21_21/Auth/SignUp.dart';
import 'package:hackathon_11_21_21/Utilities.dart';
import 'package:hackathon_11_21_21/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatelessWidget {
  var email = '';
  var pass = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          children: <Widget>[
            // Image(
            //   height: 100,
            //   image: AssetImage('assets/Transparent Logo.png'),
            // ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email'
              ),
              onChanged: (String val) async {
                email = val;
              },
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password'
              ),
              onChanged: (String val) async {
                pass = val;
              },
            ),
            ButtonTheme(
              child: ElevatedButton(
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 30.0, backgroundColor: Colors.blue, color: Colors.white),
                ),
                onPressed: () async {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email,
                        password: pass
                    );
                    await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get().then((qs) {
                      qs.docs.forEach((element) {
                        print(element.data()['username']);
                        Utilities.save('user', element.data()['username']);
                      });
                    });
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => volunTEEN()));
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      Utilities.displayAlert('User not Found', 'No user was found for the email you entered. Please enter a different email or create an account.', context);
                    } else if (e.code == 'wrong-password') {
                      Utilities.displayAlert('Incorrect Password', ('The password you entered is incorrect. Please try again'), context);
                    }
                  }
                },
              ),
            ),
            Spacer(),
            ButtonTheme(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  'Don\'t have an account? Sign Up!',
                  style: TextStyle(
                    fontSize: 18.0,
                    backgroundColor: Colors.transparent,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
