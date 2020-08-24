import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/common/custom_drawer/custom_drawer.dart';
import 'package:virtual_store/models/page_manager.dart';
import 'package:virtual_store/screens/login/login_screen.dart';

class BaseScreen extends StatelessWidget {

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
          child: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: <Widget>[
          LoginScreen(),
          
          Scaffold(
            appBar: AppBar(
              title: Text('Home2'),
            ),
            drawer: CustomDrawer(),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text('Home3'),
            ),
            drawer: CustomDrawer(),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text('Home4'),
            ),
            drawer: CustomDrawer(),
          ),
        ],
      ),
    );
  }
}