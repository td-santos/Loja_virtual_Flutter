import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/models/address.dart';
import 'package:virtual_store/models/cart_manager.dart';

import 'address_input_field.dart';
import 'cep_input_field.dart';

class AddressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Consumer<CartManager>(
          builder: (_, cartManager, __) {
            final address = cartManager.address ?? Address();
            print(address);
            return Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Endereço de Entrega',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  CepInputField(address: address,),
                  
                  AddressInputField(address: address,),
                  

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
