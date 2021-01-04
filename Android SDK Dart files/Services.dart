/*
import 'dart:convert';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'Appointment.dart';

class Services {
  static const ROOT = 'http://192.168.1.109:5000/appt/users';

  //static const _GET_ALL_ACTION = 'appts()';


  static Future<List<Appointment>> getAppointments() async {
    try {
      var map = Map<String, dynamic>();
      //map['action'] = ROOT;
      //final response = await http.post(ROOT, body: map);
      final response = await http.get(ROOT);
      print('getAppointments Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Appointment> list = parseResponse(response.body);
        return list;
        //return parseResponse(response.body);
      } else {
        return List<Appointment>();
        //return parseResponse(response.body);
      }
    } catch (e) {
      return List<Appointment>(); // return an empty list on exception/error
      //return parseResponse("gdrgdrg");
    }
  }

  static List<Appointment> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Appointment>((json) => Appointment.fromJson(json))
        .toList();
  }

}
*/
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart'
as http; // add the http plugin in pubspec.yaml file.
import 'Appointment.dart';
import 'package:firebase_database/firebase_database.dart';


class Services {
  //static const ROOT = 'http://localhost/EmployeesDB/employee_actions.php';
  //static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  //static const _GET_ALL_ACTION = 'http://192.168.1.100:5000/appt/users';
  //static const _ADD_EMP_ACTION = 'http://192.168.1.100:5000/appt/add';
  //static const _UPDATE_EMP_ACTION = 'http://192.168.1.100:5000/appt/update';
  //static const _DELETE_EMP_ACTION = 'http://192.168.1.100:5000/appt/delete';
  final databaseReference = FirebaseDatabase.instance.reference();

  // Method to create the table Employees.
  /*
  static Future<String> createTable() async {
    try {
      // add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(ROOT, body: map);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
*/

  void getAppointments(){
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }
  static Future<List<Appointment>> getAppointments() async {
    try {
      databaseReference.once().then((DataSnapshot snapshot) {
        print('Data : ${snapshot.value}');
      });
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.get(_GET_ALL_ACTION);
      print('getAppointments Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Appointment> list = parseResponse(response.body);
        return list;
      } else {
        return List<Appointment>();
      }
    } catch (e) {
      return List<Appointment>(); //return an empty list on exception/error

    }
  }
/*
  static List<Appointment> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Appointment>((json) => Appointment.fromJson(json)).toList();
  }

  // Method to add Appointment to the database...
  static Future<String> addAppointment(int Token_No, String Department, String Doctor_Name, String Date) async {
    try {
      var map = Map<String, dynamic>();
      //map['action'] = _ADD_EMP_ACTION;
      map['Token_No'] = Token_No;
      map['Department'] = Department;
      map['Doctor_Name'] = Doctor_Name;
      map['Date'] = Date;
      Map<String,String> headers = {
        'Content-type' : 'application/json',

      };
      //final response = await http.post(_ADD_EMP_ACTION, headers:{ "Accept": "application/json"}, body:json.encode(map) );
      final response = await http.post(_ADD_EMP_ACTION, headers: headers, body: jsonEncode(map));
      print('addAppointment Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to update an Appointment in Database...
  static Future<String> updateAppointment(int Token_No, String Department, String Doctor_Name, String Date) async {
    try {
      var map = Map<String, dynamic>();
      //map['action'] = _UPDATE_EMP_ACTION;
      //map['emp_id'] = empToken_no;
      map['Token_No'] = Token_No;
      map['Department'] = Department;
      map['Doctor_Name'] = Doctor_Name;
      map['Date'] = Date;
      Map<String,String> headers = {
        'Content-type' : 'application/json',

      };
      final response = await http.post(_UPDATE_EMP_ACTION, headers: headers, body: jsonEncode(map));
      print('updateAppointment Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to Delete an Appointment from Database...
  static Future<String> deleteAppointment(int Token_No) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP_ACTION;
      map['Token_No'] = Token_No;
      Map<String,String> headers = {
        'Content-type' : 'application/json',

      };
      final response = await http.post(_DELETE_EMP_ACTION, headers: headers, body: jsonEncode(map));
      print('deleteAppointment Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }*/
}