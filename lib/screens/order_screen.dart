import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final String orderId;

  OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pedido Realizado"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
              size: 80,
            ),
            Text(
              "Pedido relizado com sucesso!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text("Código do pedido: ${orderId}", style: TextStyle(fontSize: 16),)
          ],
        ),
      ),
    );
  }
}
