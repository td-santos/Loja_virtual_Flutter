import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/models/cart_manager.dart';

class CepInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;
    final cepController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextFormField(
          controller: cepController,
          keyboardType: TextInputType.number,
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly,
          CepInputFormatter()],
          decoration: InputDecoration(
            isDense: true,
            labelText: 'Cep',
            hintText: '12.345.678'
          ),
          validator: (cep){
            if(cep.isEmpty){
              return 'Campo obrigatório';
            }else if(cep.length != 10){
              return 'Cep Inválido';
            }else{
              return null;
            }
          },
          
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: primaryColor,
          disabledColor: primaryColor.withAlpha(100),
          textColor: Colors.white,
          onPressed: (){
            if(Form.of(context).validate()){
              context.read<CartManager>().getAddress(cepController.text);
            }
          },
          child: Text('Buscar Cep')
        )
      ],
    );
  }
}