
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_store/models/item_size.dart';
import 'package:virtual_store/models/product.dart';

class CartProduct{

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
    productId = document.data['pid'] as String;
    quantity = document.data['quantity'] as int;
    size = document.data['size'] as String;

    firestore.document('products/$productId').get().then((doc) => product = Product.fromDocument(doc));
  }

  ItemSize get itemSize{

    if(product == null){
      return null;
      
    }else{
      return product.findSize(size);
      
    }    
  }

  num get unitPrice{
    if(product == null){
      return 0;
    }else{
      return itemSize?.price ?? 0;
    }
  }
}