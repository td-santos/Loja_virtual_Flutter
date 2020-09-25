import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtual_store/models/address.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/models/cart_manager.dart';

class AddressInputField extends StatelessWidget {
  final Address address;

  const AddressInputField({Key key, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    final cartManager = context.watch<CartManager>();

    emptyValidator(String text) {
      return text.isEmpty ? 'Campo Obrigatório' : null;
    }

    if (address.zipCode != null && cartManager.deliveryPrice == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            enabled: !cartManager.loading,
            initialValue: address.street,
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Rua/Avenida',
              hintText: 'Av. Brasil',
            ),
            validator: emptyValidator,
            onSaved: (t) => address.street = t,
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: TextFormField(
                    enabled: !cartManager.loading,
                initialValue: address.number,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Número',
                  hintText: '123',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                validator: emptyValidator,
                onSaved: (t) => address.number = t,
              )),
              SizedBox(width: 16),
              Expanded(
                  child: TextFormField(
                    enabled: !cartManager.loading,
                initialValue: address.complement,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Complemento',
                  hintText: 'Opcional',
                ),
                onSaved: (t) => address.complement = t,
              )),
            ],
          ),
          TextFormField(
            enabled: !cartManager.loading,
            initialValue: address.district,
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Bairro',
              hintText: '...',
            ),
            validator: emptyValidator,
            onSaved: (t) => address.district = t,
          ),
          Row(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: TextFormField(
                    enabled: false,
                    initialValue: address.city,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: 'Cidade',
                      hintText: '...',
                    ),
                    validator: emptyValidator,
                    onSaved: (t) => address.city = t,
                  )),
              SizedBox(width: 16),
              Expanded(
                  child: TextFormField(
                enabled: false,
                autocorrect: false,
                textCapitalization: TextCapitalization.characters,
                initialValue: address.state,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'UF',
                  hintText: '...',
                  counterText: '',
                ),
                maxLength: 2,
                validator: (e) {
                  if (e.isEmpty) {
                    return 'Campo obrigatório';
                  } else if (e.length != 2) {
                    return 'Inválido';
                  } else {
                    return null;
                  }
                },
                onSaved: (t) => address.state = t,
              )),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          if(cartManager.loading)
            LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(primaryColor),
              backgroundColor: Colors.transparent,
            ),
          RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: primaryColor,
            disabledColor: primaryColor.withAlpha(100),
            textColor: Colors.white,
            onPressed: !cartManager.loading ? () async {
              if (Form.of(context).validate()) {
                Form.of(context).save();
                try {
                  await context.read<CartManager>().setAddress(address);
                } catch (e) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('$e'),
                    backgroundColor: Colors.red,
                  ));
                }
              }
            }: null,
            child: Text('Calcular Frete'),
          )
        ],
      );
    } else if(address.zipCode != null){
      //if(address.zipCode!= null && cartManager.deliveryPrice != null)
      return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Text('${address.street}, ${address.number}\n${address.district}\n${address.city} - ${address.state}'),
      );
    }else{
      return Container();
    }
  }
}
