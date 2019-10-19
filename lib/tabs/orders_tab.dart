import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()) {
      var uid = UserModel.of(context).firebaseUser.uid;
      return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance
            .collection(USER_COLLECTION)
            .document(uid)
            .collection(ORDERS_COLLECTION)
            .getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else{
            return ListView(children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList());
          }
        },
      );
    } else
      return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.view_list,
              size: 80,
              color: Theme.of(context).primaryColor,
            ),
            Divider(
              height: 16,
              color: Colors.transparent,
            ),
            Text(
              "Faça o login para acompanhar.",
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      );
  }
}
