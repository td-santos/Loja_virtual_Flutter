import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {

  final String initialText;

  const SearchDialog({Key key, this.initialText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 2,
          left: 10,
          right: 10,
          child: Card(
            child: TextFormField(
              initialValue: initialText,
              textInputAction: TextInputAction.search,
              autofocus: true,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                prefixIcon: IconButton(
                  icon: Icon(Icons.arrow_back_ios), 
                  color: Colors.grey[700],
                  onPressed: (){
                    Navigator.of(context).pop();
                  }
                  ),                  
              ),
              onFieldSubmitted: (text){
                Navigator.of(context).pop(text);
              },
            ),
          )
        )
      ],
    );
  }
}