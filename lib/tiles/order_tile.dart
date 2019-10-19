import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';

class OrderTile extends StatelessWidget {
  final String orderId;
  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection(ORDERS_COLLECTION)
              .document(orderId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Codigo do pedido: ${snapshot.data.documentID}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 4,
                  ),
                  Text(_buildProductsText(snapshot.data)),
                  Divider(color: Colors.transparent, height: 4,),
                  Text(
                    "Status do pedido:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Divider(color: Colors.transparent, height: 4,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    _buildCircle("1", "Preparação", snapshot.data["status"], 1),
                    _buildCircle("2", "Transporte", snapshot.data["status"], 2),
                    _buildCircle("3", "Entrega", snapshot.data["status"], 3)
                  ],)
                ],
              );
          },
        ),
      ),
    );
  }

  String _buildProductsText(DocumentSnapshot snapshot) {
    var text = "Descrição:\n";
    for (LinkedHashMap p in snapshot.data["products"]) {
      text +=
          "${p["quantity"]}x ${p["product"]["title"]} (${p["product"]["price"].toStringAsFixed(2)})\n";
    }
    text += "Desconto: R\$ ${snapshot.data["discount"].toStringAsFixed(2)} \n";
    text +=
        "Custo de entrega: R\$ ${snapshot.data["shipPrice"].toStringAsFixed(2)} \n";
    text += "Total: R\$ ${snapshot.data["totalPrice"].toStringAsFixed(2)}";
    return text;
  }

  Widget _buildCircle(
      String title, String subtitle, int status, int thisStatus) {
    Color backColor;
    Widget child;

    if (status < thisStatus) {
      backColor = Colors.grey[500];
      child = Text(
        title,
        style: TextStyle(color: Colors.white),
      );
    } else if (status == thisStatus) {
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white,);
    }

    return Column(children: <Widget>[
      CircleAvatar(radius: 20, backgroundColor: backColor, child: child,),
      Text(subtitle)
    ],);
  }
}
