import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/common/custom_drawer/custom_drawer.dart';
import 'package:virtual_store/models/admin_users_manager.dart';

class AdminUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuários'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Consumer<AdminUsersManager>(
        builder: (_, adminUsersManager, __) {
          return AlphabetListScrollView(
            indexedHeight: (index)=> 80,
            strList: adminUsersManager.names,
            showPreview: true,
            highlightTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(adminUsersManager.users[index].name, style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800
                ),),
                subtitle: Text(adminUsersManager.users[index].email, style: TextStyle(
                  color: Colors.white.withAlpha(120)
                ),),
              );
            },
          );
        },
      ),
    );
  }
}
