import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'SecondPage.dart';
import 'main.dart';


class Details extends StatefulWidget {
  final String Data;
  Details({Key key, @required this.Data}):super(key:key);
  @override
  _DetailsState createState() => _DetailsState();

}

class _DetailsState extends State<Details> {
  //final databaseReference = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    print(widget.Data);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[],
        elevation: 0.0,
        title: Text("DEPARTMENTS"),
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('details')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return new CustomCard(
                          Days: document['Days'],
                          Department: document['Department'],
                          Doctor: document['Doctor'],
                          Time: document['Time'],
                          Data: widget.Data,

                        );
                      }).toList(),
                    );
                }
              },
            )),
      ),

    );
    ;
  }
}


class CustomCard extends StatelessWidget {

  CustomCard({@required this.Days, this.Department, this.Doctor, this.Time, this.Data});
  final Days;
  final Department;
  final Doctor;
  final Time;
  final Data;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              children: <Widget>[
                FlatButton(
                  child: Text(Department),
                  onPressed:()  {

                        //SecondPage(Department:Department, Doctor: Doctor, Time: Time);
                    print(Data);
                   //Navigator.of(context).pushNamed('/SecondPage');
                    Navigator.push(
                        context,
                       new MaterialPageRoute(
                            builder:
                            (context) =>  new SecondPage(
                                Days:Days,Department:Department,Doctor:Doctor,Time:Time,Data:Data)));

                      }
                )

              ],
            )));
  }
}


