import 'package:flutter/material.dart';

import 'cep_input_field.dart';

class AddressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Endereço de Entrega',            
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700
            ),),
            CepInputField(),
          ],
        ),
      ),
    );
  }
}