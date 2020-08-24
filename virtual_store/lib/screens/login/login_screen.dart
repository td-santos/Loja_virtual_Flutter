import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrar'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(16),
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: (email){
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Email',                  
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                obscureText: true,
                validator: (pass){
                  if(pass.isEmpty || pass.length < 6){
                    return 'Senha invalida';
                  }else{
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Senha',                  
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: (){

                  }
                , child: Text('Esqueci minha senha')),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 44,
                  child: RaisedButton(
                  onPressed: (){

                  },
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,                
                  child: Text('Entrar',style: TextStyle(
                    fontSize: 18
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}