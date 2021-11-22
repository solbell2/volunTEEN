import 'package:hackathon_11_21_21/Auth/Login.dart';
import 'package:hackathon_11_21_21/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_11_21_21/Utilities.dart';

class SignUp extends StatelessWidget {
  var email = '';
  var user = '';
  var pass = '';
  var rePass = '';
  var zipcode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,

      body: Container(
        margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          children: <Widget>[
            // Image(
            //   height: 100,
            //   image: AssetImage('assets/Transparent Logo.png'),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child:Text("Sign Up!",style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username'
                ),
                onChanged: (String val) async {
                  user = val;
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child:TextField(
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email'
                ),
                onChanged: (String val) async {
                  email = val;
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child:TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password'
                ),
                onChanged: (String val) async {
                  pass = val;
                },
              ),
            ),


            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child:TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Re-enter Password'
                ),
                onChanged: (String val) async {
                  rePass = val;
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child:TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Zip Code (Optional)'
                ),
                onChanged: (String val) async {
                  zipcode = val;
                },
              ),
            ),

            ButtonTheme(
              child:Padding(
                padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
                child: ElevatedButton(
                  child: Text(
                    '                      Sign Up                     ',
                    style: TextStyle(fontSize: 20.0, backgroundColor: Colors.blue, color: Colors.white),
                  ),
                  onPressed: () async {
                    if (pass == rePass) {
                      try {
                        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: email,
                          password: pass,
                        );
                        FirebaseFirestore.instance.collection('users').doc(user).set({
                          'username': user,
                          'email': email,
                          'password': pass,
                          'hours': 0,
                          'zipcode': zipcode
                        });
                        Utilities.save('user', user);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => volunTEEN()));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          Utilities.displayAlert('Weak Password', 'Please ensure the password you entered has at least 6 characters.', context);
                        } else if (e.code == 'email-already-in-use') {
                          Utilities.displayAlert('Duplicate Email', 'An account with this email already exists. Please login into that account or sign up with a different email.', context);
                        }
                      } catch (e) {
                        Utilities.displayAlert('Error', e.toString(), context);
                      }
                    }
                    else {
                      Utilities.displayAlert('Passwords are Different', 'The passwords you entered are different. Please change them so that they are the same.', context);
                    }
                  },
                ),
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
                  'Already Have an Account? Login!',
                  style: TextStyle(
                    fontSize: 15.0,
                    backgroundColor: Colors.transparent,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
