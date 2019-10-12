import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
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
                decoration: InputDecoration(hintText: "Senha"),
                obscureText: true,
                validator: (text) {
                  if (text == null || text.isEmpty) return "Senha invalida!";
                  if (text.length < 6) return "Senha menos que 6 caracteres!";
                },
              ),
              Divider(
                color: Colors.transparent,
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Endereço"),
                validator: (text) {
                  if (text == null || text.isEmpty) return "Endereço invalida!";
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
                    if (!_formKey.currentState.validate()) return;
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
      ),
    );
  }
}
