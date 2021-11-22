import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_11_21_21/Data%20Structures.dart';
import 'package:hackathon_11_21_21/EventDetails.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class FindOpps extends StatefulWidget {
  @override
  FindOppsState createState() => FindOppsState();
}
class FindOppsState extends State<FindOpps> {

  late GoogleMapController map;
  List<Marker> markers = [];

  double userLat = 0.0;
  double userLong = 0.0;

  var segmentVal = 1;
  final Map<int, Widget> segmentTabs = const <int, Widget>{
    0: Text('In Person'),
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
      ),
      body: FutureBuilder(
        future: getOpps(),
        builder: (context, snapshot) {
          if (oppsLoaded) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  CupertinoSlidingSegmentedControl(
                    groupValue: segmentVal,
                    children: segmentTabs,
                    onValueChanged: (i) {
                      setState(() {
                        segmentVal = i.hashCode;
                      });
                    },
                  ),
                  // DropdownButton<String>(
                  //   value: selectedTag,
                  //   icon: const Icon(Icons.arrow_drop_down_outlined),
                  //   iconSize: 24,
                  //   elevation: 16,
                  //   style: const TextStyle(color: Colors.black),
                  //   onChanged: (val) {
                  //     setState(() {
                  //       selectedTag = val!;
                  //       if (selectedTag == 'All') {
                  //         specificOpps = opps;
                  //       }
                  //       else {
                  //         for (int i = 0; i < opps.length; i++) {
                  //           if (opps[i].tags.contains(selectedTag))
                  //             specificOpps.add(opps[i]);
                  //         }
                  //       }
                  //     });
                  //   },
                  //   items: ['All', 'STEM', 'wildlife', 'community development', 'children services', 'education', 'law', 'finance'].map<DropdownMenuItem<String>>((value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(value),
                  //     );
                  //   }).toList(),
                  // ),
                  segmentVal == 0 ? setupInPerson() : setupVirtual(),
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
    // if (defaultTargetPlatform == TargetPlatform.android) {
    //   AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    // }
    return Container(
      height: MediaQuery.of(context).size.height - 200,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: 500,
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              map = controller;
            },
            markers: markers.toSet(),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
                target: LatLng(userLat, userLong),
                zoom: 12
            ),
          )
        ),
      ),
    );
  }

  Widget setupVirtual() {
    return Expanded(
      child: ListView.builder(
        itemCount: opps.length,
        itemBuilder: (context, i) {
          if (opps[i].address == '') {
            return Card(
              child: ListTile(
                title: Text(opps[i].name),
                subtitle: Text("${opps[i].dateTime}\n${opps[i].address}\nParticipants: ${opps[i].participants.split(', ').length-1}\n${opps[i].tags}"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventDetails(info: opps[i])));
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  getOpps() async {
    if (!oppsLoaded) {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) {
        setState(() {
          userLat = position.latitude;
          userLong = position.longitude;
        });
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
          final opp = Opportunity(id, name, address, dateTime, description,
              tags, participants, user, confirmed, int.parse(hours));
          print(opp);
          opps.add(opp);
          if (address != '') {
            final special = (await locationFromAddress(address)).first;
            print('hi');
            markers.add(
                Marker(
                  markerId: MarkerId(name),
                  position: LatLng(special.latitude, special.longitude),
                  infoWindow: InfoWindow(
                    title: name,
                    snippet: dateTime,
                    onTap: () {
                      print('hi');
                      print(opps[opps.indexWhere((element) => element.name == name)]);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventDetails(info: opps[opps.indexWhere((element) => element.name == name)])));
                    }
                  ),
                )
              );
            }
        });
      });
      oppsLoaded = true;
    }
  }
}