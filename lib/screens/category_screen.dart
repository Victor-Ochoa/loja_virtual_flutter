import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/enumerations/category_view_type.dart';
import 'package:loja_virtual/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  const CategoryScreen(this.snapshot, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data["Title"]),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.grid_on)),
                Tab(icon: Icon(Icons.list)),
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance
                .collection("Products")
                .document(snapshot.documentID)
                .collection("Itens")
                .getDocuments(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                );
              else
                return TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    GridView.builder(
                      padding: EdgeInsets.all(4),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          childAspectRatio: 0.65),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return ProductTile(
                            CategoryViewType.grid,
                            ProductData.fromSnapshot(
                                snapshot.data.documents[index]));
                      },
                    ),
                    ListView.builder(
                      padding: EdgeInsets.all(4),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return ProductTile(
                            CategoryViewType.list,
                            ProductData.fromSnapshot(
                                snapshot.data.documents[index]));
                      },
                    ),
                  ],
                );
            },
          )),
    );
  }
}
