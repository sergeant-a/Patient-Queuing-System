import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'login-register.dart';
import 'details.dart';
import 'SecondPage.dart';
void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

final FirebaseAuth auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'GoPD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          hintColor: Color(0xFFC0F0E8),
          primaryColor: Color(0xFF80E1D1),
          fontFamily: "Montserrat",
          canvasColor: Colors.transparent),
      home: new StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Home();
          }
          return LoginRegister();
        },
      ),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new Home(),
        '/login': (BuildContext context) => new LoginRegister(),
        '/details':(BuildContext context) => new Details(),
        '/SecondPage':(BuildContext context) => new SecondPage(),
      },
    );
  }
}












/*import 'package:flutter/material.dart';
 import 'package:firebase_database/firebase_database.dart';


void main() => runApp(new MaterialApp(
  home: new FirebaseDemoScreen(),

)); //Material App

class FirebaseDemoScreen extends StatelessWidget {

  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Connect'),
      ),
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              RaisedButton(
                child: Text('Create Record'),
                onPressed: () {
                  createRecord();
                },
              ),

              RaisedButton(
                child: Text('View Record'),
                onPressed: () {
                  getData();
                },
              ),
              RaisedButton(
                child: Text('Udate Record'),
                onPressed: () {
                  updateData();
                },
              ),
              RaisedButton(
                child: Text('Delete Record'),
                onPressed: () {
                  deleteData();
                },
              ),
            ],
          )
      ), //center
    );
  }

  void createRecord(){
    databaseReference.child("1").set({
      'title': 'Mastering EJB',
      'description': 'Programming Guide for J2EE'
    });
    databaseReference.child("2").set({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
  }
  void getData(){
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  void updateData(){
    databaseReference.child('1').update({
      'description': 'J2EE complete Reference'
    });
  }

  void deleteData(){
    databaseReference.child('1').remove();
  }
}




import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Appointment.dart';
import 'Services.dart';

void main() => runApp(new MaterialApp(
  home: new DataTableDemo(),

)); //Material App


class DataTableDemo extends StatefulWidget {
  //
  DataTableDemo() : super();

  final String title = 'Flutter Data Table';

  @override
  DataTableDemoState createState() => DataTableDemoState();

}

class DataTableDemoState extends State<DataTableDemo> {
  List<Appointment> _appointments;
  GlobalKey<ScaffoldState> _scaffoldKey;
  // controller for the First Name TextField we are going to create.
  TextEditingController _Token_NoController;
  // controller for the Last Name TextField we are going to create.
  TextEditingController _DepartmentController;
  TextEditingController _Doctor_NameController;
  TextEditingController _DateController;
  Appointment _selectedAppointment;
  bool _isUpdating;
  String _titleProgress;
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    _appointments = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _Token_NoController = TextEditingController();
    _DepartmentController = TextEditingController();
    _DateController = TextEditingController();
    _Doctor_NameController = TextEditingController();
    _getAppointments();
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
/*
  _createTable() {
    _showProgress('Creating Table...');
    Services.createTable().then((result) {
      if ('success' == result) {
        // Table is created successfully.
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }
    });
  }
*/
  // Now lets add an Appointment
  _addAppointment() {
    if (_Token_NoController.text.isEmpty || _DepartmentController.text.isEmpty || _Doctor_NameController.text.isEmpty || _DateController.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    _showProgress('Adding Appointment...');
    Services.addAppointment(int.parse(_Token_NoController.text), _DepartmentController.text, _Doctor_NameController.text, _DateController.text)
        .then((result) {
      if ('success' == result) {
        _getAppointments(); // Refresh the List after adding each Appointment...
        _clearValues();
      }
    });
  }

  _getAppointments() {
    _showProgress('Loading Appointments...');
    Services.getAppointments().then((appointments)  {
      setState(() {
        _appointments = appointments;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${appointments.length}");
    });
  }

  _updateAppointment(Appointment appointment) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Appointment...');
    Services.updateAppointment(int.parse(_Token_NoController.text), _DepartmentController.text, _Doctor_NameController.text, _DateController.text)
        .then((result) {
      if ('success' == result) {
        _getAppointments(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteAppointment(Appointment appointment) {
    _showProgress('Deleting Appointment...');
    Services.deleteAppointment(appointment.Token_No).then((result) {
      if ('success' == result) {
        _getAppointments(); // Refresh after delete...
      }
    });
  }

  // Method to clear TextField values
  _clearValues() {
    _Token_NoController.text = '';
    _DepartmentController.text = '';
    _Doctor_NameController.text = '';
    _DateController.text = '';
  }

  _showValues(Appointment appointment) {
    _Token_NoController.text = (appointment.Token_No).toString();
    _DepartmentController.text = appointment.Department;
    _Doctor_NameController.text = appointment.Doctor_Name;
    _DateController.text = appointment.Date;
  }

  // Let's create a DataTable and show the appointment list in it.
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('TOKEN_NO'),
            ),
            DataColumn(
              label: Text('DEPARTMENT'),
            ),
            DataColumn(
              label: Text('DOCTOR_NAME'),
            ),
            DataColumn(
              label: Text('DATE'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: _appointments
              .map(
                (appointment) => DataRow(cells: [
              DataCell(
                Text((appointment.Token_No).toString()),
                // Add tap in the row and populate the
                // textfields with the corresponding values to update
                onTap: () {
                  _showValues(appointment);
                  // Set the Selected appointment to Update
                  _selectedAppointment = appointment;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(
                Text(
                  appointment.Department.toUpperCase(),
                ),
                onTap: () {
                  _showValues(appointment);
                  // Set the Selected appointment to Update
                  _selectedAppointment = appointment;
                  // Set flag updating to true to indicate in Update Mode
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(
                Text(
                  appointment.Doctor_Name.toUpperCase(),
                ),
                onTap: () {
                  _showValues(appointment);
                  // Set the Selected appointment to Update
                  _selectedAppointment = appointment;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
                  DataCell(
                    Text(
                      appointment.Date.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(appointment);
                      // Set the Selected appointment to Update
                      _selectedAppointment = appointment;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
              DataCell(IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteAppointment(appointment);
                },
              ))
            ]),
          )
              .toList(),
        ),
      ),
    );
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress), // we show the progress in the title...
        actions: <Widget>[
          //IconButton(
            //icon: Icon(Icons.add),
            //onPressed: () {
              //_createTable();
            //},
          //),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getAppointments();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _Token_NoController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Token_No',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _DepartmentController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Department',
                ),
              ),
            ),
            // Add an update button and a Cancel Button
            // show these buttons only when updating an Appointment
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _Doctor_NameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Doctor_Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _DateController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Date',
                ),
              ),
            ),
            _isUpdating
                ? Row(
              children: <Widget>[
                OutlineButton(
                  child: Text('UPDATE'),
                  onPressed: () {
                    _updateAppointment(_selectedAppointment);
                  },
                ),
                OutlineButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    setState(() {
                      _isUpdating = false;
                    });
                    _clearValues();
                  },
                ),
              ],
            )
                : Container(),
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addAppointment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
*/