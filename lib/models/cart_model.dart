import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

const CART_COLLECTION = "cart";

class CartModel extends Model {
  UserModel user;
  List<CartProduct> products = [];

  int totalProductQuantity() =>
      products == null ? 0 : products.fold<int>(0, (p, c) => c.quantity + p);

  String couponCode = "";
  int discountPercentage = 0;

  bool isLoading = false;

  CartModel(this.user){
    if(user.isLoggedIn())
      _loadCartItems();
      
  }

  void setCupom(String couponCode, int discountPercentage){
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    if (products.any((p) =>
        p.category == cartProduct.category &&
        p.productId == cartProduct.productId &&
        p.size == cartProduct.size)) {
      incrementCartItem(products
          .where((p) =>
              p.category == cartProduct.category &&
              p.productId == cartProduct.productId &&
              p.size == cartProduct.size)
          .first);
      return;
    }

    Firestore.instance
        .collection(USER_COLLECTION)
        .document(user.firebaseUser.uid)
        .collection(CART_COLLECTION)
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cartId = doc.documentID;
    });

    products.add(cartProduct);

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection(USER_COLLECTION)
        .document(user.firebaseUser.uid)
        .collection(CART_COLLECTION)
        .document(cartProduct.cartId)
        .delete();

    products.remove(cartProduct);

    notifyListeners();
  }

  void decrementCartItem(CartProduct cartProduct) {
    cartProduct.quantity--;

    Firestore.instance
        .collection(USER_COLLECTION)
        .document(user.firebaseUser.uid)
        .collection(CART_COLLECTION)
        .document(cartProduct.cartId)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void incrementCartItem(CartProduct cartProduct) {
    cartProduct.quantity++;

    Firestore.instance
        .collection(USER_COLLECTION)
        .document(user.firebaseUser.uid)
        .collection(CART_COLLECTION)
        .document(cartProduct.cartId)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void _loadCartItems() async {
    QuerySnapshot query = await Firestore.instance
        .collection(USER_COLLECTION)
        .document(user.firebaseUser.uid)
        .collection(CART_COLLECTION)
        .getDocuments();

    products =
        query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }
}
