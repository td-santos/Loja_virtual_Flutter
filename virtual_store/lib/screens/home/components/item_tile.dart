import 'dart:io';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:virtual_store/models/home_manager.dart';
import 'package:virtual_store/models/product.dart';
import 'package:virtual_store/models/product_manager.dart';
import 'package:virtual_store/models/section.dart';
import 'package:virtual_store/models/section_item.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {
  final SectionItem item;

  const ItemTile({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final homeManager = context.watch<HomeManager>();

    return GestureDetector(
      onTap: (){
        if(item.product != null){
          final product = context.read<ProductManager>().findProductById(item.product);
          if(product != null){
            Navigator.of(context).pushNamed('/product',arguments: product);
          }
        }
      },
      onLongPress:homeManager.editing ? (){
        showDialog(
          context: context,
          builder: (_){

            final product = context.read<ProductManager>().findProductById(item.product);

            return AlertDialog(
              title: Text('Editar Item'),
              content: product != null
              ? ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Image.network(product.images.first),
                title: Text(product.name),
                subtitle: Text('R\$ ${product.basePrice.toStringAsFixed(2)}'),
              )
              : null,
              actions: <Widget>[
                FlatButton(
                  onPressed: (){
                    context.read<Section>().removeItem(item);
                    Navigator.of(context).pop();
                  }, 
                  textColor: Colors.red,
                  child: Text('Excluir')),
                FlatButton(
                  onPressed: ()async{
                    if(product != null){
                      item.product = null;
                    }else{
                      final Product product = await Navigator.of(context).pushNamed('/select_product') as Product;
                      item.product = product?.id;
                    }
                    Navigator.of(context).pop();
                  }, 
                  child: Text(product != null ? 'Desvincular' : 'Vincular'))
              ],
            );
          }
        );
      }: null,
      child: AspectRatio(
        aspectRatio: 1,
        child: item.image is String
        ? ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:FadeInImage.memoryNetwork(
            placeholder: kTransparentImage, 
            image: item.image as String,
            fit: BoxFit.cover,
          ),
        )
        : Image.file(item.image as File, fit: BoxFit.cover,)
      ),
    );
  }
}
