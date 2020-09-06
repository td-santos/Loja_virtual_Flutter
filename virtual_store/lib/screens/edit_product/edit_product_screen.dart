import 'package:flutter/material.dart';
import 'package:virtual_store/models/product.dart';

import 'components/images_form.dart';

class EditProductScreen extends StatelessWidget {

  final Product product;

  const EditProductScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Anuncio'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ImagesForm(product: product,),
        ],
      )
      
    );
  }
}