import 'package:flutter/material.dart';

class LoginCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(left: 20,right: 20),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.account_circle,color: Theme.of(context).primaryColor, size: 100,),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('Faça login para acessar', 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w900,
                ),),
              ),              
              SizedBox(
                height: 44,
                child: RaisedButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed('/login');
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text('LOGIN'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}