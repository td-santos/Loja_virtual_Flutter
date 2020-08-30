import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/models/product.dart';

class ProductManager extends ChangeNotifier{

  Firestore firestore = Firestore.instance;

  ProductManager(){
    _loadAllProducts();
  }

  List<Product> allProducts = [];

  String _search='';

  String get search => _search;
  set search(String value){
    _search = value;
    notifyListeners();
  }

  List<Product> get filteredProducts{
    final List<Product> filteredProducts =[];

    if(search.isEmpty){
      filteredProducts.addAll(allProducts);
    }else{
      filteredProducts.addAll(allProducts.where((p) => p.name.toLowerCase().contains(search)));
    }

    return filteredProducts;
  }

  Future<void>_loadAllProducts()async{
   final QuerySnapshot snapProducts = await firestore.collection('products').getDocuments();
   //for(DocumentSnapshot doc in snapProducts.documents){
   //  print(doc.data);
   //}

   allProducts = snapProducts.documents.map((d) => Product.fromDocument(d)).toList();
   notifyListeners();
  }
}