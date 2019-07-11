import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;
  const ProductScreen(this.product, {Key key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  
  final ProductData product;
  _ProductScreenState(this.product);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}