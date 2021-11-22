import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

import 'Utilities.dart';

class CreateOpp extends StatefulWidget {
  @override
  CreateOppState createState() => CreateOppState();
}
class CreateOppState extends State<CreateOpp> {

  var segmentVal = 0;
  final Map<int, Widget> segmentTabs = const <int, Widget>{
    0: Text('In Person'),
    1: Text('Virtual')
  };

  final tagOptions = ['Select Tag', 'STEM', 'wildlife', 'community development', 'children services', 'education', 'law', 'finance'];
  var name;
  var address;
  var description;
  var hours;
  var tags = '';

  late String _setTime, _setDate;
  late String _hour, _minute, _time;
  late String dateTime;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _timeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _timeController.text = formatDate(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, '', am]).toString();
    _dateController.text = DateFormat.yMd().format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an Opportunity'),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name'
                ),
                onChanged: (String val) async {
                  name = val;
                },
                style: TextStyle(
                  color: Colors.red
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Hours'
                ),
                onChanged: (String val) async {
                  hours = val;
                },
                style: TextStyle(
                    color: Colors.red
                ),
              ),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.7,
                  height: MediaQuery.of(context).size.height / 9,
                  margin: EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: TextFormField(
                    style: TextStyle(fontSize: 40),
                    textAlign: TextAlign.center,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: _dateController,
                    onSaved: (val) {
                      _setDate = val!;
                    },
                    decoration: InputDecoration(
                        disabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.only(top: 0.0)),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _selectTime(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: TextFormField(
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                    onSaved: (val) {
                    },
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: _timeController,
                    decoration: InputDecoration(
                        disabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.all(0)),
                  ),
                ),
              ),
              CupertinoSlidingSegmentedControl(
                groupValue: segmentVal,
                children: segmentTabs,
                onValueChanged: (i) {
                  setState(() {
                    segmentVal = i.hashCode;
                    address = '';
                  });
                },
              ),
              segmentVal == 0 ? TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address'
                ),
                onChanged: (String val) async {
                  address = val;
                },
              ) : Container(),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description'
                ),
                onChanged: (String val) async {
                  description = val;
                },
              ),
              Text(
                tags
              ),
              DropdownButton<String>(
                value: 'Select Tag',
                icon: const Icon(Icons.arrow_drop_down_outlined),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                onChanged: (val) {
                  setState(() {
                    if (val! != 'Select Tag') {
                      tags = tags + val + ', ';
                    }
                  });
                },
                items: ['Select Tag', 'STEM', 'wildlife', 'community development', 'children services', 'education', 'law', 'finance'].map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              ButtonTheme(
                child: ElevatedButton(
                  child: Text(
                    'Add Event',
                    style: TextStyle(fontSize: 30.0, backgroundColor: Colors.blue, color: Colors.white),
                  ),
                  onPressed: () async {
                    try {
                      FirebaseFirestore.instance.collection('opportunities').doc().set({
                        'name': name,
                        'address': address,
                        'dateTime': DateFormat.yMd().format(selectedDate) + ' ' + _time,
                        'description': description,
                        'tags': tags,
                        'participants': '',
                        'confirmed': '',
                        'user': Utilities.read('user'),
                        'hours': hours,
                      });
                      setState(() {});
                      Utilities.displayAlert('Confirmation', 'Your event has been created!', context);
                    } catch (e) {
                      Utilities.displayAlert('Error', e.toString(), context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _time = formatDate(
            DateTime(2021, 05, 24, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
        _timeController.text = _time;
      });
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

}