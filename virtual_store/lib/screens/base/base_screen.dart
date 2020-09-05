import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/common/custom_drawer/custom_drawer.dart';
import 'package:virtual_store/models/page_manager.dart';
import 'package:virtual_store/models/user_manager.dart';
import 'package:virtual_store/screens/home/home_screen.dart';
import 'package:virtual_store/screens/login/login_screen.dart';
import 'package:virtual_store/screens/products/products_screen.dart';

class BaseScreen extends StatelessWidget {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: <Widget>[
              HomeScreen(),
              ProductsScreen(),
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
              if(userManager.adminEnabled)
                ...[
                  Scaffold(
                appBar: AppBar(
                  title: Text('Usuários'),
                ),
                drawer: CustomDrawer(),
              ),
              Scaffold(
                appBar: AppBar(
                  title: Text('Pedidos'),
                ),
                drawer: CustomDrawer(),
              ),
                ]
            ],
          );
        },
      ),
    );
  }
}
