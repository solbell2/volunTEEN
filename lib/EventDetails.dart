import 'package:flutter/material.dart';
import 'package:hackathon_11_21_21/Data%20Structures.dart';
import 'package:hackathon_11_21_21/Utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({Key? key, required this.info}) : super(key: key);
  final Opportunity info;

  @override
  EventDetailsState createState() => EventDetailsState(info);
}

class EventDetailsState extends State<EventDetails> {

  Opportunity info;
  EventDetailsState(this.info);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(info.name),
        centerTitle: true,
        actions: [
          TextButton(
            child: Text(
              'Sign Up'
            ),
            onPressed: () async {
              await FirebaseFirestore.instance.collection('opportunities').doc(info.id).update({
                'participants': info.participants + await Utilities.read('user') + ', ',
              });
              Utilities.displayAlert('Confirmation', 'You have been signed up for this event!', context);
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                info.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Location: ${info.address}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Tags: ${info.tags}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                info.dateTime,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}