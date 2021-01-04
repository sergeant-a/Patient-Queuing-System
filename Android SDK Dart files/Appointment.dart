class Appointment {
  int Token_No;
  String Department;
  String Doctor_Name;
  String Date;

  Appointment({this.Token_No, this.Department, this.Doctor_Name, this.Date});

  factory Appointment.fromJson(Map<String, dynamic> json){
    return Appointment(
      Token_No: json['Token_No'] as int,
      Department: json['Department'] as String,
      Doctor_Name: json['Doctor_Name'] as String,
      Date: json['Date'] as String,
    );
  }
}