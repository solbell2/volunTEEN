import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_11_21_21/Data%20Structures.dart';
import 'package:hackathon_11_21_21/Utilities.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {

  var oppsGoing = [];
  var oppsManaged = [];
  var name = '';
  var email = '';
  var zipcode = '';
  var hours = '';

  var infoLoaded = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserInfo(),
      builder: (context, i) {
        if (infoLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
              centerTitle: true,
            ),
            body: Container(
              color: Colors.white,
              height: 600,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      '${name}\n$email\n$zipcode',
                    ),
                    Text(
                      '$hours Hours'
                    ),
                    oppsGoing.length != 0 ? Text(
                      'Upcoming Events You\'re Attending'
                    ) : Container(),
                    oppsGoing.length != 0 ? Container(
                      height: 300,
                      child: ListView.builder(
                        itemCount: oppsGoing.length,
                        itemBuilder: (context, i) {
                          return Card(
                            child: ListTile(
                              title: Text(oppsGoing[i].name),
                              subtitle: Text("${oppsGoing[i].dateTime}\n${oppsGoing[i].address}\nParticipants: ${oppsGoing[i].participants.split(', ').length-1}\n${oppsGoing[i].tags}"),
                            ),
                          );
                        },
                      ),
                    ) : Container(),
                    oppsManaged.length != 0 ? Text(
                      'Upcoming Events You\'re Hosting'
                    ) : Container(),
                    oppsManaged.length != 0 ? Container(
                      height: 300,
                      child: ListView.builder(
                        itemCount: oppsManaged.length,
                        itemBuilder: (context, i) {
                          return Card(
                            child: ListTile(
                              title: Text(oppsManaged[i].name),
                              subtitle: Text("${oppsManaged[i].dateTime}\n${oppsManaged[i].address}\nParticipants: ${oppsManaged[i].participants.split(', ').length-1}\n${oppsManaged[i].tags}"),
                            ),
                          );
                        },
                      ),
                    ) : Container(),
                  ],
                ),
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  getUserInfo() async {
    final username = await Utilities.read('user');
    print(username);
    await FirebaseFirestore.instance.collection('users').doc(username).get().then((qs) {
      var data = qs.data()!;
      name = data['username'] ?? '';
      email = data['email'] ?? '';
      hours = data['hours'] ?? '';
      zipcode = data['zipcode'] ?? '';
    });
    await FirebaseFirestore.instance.collection('opportunities').get().then((qs) {
      qs.docs.forEach((element) async {
        var data = element.data();
        String id = element.id;
        final name = data['name'] ?? '';
        final address = data['address'] ?? '';
        final dateTime = data['dateTime'] ?? '';
        final description = data['description'] ?? '';
        final tags = data['tags'] ?? '';
        final participants = data['participants'] ?? '';
        final user = data['username'] ?? '';
        final opp = Opportunity(id, name, address, dateTime, description, tags, participants, user);
        print(user);
        if (user == username && !oppsManaged.contains(opp))
          oppsManaged.add(opp);
        else if (participants.split(' ,').contains(username) && !oppsGoing.contains(opp))
          oppsGoing.add(opp);
      });
    });
    print('loaded');
    infoLoaded = true;
  }
}