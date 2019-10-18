import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/tiles/cart_tile.dart';
import 'package:loja_virtual/widget/discount_cart.dart';
import 'package:loja_virtual/widget/ship_card.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Meu Carrinho"),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                return Text(
                  "${model.totalProductQuantity() ?? 0} ${model.totalProductQuantity() == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(fontSize: 17),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLoggedIn())
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (!UserModel.of(context).isLoggedIn())
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  Divider(
                    height: 16,
                    color: Colors.transparent,
                  ),
                  Text(
                    "Faça o login para adicionar Produtos!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    height: 16,
                    color: Colors.transparent,
                  ),
                  RaisedButton(
                    child: Text(
                      "Entrar",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            );
          else if (model.totalProductQuantity() == 0)
            return Center(
              child: Text(
                "Nenhum produto adicionado ao carrinho.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          else
            return ListView(
              children: <Widget>[
                Column(
                  children: model.products
                      .map((product) => CartTile(product))
                      .toList(),
                ),
                DiscountCart(),
                ShipCard()
              ],
            );
        },
      ),
    );
  }
}
