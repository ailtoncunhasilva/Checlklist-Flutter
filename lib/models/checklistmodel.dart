import 'package:cloud_firestore/cloud_firestore.dart';

class Checklist{

  String _id;
  String _name;
  String _cpf;
  String _phone;
  String _email;
  String _marca;
  String _yearModel;
  String _placa;
  String _chassis;
  String _combustivle;
  List<String> _photos;
  String _observation;

  Checklist();

  Checklist.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.id = documentSnapshot.documentID;
    this.name = documentSnapshot['name'];
    this.cpf = documentSnapshot['cpf'];
    this.phone = documentSnapshot['phone'];
    this.email = documentSnapshot['email'];
    this.marca = documentSnapshot['marca'];
    this.yearModel = documentSnapshot['yearModel'];
    this.placa = documentSnapshot['placa'];
    this.chassis = documentSnapshot['chassis'];
    this.combustivel = documentSnapshot['combustivel'];
    this.photos = List<String>.from(documentSnapshot['photos']);
    this.observation = documentSnapshot['observation'];

  }

  Checklist.gerarID(){
    Firestore db = Firestore.instance;
    CollectionReference checklists = db.collection('Meus_ckechlists');
    this.id = checklists.document().documentID;
    this.photos = [];
  }

  Map<String,dynamic> toMap(){
    Map<String, dynamic> map ={
      'id': this.id,
      'name': this.name,
      'cpf': this.cpf,
      'phone': this.phone,
      'email': this.email,
      'marca': this.marca,
      'yearModel': this.yearModel,
      'placa': this.placa,
      'chassis': this.chassis,
      'combustivel': this.combustivel,
      'photos': this.photos,
      'observation': this.observation, 

    };
    return map;

  }

  List<String> get photos => _photos;

  set photos(List<String> value){
    _photos = value;
  }

  String get observation => _observation;

  set observation(String value){
    _observation = value;
  }

  String get combustivel => _combustivle;

  set combustivel(String value){
    _combustivle = value;
  }

  String get chassis => _chassis;

  set chassis(String value){
    _chassis = value;
  }

  String get marca => _marca;

  set marca(String value){
    _marca = value;
  }

  String get yearModel => _yearModel;

  set yearModel(String value){
    _yearModel = value;
  }

  String get placa => _placa;

  set placa(String value){
    _placa = value;
  }

  String get email => _email;

  set email(String value){
    _email = value;
  }

  String get phone => _phone;

  set phone(String value){
    _phone = value;
  }

  String get cpf => _cpf;

  set cpf(String value){
    _cpf = value;
  }

  String get name => _name;

  set name(String value){
    _name = value;
  }

  String get id => _id;

  set id(String value){
    _id = value;
  }

}

