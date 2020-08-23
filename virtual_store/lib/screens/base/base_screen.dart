import 'package:flutter/material.dart';
import 'package:virtual_store/common/custom_drawer/custom_drawer.dart';

class BaseScreen extends StatelessWidget {

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          drawer: CustomDrawer(),
        ),
        Container(color: Colors.red,),
        Container(color: Colors.green,),
        Container(color: Colors.yellow,),
      ],
    );
  }
}