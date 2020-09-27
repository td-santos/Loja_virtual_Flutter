import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_store/models/address.dart';
import 'package:virtual_store/models/cart_manager.dart';
import 'package:virtual_store/models/cart_product.dart';

class Order{

  String orderId;
  String userId;
  List<CartProduct> items;
  num price;
  Address address;
  Timestamp date;

  final Firestore firestore = Firestore.instance;
  
  Order.fromcartManager(CartManager cartManager){
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.id;
    address = cartManager.address;
  }

  Future<void> save()async{
    firestore.collection('orders').document(orderId).setData(
      {
        'items' : items.map((e) => e.toOrderItemMap()).toList(),
        'price' : price,
        'user' : userId,
        'adress' : address.toMap(),
      }
    );
  }
  
}