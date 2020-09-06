import 'package:flutter/material.dart';
import 'package:virtual_store/models/product.dart';

import 'components/images_form.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  EditProductScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              RaisedButton(
                onPressed: (){
                  if(formKey.currentState.validate()){
                    print('valido');
                  }else{
                    print('invalido');
                  }
                },
                child: Text('Salvar'),
              )
            ],
          ),
        ));
  }
}
