import 'package:flutter/material.dart';
import 'package:virtual_store/models/order.dart';
import 'package:virtual_store/screens/orders/components/order_product_tile.dart';

class ConfirmationScreen extends StatelessWidget {
  final Order order;

  const ConfirmationScreen({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido Confirmado'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      order.formattedId,
                      style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'R\$ ${order.price.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
              Column(
                children: order.items.map((e) {
                  return OrderProductTile(
                    cartProduct: e,
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
