import 'package:flutter/material.dart';
import 'package:virtual_store/models/cart_manager.dart';

class CheckoutManager extends ChangeNotifier{

  CartManager cartManager;



  void updateCart(CartManager cartManager){
    this.cartManager = cartManager;

    print('CartManager Check ${cartManager.productsPrice}');
  }

  void checkout(){
    _decrementStock();
  }

  void _decrementStock(){
    //
  }
  
}