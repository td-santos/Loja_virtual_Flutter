

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageSourceSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    if(Platform.isAndroid)
      return BottomSheet(
        onClosing: (){},      
        builder: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton(
              onPressed: () {},
              child: Text('Camera'),
            ),
            FlatButton(
              onPressed: () {},
              child: Text('Galeria'),
            ),
          ],
        ),
      );
    else
      return CupertinoActionSheet(
        title: Text('Selecionar foto para o item'),
        message: Text('Escolha a origem da foto'),
        cancelButton: CupertinoActionSheetAction(
          onPressed: Navigator.of(context).pop, 
          child: Text('Cancelar')),
        actions: <Widget>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: (){

            }, 
            child: Text('Camera')
          ),
          CupertinoActionSheetAction(
            onPressed: (){
              
            }, 
            child: Text('Galeria')
          )
        ],
      );
  }
}
