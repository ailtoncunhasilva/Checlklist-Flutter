import 'package:auto_checklist/data/client_data.dart';
import 'package:auto_checklist/data/vehicle_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChecklistData {

  String cid;

  ClientData clientData;

  VehicleData vehicleData;

  ChecklistData();

  ChecklistData.fromDocument(DocumentSnapshot document){
    cid = document.documentID;
    clientData = document.data['clientData'];
    vehicleData = document.data['vehicleData'];
  }

  Map<String, dynamic> toMap(){
    return{
      'clientData': clientData,
      'vehicleData': vehicleData, 
    };
  } 

}