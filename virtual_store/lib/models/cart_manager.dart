import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/models/product.dart';
import 'package:virtual_store/models/user.dart';
import 'package:virtual_store/models/user_manager.dart';

import 'cart_product.dart';

class CartManager extends ChangeNotifier{

    List<CartProduct> items =[];
    User user;
    num productsPrice = 0.0;

    void addToCart(Product product){

      try{
        final CartProduct e = items.firstWhere((p) => p.stackable(product));
        e.increment();

      }catch(e){

        final cartProduct = CartProduct.fromProduct(product);

        cartProduct.addListener(_onItemUpdated);
        items.add(cartProduct);
        user.cartRef.add(cartProduct.toCartItemMap()).then((doc) => cartProduct.id = doc.documentID);
        _onItemUpdated();
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

      productsPrice = 0.0;
      for(int i =0; i< items.length; i++){
        final cartProduct = items[i];
        if(cartProduct.quantity == 0){
          removeOFCart(cartProduct);
          i--;
          continue;
        }

        productsPrice += cartProduct.totalPrice;
        _updatedCartProduct(cartProduct);
        
      }
      notifyListeners();
      
    }

    

    void _updatedCartProduct(CartProduct cartProduct){
      if(cartProduct.id != null){
        user.cartRef.document(cartProduct.id).updateData(cartProduct.toCartItemMap());
      }
      
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

    bool get isCartValid{
      for(final cartProduct in items){
        if(!cartProduct.hasStock)return false;    
        
      }
      return true;
    }
}