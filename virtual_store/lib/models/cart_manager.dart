import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/models/product.dart';
import 'package:virtual_store/models/user.dart';
import 'package:virtual_store/models/user_manager.dart';

import 'cart_product.dart';

class CartManager extends ChangeNotifier{

    List<CartProduct> items =[];
    User user;

    void addToCart(Product product){

      try{

        final CartProduct e = items.firstWhere((p) => p.stackable(product));
        e.increment();

      }catch(e){

        final cartProduct = CartProduct.fromProduct(product);

        cartProduct.addListener(_onItemUpdated);
        items.add(cartProduct);
        user.cartRef.add(cartProduct.toCartItemMap()).then((doc) => cartProduct.id = doc.documentID);
      }   
      notifyListeners();   
    }

    void removeOFCart(CartProduct cartProduct){
      items.removeWhere((p) => p.id == cartProduct.id);
      user.cartRef.document(cartProduct.id).delete();
      cartProduct.removeListener(_onItemUpdated);
      notifyListeners();
    }

    void _onItemUpdated(){
      for(final cartProduct in items){

        if(cartProduct.quantity == 0){
          removeOFCart(cartProduct);
        }
        _updatedCartProduct(cartProduct);
        
      }
    }

    

    void _updatedCartProduct(CartProduct cartProduct){
      user.cartRef.document(cartProduct.id).updateData(cartProduct.toCartItemMap());
    }

    void updateUser(UserManager userManager){
      user = userManager.user;
      items.clear();

      if(user != null){
        _loadCartItems();
      }
    }

   Future<void> _loadCartItems()async{
     final QuerySnapshot cartSnap = await user.cartRef.getDocuments();

     items = cartSnap.documents.map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated)).toList();
    }
}