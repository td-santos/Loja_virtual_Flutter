import 'package:flutter/material.dart';
import 'package:virtual_store/models/cart_product.dart';

class OrderProductTile extends StatelessWidget {
  final CartProduct cartProduct;

  const OrderProductTile({Key key, this.cartProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed('/product', arguments: cartProduct.product);
      },
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 60,
              width: 60,
              child: Image.network(cartProduct.product.images.first),
            ),
            SizedBox(width: 8,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cartProduct.product.name,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Tamanho: ${cartProduct.size}',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'R\$ ${(cartProduct.fixedPrice ?? cartProduct.unitPrice).toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Text(
              '${cartProduct.quantity}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
