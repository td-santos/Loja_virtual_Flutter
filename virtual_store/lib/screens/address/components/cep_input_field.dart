import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/common/custom_icon_buttom.dart';
import 'package:virtual_store/models/address.dart';
import 'package:virtual_store/models/cart_manager.dart';

class CepInputField extends StatelessWidget {
  final Address address;
  final cepController = TextEditingController();

  CepInputField({Key key, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    if (address.zipCode == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: cepController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              CepInputFormatter()
            ],
            decoration: InputDecoration(
                isDense: true, labelText: 'Cep', hintText: '12.345.678'),
            validator: (cep) {
              if (cep.isEmpty) {
                return 'Campo obrigatório';
              } else if (cep.length != 10) {
                return 'Cep Inválido';
              } else {
                return null;
              }
            },
          ),
          RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: primaryColor,
              disabledColor: primaryColor.withAlpha(100),
              textColor: Colors.white,
              onPressed: () {
                if (Form.of(context).validate()) {
                  context.read<CartManager>().getAddress(cepController.text);
                }
              },
              child: Text('Buscar Cep'))
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'CEP: ${address.zipCode}',
                style:
                    TextStyle(color: primaryColor, fontWeight: FontWeight.w700),
              ),
            ),
            CustomIconButtom(
              iconData: Icons.edit,
              color: primaryColor,
              size: 20,
              ontap: () {
                context.read<CartManager>().removeAddress();
              },
            )
          ],
        ),
      );
    }
  }
}
