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
        backgroundColor: Colors.indigo,
        actions: [
          TextButton(
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.white,
              ),
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
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 150.0),
              child: Text(
                'Description',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 150.0),
              child: Text(
                info.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 150.0),
              child: Text(
                'Location',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 150.0),
              child: Text(
                "${info.address}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 150.0),
              child: Text(
                'Tags',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 150.0),
              child: Text(
                "${info.tags}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 150.0),
              child: Text(
                'Time',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
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
