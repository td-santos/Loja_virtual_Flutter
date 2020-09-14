import 'dart:io';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:virtual_store/models/product_manager.dart';
import 'package:virtual_store/models/section_item.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {
  final SectionItem item;

  const ItemTile({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(item.product != null){
          final product = context.read<ProductManager>().findProductById(item.product);
          if(product != null){
            Navigator.of(context).pushNamed('/product',arguments: product);
          }
        }
      },
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
