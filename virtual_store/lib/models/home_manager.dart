import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/models/section.dart';
import 'package:provider/provider.dart';

class HomeManager extends ChangeNotifier{

  Firestore firestore = Firestore.instance;
  List<Section> sections = [];

  HomeManager() {
    _loadSections();
  }

  Future<void> _loadSections() async {
    firestore.collection('home').snapshots().listen((snapshot) {
      sections.clear();
      for (final DocumentSnapshot document in snapshot.documents) {
        sections.add(Section.fromDocument(document));
      }
      notifyListeners();
    });
  }
}
