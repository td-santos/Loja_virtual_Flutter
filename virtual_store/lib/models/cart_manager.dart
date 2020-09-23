import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:virtual_store/models/address.dart';
import 'package:virtual_store/models/product.dart';
import 'package:virtual_store/models/user.dart';
import 'package:virtual_store/models/user_manager.dart';
import 'package:virtual_store/services/cep_aberto_service.dart';

import 'cart_product.dart';

class CartManager extends ChangeNotifier{

    List<CartProduct> items =[];
    User user;
    Address address;
    num productsPrice = 0.0;
    num deliveryPrice;
    final Firestore firestore = Firestore.instance;

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


    // ADDRESS

    Future<void> getAddress(String cep)async{
      final cepAbertoService = CepAbertoService();

      try{

        final cepAbertoAddress = await cepAbertoService.getAdressFromCep(cep);

        if(cepAbertoAddress != null){
          address = Address(
            street: cepAbertoAddress.logradouro,
            district: cepAbertoAddress.bairro,
            zipCode: cepAbertoAddress.cep,
            city: cepAbertoAddress.cidade.nome,
            state: cepAbertoAddress.estado.sigla,
            lat: cepAbertoAddress.latitude,
            long: cepAbertoAddress.longitude
          );
        }

        notifyListeners();
        //print(cepAbertoAddress);

      }catch (e){
        debugPrint(e.toString());
      }
      
    }

    Future<void> setAddress(Address address)async{
      this.address = address;
      if(await calculateDelivery(address.lat, address.long)){
        //Salvar end firebase
        print('Price: $deliveryPrice');
      }else{
        return Future.error('Emdereço fora do raio de entrega :(');
      }
    }

    void removeAddress(){
      address = null;
      notifyListeners();
    }

    Future<bool> calculateDelivery(double lat, double long)async{
      final DocumentSnapshot doc = await firestore.document('aux/delivery').get();
      final latStore = doc.data['lat'] as double;
      final longStore = doc.data['long'] as double;

      final maxkm = doc.data['maxkm'] as num;// distancia max de entrega
      final base = doc.data['base'] as num;//preco base
      final km = doc.data['km'] as num;//preco porkm

      double dis = await Geolocator().distanceBetween(latStore, longStore, lat, long);
      dis = dis/1000.0;// convert in Km

      print('Distancia: $dis');

      deliveryPrice = base + dis * km;

      if(dis > maxkm){
        return false;
      }else{
        return true;
      }
    }
}