import 'package:cloud_firestore/cloud_firestore.dart';

class ClientData {
  String name;
  String cpf;
  String rg;
  String address;
  String neighborhood;
  String city;
  String state;
  String zipCode;
  String phone;
  String email;

  ClientData.fromDocument(DocumentSnapshot snapshot) {
    name = snapshot.data['name'];
    cpf = snapshot.data['cpf'];
    rg = snapshot.data['rg'];
    address = snapshot.data['address'];
    neighborhood = snapshot.data['neighborhood'];
    city = snapshot.data['city'];
    state = snapshot.data['state'];
    zipCode = snapshot.data['zipCode'];
    phone = snapshot.data['phone'];
    email = snapshot.data['email'];
  }

  Map<String, dynamic> clientData() {
    return {
      'name': name,
      'cpf': cpf,
      'rg': rg,
      'address': address,
      'neghborhood': neighborhood,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'phone': phone,
      'email': email,
    };
  }
}
