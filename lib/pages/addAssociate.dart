import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/model/associate.dart';
import 'package:registration/widgets/toast.dart';

import '../associateData.dart';

class AddAssociate extends StatefulWidget {
  @override
  _AddAssociateState createState() => _AddAssociateState();
}

class _AddAssociateState extends State<AddAssociate> {
  String name;
  int phone;
  bool senior;
  DateTime joined;
  int age;

  void _addAssociate(context) {
    if (name == null) {
      toastWidget("Get the name");
      return;
    }

    if (name.length < 2) {
      toastWidget("Make it longer");
      return;
    }
    Provider.of<AssociateData>(context, listen: false).addAssociates(
      Associate(
        name: name,
        age: age ?? 00,
        phone: phone ?? 00,
        joinDate: joined ?? DateTime.now(),
        isSenior: senior ?? false,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        elevation: 16.0,
        title: Text(
          "Add a member",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            iconSize: 24.0,
            color: Colors.blue,
            tooltip: "Save",
            onPressed: () {
              _addAssociate(context);
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Name",
                ),
                onChanged: (v) {
                  setState(() {
                    name = v;
                  });
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Phone",
                  ),
                  keyboardType: TextInputType.phone,
                  onChanged: (v) {
                    setState(
                      () {
                        phone = int.parse(v);
                      },
                    );
                  }),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                autofocus: true,
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                decoration: InputDecoration(hintText: "Age"),
                onChanged: (v) {
                  setState(() {
                    age = int.parse(v);
                  });
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Is Senior?",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                  Switch(
                    activeTrackColor: Colors.black,
                    activeColor: Colors.blue,
                    onChanged: (v) {
                      setState(
                        () {
                          senior = v;
                        },
                      );
                    },
                    value: senior ?? false,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Join Date",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      icon: Icon(Icons.calendar_today),
                      tooltip: 'Tap to open date picker',
                      onPressed: () async {
                        final DateTime d = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2101),
                        );
                        if (d != null) //if the user has selected a date
                          setState(() {
                            // we format the selected date and assign it to the state variable
                            joined = d;
                          });
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
