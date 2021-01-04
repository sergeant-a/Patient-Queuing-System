import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login-register.dart' as log;
import 'package:firebase_auth/firebase_auth.dart';
class SecondPage extends StatefulWidget {
  final Days;
  final Department;
  final Doctor;
  final Time;
  final Data;
  SecondPage({Key key,this.Days,this.Department,this.Doctor,this.Time,this.Data}):super(key:key);
  //SecondPage1({Key key,this.Data}):super(key:key);
  @override
  _SecondPageState createState() => _SecondPageState();
}
class _SecondPageState extends State<SecondPage> {
  //final String Data;
  //_SecondPageState({Key key,@required this.Data});

  //final Department;
  //final Doctor;
  //final Time;
  TextEditingController taskNameInputController;
  TextEditingController taskMobInputController;
  TextEditingController taskAgeInputController;
  TextEditingController taskSexInputController;
  TextEditingController taskDayInputController;
  @override
  initState() {
    taskNameInputController = new TextEditingController();
    taskMobInputController = new TextEditingController();
    taskAgeInputController = new TextEditingController();
    taskSexInputController = new TextEditingController();
    taskDayInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text(widget.Department),
        ),
        body: Center(

          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Text(widget.Doctor,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20)),

                Text(widget.Time,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20)),
                Text(widget.Days,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20)),
                RaisedButton(
                    child: Text('Create New Appointment'),
                    color: Theme
                        .of(context)
                        .primaryColor,
                    textColor: Colors.white,
                    onPressed: _showDialog)


                //=> Navigator.of(context).pop('/details')),

              ]

          ),

        )

    );
  }


  _showDialog() async {
    await showDialog<String>(

      context: context,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Column(
          children: <Widget>[
            Text("Please fill all fields to create a new appointment"),
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Name'),
                controller: taskNameInputController,
              ),
            ),
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Mobile No.'),
                controller: taskMobInputController,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: 'Age'),
                controller: taskAgeInputController,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: 'Sex'),
                controller: taskSexInputController,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: 'Select Day'),
                controller: taskDayInputController,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                taskNameInputController.clear();
                taskMobInputController.clear();
                taskAgeInputController.clear();
                taskSexInputController.clear();
                taskDayInputController.clear();
                Navigator.pop(context);
              }),
          FlatButton(
              child: Text('Create'),
              onPressed: () {
                if (taskNameInputController.text.isNotEmpty &&
                    taskMobInputController.text.isNotEmpty &&
                    taskAgeInputController.text.isNotEmpty &&
                    taskSexInputController.text.isNotEmpty &&
                    taskDayInputController.text.isNotEmpty) {



                  Firestore.instance
                      .collection('users').document(widget.Data).collection('Appointments').add({
                    "Name": taskNameInputController.text,
                    "Mobile No.": taskMobInputController.text,
                    "Age": taskAgeInputController.text,
                    "Sex": taskSexInputController.text,
                    "Day": taskDayInputController.text
                  })
                      .then((result) =>

                  {
                    Navigator.pop(context),
                    taskNameInputController.clear(),
                    taskMobInputController.clear(),
                    taskAgeInputController.clear(),
                    taskSexInputController.clear(),
                    taskDayInputController.clear(),
                    print('Appointment Added Successfully'),
                    print(widget.Data),
                  })
                      .catchError((err) => print(err));
                }
              })
        ],
      ),
    );
  }


}

/*class CustomCard extends StatelessWidget {
  CustomCard({@required this.Department, this.Doctor, this.Time});

  final Department;
  final Doctor;
  final Time;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              children: <Widget>[
                Text(Department),
                Text(Doctor),
                Text(Time),
              ],
            )));
  }
}*/