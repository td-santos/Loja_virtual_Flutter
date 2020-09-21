import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CepInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            isDense: true,
            labelText: 'Cep',
            hintText: '12/345.678'
          ),
        ),
        RaisedButton(
          color: primaryColor,
          disabledColor: primaryColor.withAlpha(100),
          textColor: Colors.white,
          onPressed: (){

          },
          child: Text('Buscar Cep')
        )
      ],
    );
  }
}