import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleData {
  String marca;
  String modelo;
  String year;
  String color;
  String chassis;
  String motorCode;
  int valvulas;
  int cilindros;
  int cilindradas;
  String insurance;
  String light;

  VehicleData.fromDocument(DocumentSnapshot snapshot) {
    marca = snapshot.data['marca'];
    modelo = snapshot.data['modelo'];
    year = snapshot.data['year'];
    color = snapshot.data['color'];
    chassis = snapshot.data['chassis'];
    motorCode = snapshot.data['motorCode'];
    valvulas = snapshot.data['valvulas'];
    cilindros = snapshot.data['cilindros'];
    cilindradas = snapshot.data['cilindradas'];
    insurance = snapshot.data['insurance'];
    light = snapshot.data['light'];
  }

  Map<String, dynamic> vehicleData() {
    return {
      'marca': marca,
      'modelo': modelo,
      'year': year,
      'color': color,
      'chassis': chassis,
      'motorCode': motorCode,
      'valvulas': valvulas,
      'cilindros': cilindros,
      'cilindradas': cilindradas,
      'insurance': insurance,
      'light': light,
    };
  }
}
