import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/models/cart_manager.dart';

class PriceCard extends StatelessWidget {

  final String buttonText;
  final VoidCallback onPressed;

  const PriceCard({Key key, this.buttonText, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;
    final deliveryPrice = cartManager.deliveryPrice;
    final totalPrice = cartManager.totalPrice;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Resumo do Pedido', style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700
            ),),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Subtotal'),
                Text('R\$ ${productsPrice.toStringAsFixed(2)}')
              ],
            ),
            if(deliveryPrice != null)
              ...[
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Entrega'),
                    Text('R\$ ${deliveryPrice.toStringAsFixed(2)}')
                  ],
                ),
              ],
            
            Divider(),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Total',style: TextStyle(
                  fontWeight: FontWeight.w600
                ),),
                Text('R\$ ${totalPrice.toStringAsFixed(2)}',style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),)
              ],
            ),
            SizedBox(height: 8),
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: Theme.of(context).primaryColor,
              disabledColor: Theme.of(context).primaryColor.withAlpha(100),
              textColor: Colors.white,
              onPressed: onPressed,
              child: Text(buttonText),
            )
          ],
        ),
      ),
    );
  }
}