import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/category_screen.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  const CategoryTile(this.snapshot, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Icon(Icons.keyboard_arrow_right),
      title: Text(snapshot.data["Title"]),
      leading: CircleAvatar(
        maxRadius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data["Icon"]),
      ),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CategoryScreen(snapshot)));
      },
    );
  }
}
