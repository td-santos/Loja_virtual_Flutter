import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_store/models/address.dart';

class User{

  String id;
  String name;  
  String email;
  String senha;
  String confirmSenha;
  bool admin;
  Address address;

  User({this.id, this.name, this.email,this.senha, this.confirmSenha});

  User.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
    if(document.data.containsKey('address')){
      address = Address.fromMap(document.data['address'] as Map<String,dynamic>);
    }
  }

  DocumentReference get firetoreRef => Firestore.instance.document('users/$id');
  CollectionReference get cartRef => firetoreRef.collection('cart');

  Future<void> saveData()async{
    //await Firestore.instance.collection('users').document(id).setData(toMap());
    await firetoreRef.setData(toMap());
  }

  Map<String,dynamic> toMap(){
    return {
      'name': name,
      'email': email,
      if(address != null)
        'address': address.toMap(),
      
    };
  }

  void setAddress(Address address){
    this.address = address;
    saveData();
  }
}