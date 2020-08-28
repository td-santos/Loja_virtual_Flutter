import 'package:flutter/material.dart';
import 'package:virtual_store/hepers/validators.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/models/user.dart';
import 'package:virtual_store/models/user_manager.dart';

class LoginScreen extends StatelessWidget {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scafoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      appBar: AppBar(
        title: Text('Entrar'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.of(context).pushReplacementNamed('/signup');
            }, 
            textColor: Colors.white,
            child: Text('Criar Conta',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),))
        ],
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_,userManager,__){
                return ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  enabled: !userManager.loading,
                  controller: controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (email) {
                    if (!emailValid(email)) {
                      return 'Email invalido';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  enabled: !userManager.loading,
                  controller: controllerSenha,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  obscureText: true,
                  validator: (pass) {
                    if (pass.isEmpty || pass.length < 6) {
                      return 'Senha invalida';
                    } else {
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
                      onPressed: () {},
                      child: Text('Esqueci minha senha')),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    disabledColor: Theme.of(context).primaryColor.withAlpha(80),
                    onPressed: userManager.loading? null :() {
                      if(formKey.currentState.validate()){
                        //context.read<UserManager>().signIn(
                          userManager.signIn(
                          user: User(email: controllerEmail.text, senha: controllerSenha.text),
                          onFail: (e){
                            scafoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text('Falha ao entrar: $e'),
                                backgroundColor: Colors.red,
                              )
                            );
                          },
                          onSuccess: (){
                            Navigator.of(context).pop();
                          }
                        );
                      }
                    },                    
                    textColor: Colors.white,
                    child: userManager.loading
                    ? CircularProgressIndicator(
                      strokeWidth: 1,
                      valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                    )
                    : Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            );
              }
              ),
          ),
        ),
      ),
    );
  }
}
