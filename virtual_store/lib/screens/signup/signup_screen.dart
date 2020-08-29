import 'package:flutter/material.dart';
import 'package:virtual_store/hepers/validators.dart';
import 'package:virtual_store/models/user.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/models/user_manager.dart';

class SignUpScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(builder: (_, userManager, __) {
              return ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  TextFormField(
                    enabled: !userManager.loading,
                    decoration: InputDecoration(hintText: 'Nome Completo'),
                    validator: (name) {
                      if (name.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (name.trim().split(' ').length <= 1) {
                        return 'Insira seu nome Completo';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (name) {
                      user.name = name;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    enabled: !userManager.loading,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'E-mail'),
                    validator: (email) {
                      if (email.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (!emailValid(email)) {
                        return 'E-mail inválido';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (email) {
                      user.email = email;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    enabled: !userManager.loading,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Senha'),
                    validator: (senha) {
                      if (senha.isEmpty) {
                        return 'Campo Obrigatório';
                      } else if (senha.length < 6) {
                        return 'Senha muito curta';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (senha) {
                      user.senha = senha;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    enabled: !userManager.loading,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Repita a Senha'),
                    validator: (confirmSenha) {
                      if (confirmSenha.isEmpty) {
                        return 'Campo Obrigatório';
                      } else if (confirmSenha.length < 6) {
                        return 'Senha muito curta';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (confirmSenha) {
                      user.confirmSenha = confirmSenha;
                    },
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        disabledColor: Theme.of(context).primaryColor.withAlpha(80),
                        textColor: Colors.white,
                        child: userManager.loading
                        ? CircularProgressIndicator(
                          strokeWidth: 1,
                          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                        )
                        : Text('Criar Conta',
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: userManager.loading ? null : () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            if (user.senha != user.confirmSenha) {
                              scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: const Text('Senhas não coincidem!'),
                                backgroundColor: Colors.red,
                              ));
                              return;
                            } else {
                              userManager.signUp(
                                    user: user,
                                    onSuccess: () {
                                      //debugPrint('sucesso ao cadastrar');
                                      Navigator.of(context).pop();
                                    },
                                    onFail: (e) {
                                      scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                        content: Text('Falha ao cadastrar: $e'),
                                        backgroundColor: Colors.red,
                                      ));
                                    },
                                  );
                            }
                          }
                        }),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
