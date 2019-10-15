import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(builder: (contex, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(hintText: "Nome Completo"),
                    validator: (text) {
                      if (text == null || text.isEmpty) return "Nome inválido!";
                    },
                  ),
                  Divider(
                    height: 16,
                    color: Colors.transparent,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.isEmpty || !text.contains("@"))
                        return "E-mail inválido!";
                    },
                  ),
                  Divider(
                    height: 16,
                    color: Colors.transparent,
                  ),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(hintText: "Senha"),
                    obscureText: true,
                    validator: (text) {
                      if (text == null || text.isEmpty)
                        return "Senha invalida!";
                      if (text.length < 6)
                        return "Senha menos que 6 caracteres!";
                    },
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 16,
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(hintText: "Endereço"),
                    validator: (text) {
                      if (text == null || text.isEmpty)
                        return "Endereço invalida!";
                    },
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 16,
                  ),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          model.signUp(
                              userData: {
                                "name": _nameController.text,
                                "email": _emailController.text,
                                "address": _addressController.text
                              },
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
                          return;
                        }
                      },
                      child: Text(
                        "Criar Conta",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }

  void _onSuccess() {}

  void _onFail() {}
}
