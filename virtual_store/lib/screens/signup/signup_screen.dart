import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(16),
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: 'Nome Completo'),
              ),
              SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: 'E-mail'),
              ),
              SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(hintText: 'Senha'),
              ),
              SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(hintText: 'Repita a Senha'),
              ),
              SizedBox(height: 16),
              SizedBox(height: 44,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  disabledColor: Theme.of(context).primaryColor.withAlpha(80),
                  textColor: Colors.white,
                  child: Text('Criar Conta',style: TextStyle(fontSize: 18),),
                  onPressed: (){

                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}