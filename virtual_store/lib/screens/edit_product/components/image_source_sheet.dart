import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {

  final ImagePicker piker = ImagePicker();
  final Function(File) onImageSelected;

  ImageSourceSheet({this.onImageSelected});


  

  @override
  Widget build(BuildContext context) {

    void editImage(String path)async{
    final File coppedFile = await ImageCropper.cropImage(
      sourcePath: path,
      aspectRatio: CropAspectRatio(ratioX: 1.0,ratioY: 1.0),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Editar Imagem',
        toolbarColor: Theme.of(context).primaryColor,
        toolbarWidgetColor: Colors.white
      ),
      iosUiSettings: IOSUiSettings(
        title: 'Editar Imagem',
        cancelButtonTitle: 'Cancelar',
        doneButtonTitle: 'Concluir'
      )
    );
    if(coppedFile != null){
        onImageSelected(coppedFile);
    }
  } 

    if(Platform.isAndroid)
      return BottomSheet(
        onClosing: (){},      
        builder: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton(
              onPressed: () async{
                final PickedFile file = await piker.getImage(source: ImageSource.camera);
                editImage(file.path);
                //onImageSelected(File(file.path));
              },
              child: Text('Camera'),
            ),
            FlatButton(
              onPressed: () async{
                final PickedFile file = await piker.getImage(source: ImageSource.gallery);
                editImage(file.path);
                //onImageSelected(File(file.path));
              },
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
            onPressed: ()async{
              final PickedFile file = await piker.getImage(source: ImageSource.camera);
              editImage(file.path);
                //onImageSelected(File(file.path));
            }, 
            child: Text('Camera')
          ),
          CupertinoActionSheetAction(
            onPressed: ()async{
              final PickedFile file = await piker.getImage(source: ImageSource.gallery);
              editImage(file.path);
                //onImageSelected(File(file.path));
            }, 
            child: Text('Galeria')
          )
        ],
      );
  }
}
