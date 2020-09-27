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

  Order.fromDocument(DocumentSnapshot doc){
    orderId = doc.documentID ;
    userId = doc.data['user'] as String;    
    price = doc.data['price'] as num;
    address =  Address.fromMap(doc.data['address'] as Map<String,dynamic>);    
    date = doc.data['date'] as Timestamp;
    items = (doc.data['items'] as List<dynamic>).map((e){
      return CartProduct.fromMap(e as Map<String,dynamic>);
    }).toList();

  }

  Future<void> save()async{
    firestore.collection('orders').document(orderId).setData(
      {
        'items' : items.map((e) => e.toOrderItemMap()).toList(),
        'price' : price,
        'user' : userId,
        'address' : address.toMap(),
      }
    );
  }

  String get formattedId => '#${orderId.padLeft(6,'0')}';


  String toString(){
    return '\n\n orderId : $orderId,\n userId : $userId,\n price : $price,\n date : $date,\n items : $items,\n address : $address';
  }
  
}