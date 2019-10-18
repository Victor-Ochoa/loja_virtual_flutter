import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
  final VoidCallback buy;

  CartPrice(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: EdgeInsets.all(16),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Resumo do pedido",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Divider(
                  color: Colors.transparent,
                  height: 12,
                ),
                _rowBuilder("Subtotal", 
                    "R\$ ${model.getProductsPrice().toStringAsFixed(2)}"),
                _rowBuilder("Desconto",
                    "R\$ ${model.getDiscount().toStringAsFixed(2)}"),
                _rowBuilder("Entrega",
                    "R\$ ${model.getShipPrice().toStringAsFixed(2)}"),
                Divider(
                  color: Colors.transparent,
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "R\$ ${model.getTotalPrice().toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 16),
                    )
                  ],
                ),
                Divider(
                  color: Colors.transparent,
                  height: 12,
                ),
                RaisedButton(
                  onPressed: buy,
                  child: Text("Finalizar Pedido"),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _rowBuilder(String description, String value) => Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                description,
              ),
              Text(value),
            ],
          ),
          Divider()
        ],
      );
}
