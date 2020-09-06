
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/models/item_size.dart';
import 'package:virtual_store/models/product.dart';

class CartProduct extends ChangeNotifier{

  String id;

  Product product;
  String productId;
  int quantity;
  String size;
  final Firestore firestore = Firestore.instance;

  CartProduct.fromProduct(this.product){
    productId = product.id;
    quantity = 1;
    size = product.selectedSize.name;
  }

  CartProduct.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    productId = document.data['pid'] as String;
    quantity = document.data['quantity'] as int;
    size = document.data['size'] as String;

    firestore.document('products/$productId').get().then((doc) {
      product = Product.fromDocument(doc);
      notifyListeners();
    });
  }

  Map<String, dynamic> toCartItemMap(){
    return {
      'pid' : productId,
      'quantity' : quantity,
      'size' : size
    };
  }

  bool stackable(Product product){
    return product.id == productId && product.selectedSize.name == size;
  }

  

  void increment(){
    quantity++;
    notifyListeners();
  }

  void decrement(){
    quantity--;
    notifyListeners();
  }

  bool get hasStock{
    final size = itemSize;
    if(size == null){ 
      return false;
    }else{
      return size.stock >= quantity;
    }
  }

  ItemSize get itemSize{

    if(product == null){
      return null;
      
    }else{
      return product.findSize(size);
      
    }    
  }

  num get totalPrice{
    return unitPrice * quantity;
  }

  num get unitPrice{
    if(product == null){
      return 0;
    }else{
      return itemSize?.price ?? 0;
    }
  }
}