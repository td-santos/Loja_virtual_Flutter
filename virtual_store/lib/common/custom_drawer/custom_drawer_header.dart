import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/models/user_manager.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Loja do \nThiago',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              Text('Olá ${userManager.user?.name ?? ''}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              GestureDetector(
                onTap: (){
                  if(userManager.isLoggedIn){
                    userManager.signOut();
                  }else{
                    Navigator.of(context).pushNamed('/login');
                  }
                },
                child: Text(userManager.isLoggedIn ? 'Sair' : 'Entre ou Cadastre-se ->',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
              )
            ],
          );
        },
      ),
    );
  }
}