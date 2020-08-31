import 'package:flutter/material.dart';
import 'package:virtual_store/models/cart_product.dart';

class CartTile extends StatelessWidget {

  final CartProduct cartProduct;

  const CartTile({Key key, this.cartProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 80,
              width: 80,
              child: Image.network(cartProduct.product.images.first),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  children: <Widget>[
                    Text(cartProduct.product.name, style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600
                    ),),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(cartProduct.size, style: TextStyle(
                        fontWeight: FontWeight.w300
                      ),),
                      ),
                    Text('R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}', style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}