import 'dart:io';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:virtual_store/models/home_manager.dart';
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
            return AlertDialog(
              title: Text('Editar Item'),
              actions: <Widget>[
                FlatButton(
                  onPressed: (){
                    context.read<Section>().removeItem(item);
                    Navigator.of(context).pop();
                  }, 
                  textColor: Colors.red,
                  child: Text('Excluir'))
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
