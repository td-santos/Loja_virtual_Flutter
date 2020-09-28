import 'package:flutter/material.dart';
import 'package:virtual_store/models/order.dart';

import 'order_product_tile.dart';

class OrderTile extends StatelessWidget {

  final Order order;

  const OrderTile({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(order.formattedId,style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.green[800]
                )),
                Text('R\$ ${order.price.toStringAsFixed(2)}',style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700
                ),)
              ],
            ),
            Text('Em Transporte',style: TextStyle(
              color: Colors.green[800],
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),)
          ],
        ),
        children: <Widget>[
          Column(
            children: order.items.map((e){
              return OrderProductTile(cartProduct: e,);
            }).toList(),
          )
        ],
      ),
    );
  }
}