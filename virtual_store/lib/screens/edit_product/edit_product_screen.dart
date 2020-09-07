import 'package:flutter/material.dart';
import 'package:virtual_store/models/product.dart';

import 'components/images_form.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  EditProductScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Editar Anuncio'),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              ImagesForm(
                product: product,
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      initialValue: product.name,
                      decoration: InputDecoration(
                        hintText: 'Título',
                        border: InputBorder.none,
                      ),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                      validator: (name) {
                        if (name.length < 6) {
                          return 'Título muito curto!';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Text(
                      'A partir de',
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                    Text(
                      'R\$ ...',
                      style: TextStyle(
                          fontSize: 22,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 0),
                      child: Text(
                        'Descrição',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    TextFormField(
                      initialValue: product.description,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Descreva o produto',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 16,                        
                      ),
                      validator: (description){
                        if(description.length < 10){
                          return 'Descrição muito curta!';
                        }else{
                          return null;
                        }
                      },
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          print('valido');
                        } else {
                          print('invalido');
                        }
                      },
                      child: Text('Salvar'),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
