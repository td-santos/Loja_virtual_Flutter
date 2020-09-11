import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/models/product.dart';
import 'package:virtual_store/models/product_manager.dart';

import 'components/images_form.dart';
import 'components/sizes_form.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final bool editing;
  EditProductScreen(Product p)
      : editing = p != null,
        product = p != null ? p.clone() : Product();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(editing ? 'Editar Produto' : 'Criar Produto'),
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                        validator: (name) {
                          if (name.length < 6) {
                            return 'Título muito curto!';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (name) {
                          product.name = name;
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
                        validator: (description) {
                          if (description.length < 10) {
                            return 'Descrição muito curta!';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (description) {
                          product.description = description;
                        },
                      ),
                      SizesForm(
                        product: product,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Consumer<Product>(builder: (_, product, __) {
                        return SizedBox(
                          height: 44,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            onPressed:!product.loading ? () async{
                              if (formKey.currentState.validate()) {
                                print('valido');
                                formKey.currentState.save();
                                await product.save();

                                context.read<ProductManager>().update(product);

                                Navigator.of(context).pop();
                              
                              }
                            } : null,
                            color: primaryColor,
                            disabledColor: primaryColor.withAlpha(100),
                            textColor: Colors.white,
                            child: product.loading == true
                            ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )                            
                            : Text(
                              'Salvar',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 44,
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
