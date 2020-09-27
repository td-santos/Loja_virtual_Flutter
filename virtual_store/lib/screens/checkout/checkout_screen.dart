import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/common/price_card.dart';
import 'package:virtual_store/models/cart_manager.dart';
import 'package:virtual_store/models/checkout_manager.dart';

class CheckoutScreen extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_,cartmanager,checkoutManager)=> checkoutManager..updateCart(cartmanager),
      lazy: false,
            child: Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text('Pagamento'),
                centerTitle: true,
              ),
              body: Consumer<CheckoutManager>(
                builder: (_,checkoutManager,__){
                  return ListView(
                children: <Widget>[
                  PriceCard(
                    buttonText: 'Finalizar Pedido',
                    onPressed: () {
                      checkoutManager.checkout(
                        onStockFail: (e){
                          
                          Navigator.of(context).popUntil((route) => route.settings.name == '/cart');
                        }
                      );
                    },
                  )
                ],
              );
                },
              ),
            ),
          );
        }
      }
      

