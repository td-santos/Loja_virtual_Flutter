

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/common/custom_drawer/custom_drawer.dart';
import 'package:virtual_store/common/empty_card.dart';
import 'package:virtual_store/common/login_card.dart';
import 'package:virtual_store/models/orders_manager.dart';

import 'components/order_tile.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Consumer<OrdersManager>(
        builder: (_, ordersManager, __){

          if(ordersManager.user == null){
            return LoginCard();
          }
          if(ordersManager.orders.isEmpty){
            return EmptyCard(
              title: 'Nenhum pedido encontrado',
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: ordersManager.orders.length,
            itemBuilder: (_,index){
              return OrderTile(order:ordersManager.orders.reversed.toList()[index]);
            },
          );
        }
      ),
    );
  }
}