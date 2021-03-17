import 'package:cloud_firestore/cloud_firestore.dart';

class Checklist{

  String _id;
  String _tipClient;
  String _name;
  String _cpf;
  String _phone;
  String _email;
  String _address;
  String _paymentForm;
  String _dateIn;
  String _dateOut;
  String _release;
  String _fuelLevel;
  String _typeService;
  String _typeMaintenance;
  String _typeVehicle;
  String _km;
  String _frota;
  String _color;
  String _renavam;
  String _marca;
  String _yearModel;
  String _placa;
  String _chassis;
  String _combustivle;
  String _registerList;
  List<String> _photos;
  String _observation;

  Checklist();

  Checklist.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.id = documentSnapshot.documentID;
    this.tipClient = documentSnapshot['tipclient'];
    this.name = documentSnapshot['name'];
    this.cpf = documentSnapshot['cpf'];
    this.phone = documentSnapshot['phone'];
    this.email = documentSnapshot['email'];
    this.address = documentSnapshot['address'];
    this.paymentForm = documentSnapshot['paymentForm'];
    this.dateIn = documentSnapshot['dateIn'];
    this.dateOut = documentSnapshot['dateOut'];
    this.release = documentSnapshot['release'];
    this.fuelLevel = documentSnapshot['fuelLevel'];
    this.typeService = documentSnapshot['typeService'];
    this.typeMaintenance = documentSnapshot['typeMaintenance'];
    this.typeVehicle = documentSnapshot['typeVehicle'];
    this.km = documentSnapshot['km'];
    this.frota = documentSnapshot['frota'];
    this.color = documentSnapshot['color'];
    this.renavam = documentSnapshot['renavam'];
    this.marca = documentSnapshot['marca'];
    this.yearModel = documentSnapshot['yearModel'];
    this.placa = documentSnapshot['placa'];
    this.chassis = documentSnapshot['chassis'];
    this.combustivel = documentSnapshot['combustivel'];
    this.registerList = documentSnapshot['registerList'];
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
      'tipClient': this.tipClient,
      'name': this.name,
      'cpf': this.cpf,
      'phone': this.phone,
      'email': this.email,
      'address': this.address,
      'paymentForm': this.paymentForm,
      'dateIn': this.dateIn,
      'dateOut': this.dateOut,
      'release': this.release,
      'fuelLevel': this.fuelLevel,
      'typeService': this.typeService,
      'typeMaintenance': this.typeMaintenance,
      'typeVehicle': this.typeVehicle,
      'km': this.km,
      'frota': this.frota,
      'color': this.color,
      'renavam': this.renavam,
      'marca': this.marca,
      'yearModel': this.yearModel,
      'placa': this.placa,
      'chassis': this.chassis,
      'combustivel': this.combustivel,
      'registerList': this.registerList,
      'photos': this.photos,
      'observation': this.observation, 

    };
    return map;

  }

  List<String> get photos => _photos;

  set photos(List<String> value){
    _photos = value;
  }

  String get tipClient => _tipClient;

  set tipClient(String value){
    _tipClient = value;
  }

  String get paymentForm => _paymentForm;

  set paymentForm(String value){
    _paymentForm = value;
  }

  String get dateIn => _dateIn;

  set dateIn(String value){
    _dateIn = value;
  }

  String get dateOut => _dateOut;

  set dateOut(String value){
    _dateOut = value;
  }

  String get release => _release;

  set release(String value){
    _release = value;
  }

  String get fuelLevel => _fuelLevel;

  set fuelLevel(String value){
    _fuelLevel = value;
  }

  String get typeService => _typeService;

  set typeService(String value){
    _typeService = value;
  }

  String get typeMaintenance => _typeMaintenance;

  set typeMaintenance(String value){
    _typeMaintenance = value;
  }

  String get typeVehicle => _typeVehicle;

  set typeVehicle(String value){
    _typeVehicle = value;
  }

  String get km => _km;

  set km(String value){
    _km = value;
  }

  String get frota => _frota;

  set frota(String value){
    _frota = value;
  }

  String get color => _color;

  set color(String value){
    _color = value;
  }

  String get renavam => _renavam;

  set renavam(String value){
    _renavam = value;
  }

  String get observation => _observation;

  set observation(String value){
    _observation = value;
  }

  String get address => _address;

  set address(String value){
    _address = value;
  }

  String get combustivel => _combustivle;

  set combustivel(String value){
    _combustivle = value;
  }

  String get registerList => _registerList;

  set registerList(String value){
    _registerList = value;
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

