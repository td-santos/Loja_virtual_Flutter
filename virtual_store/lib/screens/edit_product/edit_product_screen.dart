import 'package:flutter/material.dart';
import 'package:virtual_store/models/product.dart';

import 'components/images_form.dart';
import 'components/sizes_form.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final bool editing;
  EditProductScreen(Product p) : 
    editing = p != null,
    product = p != null ? p.clone() :Product();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(editing ?'Editar Produto': 'Criar Produto'),
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
                    SizesForm(product: product,),
                    SizedBox(height: 20,),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            print('valido');
                          } else {
                            print('invalido');
                          }
                        },
                        color: primaryColor,
                        disabledColor: primaryColor.withAlpha(100),
                        textColor: Colors.white,
                        child: Text('Salvar',style: TextStyle(
                          fontSize: 18,
                        ),),
                      ),
                    ),
                    SizedBox(height: 44,)
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
