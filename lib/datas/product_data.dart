import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String category;
  String id;
  String title;
  String description;
  double price;
  List images;
  List sizes;

  ProductData.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    category = "";
    title = snapshot.data["Title"];
    description = snapshot.data["Description"];
    price = snapshot.data["Price"] + 0.0;
    images = snapshot.data["Images"];
    sizes = snapshot.data["Sizes"];
  }

  Map<String, dynamic> toResumeMap() =>
      {"title": title, "description": description, "price": price};
}
