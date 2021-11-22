import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_11_21_21/Data%20Structures.dart';
import 'package:hackathon_11_21_21/Utilities.dart';

import 'EventDetails.dart';
import 'ParticipantsList.dart';

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
              backgroundColor: Colors.blue,
            ),
            body: Container(
              color: Colors.white,
              height: 1000,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          'Name:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                      child: Text(
                        '${name}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          'Email:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                      child: Text(
                        '${email}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          'Zip Code:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                      child: Text(
                        '${zipcode}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          'Hours',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                      child: Text(
                          '$hours',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          )
                      ),
                    ),
                    oppsGoing.length != 0 ? Text(
                        'Upcoming Events You\'re Attending',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        )
                    ) : Container(),
                    oppsGoing.length != 0 ? Container(
                      height: 105,
                      child: ListView.builder(
                        itemCount: oppsGoing.length,
                        itemBuilder: (context, i) {
                          return Card(
                            margin: new EdgeInsets.all(8),
                            child: ListTile(
                              title: Text(oppsGoing[i].name),
                              tileColor: Colors.amber[100],
                              subtitle: Text("${oppsGoing[i].dateTime}\n${oppsGoing[i].address}\nParticipants: ${oppsGoing[i].participants.split(', ').length-1}\n${oppsGoing[i].tags}"),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventDetails(info: oppsGoing[i])));
                              },
                            ),
                          );
                        },
                      ),
                    ) : Container(),
                    SizedBox(height: 20),
                    oppsManaged.length != 0 ? Text(
                        'Upcoming Events You\'re Hosting',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        )
                    ) : Container(),
                    oppsManaged.length != 0 ? Container(
                      height: 210,
                      child: ListView.builder(
                        itemCount: oppsManaged.length,
                        itemBuilder: (context, i) {
                          return Card(
                            child: ListTile(
                              title: Text(oppsManaged[i].name),
                              tileColor: Colors.amber[100],
                              subtitle: Text("${oppsManaged[i].dateTime}\n${oppsManaged[i].address}\nParticipants: ${oppsManaged[i].participants.split(', ').length-1}\n${oppsManaged[i].tags}"),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ParticipantsList(info: oppsManaged[i])));
                              },
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
        final confirmed = data['confirmed'] ?? '';
        final user = data['user'] ?? '';
        final hours = data['hours'] ?? '';
        final opp = Opportunity(id, name, address, dateTime, description, tags, participants, user, confirmed, int.parse(hours));
        print(user);
        if (user == username && !oppsManaged.contains(opp))
          oppsManaged.add(opp);
        else if (participants.split(' ,').contains(username) && !oppsGoing.contains(opp))
          oppsGoing.add(opp);
        print(oppsManaged);
        print(oppsGoing);
      });
    });
    print('loaded');
    infoLoaded = true;
  }
}