import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/models/user.dart';
import 'package:virtual_store/models/user_manager.dart';

class AdminUsersManager extends ChangeNotifier{

  List<User> users =[];
  Firestore firestore = Firestore.instance;
  // caso usar o .snapshot 
  StreamSubscription _subscription;

  void updateUser(UserManager usermanager){
    _subscription?.cancel();
    if(usermanager.adminEnabled){
      _listenToUsers();
    }else{
      users.clear();
      notifyListeners();
    }
  }

  void _listenToUsers(){

    _subscription = firestore.collection('users').snapshots().listen((snapshot) {
      users = snapshot.documents.map((e) => User.fromDocument(e)).toList();
      users.sort((a,b)=> a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      notifyListeners();
    });    
    
  }

  List<String> get names => users.map((e) => e.name).toList();

  @override
  void dispose() {
    // TODO: implement dispose
    _subscription?.cancel();
    super.dispose();
  }

}