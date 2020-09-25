import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  final String title;
  final IconData iconData;

  const EmptyCard({Key key, this.title, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            iconData,
            size: 80,
            color: Colors.white,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
          )
        ],
      ),
    );
  }
}
