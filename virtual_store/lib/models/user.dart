import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String id;
  String name;  
  String email;
  String senha;
  String confirmSenha;

  User({this.id, this.name, this.email,this.senha, this.confirmSenha});

  User.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
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
    };
  }
}