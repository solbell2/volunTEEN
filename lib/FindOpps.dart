import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_11_21_21/Data%20Structures.dart';
import 'package:hackathon_11_21_21/EventDetails.dart';

class FindOpps extends StatefulWidget {
  @override
  FindOppsState createState() => FindOppsState();
}
class FindOppsState extends State<FindOpps> {

  var segmentVal = 1;
  final Map<int, Widget> segmentTabs = const <int, Widget>{
    0: Text('Physical'),
    1: Text('Virtual')
  };

  var opps = [];
  var oppsLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Opportunities'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),

      body: FutureBuilder(
        future: getOpps(),
        builder: (context, snapshot) {
          if (oppsLoaded) {
            return Container(

              child: Column(

                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child:CupertinoSlidingSegmentedControl(

                      groupValue: segmentVal,
                      children: segmentTabs,
                      onValueChanged: (i) {
                        setState(() {
                          segmentVal = i.hashCode;
                        });
                      },
                    ),
                  ),
                  segmentVal == 0 ? setupInPerson() : setupVirtual()
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget setupInPerson() {
    return Container();
  }

  Widget setupVirtual() {
    return Expanded(
      child: ListView.builder(
        itemCount: opps.length,
        itemBuilder: (context, i) {
          return Card(
            margin: new EdgeInsets.all(8),
            child: ListTile(
              title: Text(opps[i].name),
              tileColor: Colors.amber[100],
              subtitle: Text("${opps[i].dateTime}\n${opps[i].address}\nParticipants: ${opps[i].participants.split(', ').length-1}\n${opps[i].tags}"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventDetails(info: opps[i])));
              },
            ),
          );
        },
      ),
    );
  }

  getOpps() async {
    if (!oppsLoaded) {
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
          final user = data['user'] ?? '';
          final opp = Opportunity(id, name, address, dateTime, description,
              tags, participants, user);
          print(opp);
          opps.add(opp);
        });
      });
    }
    oppsLoaded = true;
  }
}
