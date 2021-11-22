import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParticipantsList extends StatefulWidget {
  final info;
  ParticipantsList({this.info});
  @override
  ParticipantsListState createState() => ParticipantsListState(info);
}

class ParticipantsListState extends State<ParticipantsList> {
  final info;
  ParticipantsListState(this.info);

  List<String> currentConfirmed = [];
  List<String> participantList = [];

  @override
  void initState() {
    currentConfirmed = info.confirmed.split(', ');
    participantList = info.participants.split(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Participants'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: [
          TextButton(
            child: Text('Verify', style: TextStyle(color: Colors.white),),
            onPressed: () async {
              await FirebaseFirestore.instance.collection('opportunities').doc(info.id).update({
                'confirmed': currentConfirmed.join(', '),
              });
              for (int i = 0; i < currentConfirmed.length; i++) {
                if (info.confirmed.contains(currentConfirmed[i])) {
                  int hours = 0;
                  await FirebaseFirestore.instance.collection('users').doc(currentConfirmed[i]).get().then((qs) {
                    hours = qs.data()!['hours'] ?? 0;
                  });
                  await FirebaseFirestore.instance.collection('users').doc(currentConfirmed[i]).update({
                    'hours': hours + info.hours,
                  });
                }
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Expanded(
          child: ListView.builder(
            itemCount: participantList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, i) {
              return Card(
                color: currentConfirmed.contains(participantList[i]) ? Colors.green : Colors.white,
                child: ListTile(
                  title: Text(participantList[i]),
                  onTap: () {
                    setState(() {
                      currentConfirmed.contains(participantList[i]) ? currentConfirmed.remove(participantList[i]) : currentConfirmed.add(participantList[i]);
                    });
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}