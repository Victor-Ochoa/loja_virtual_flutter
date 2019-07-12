import 'package:carousel_pro/carousel_pro.dart';
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

  String size = "";

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              dotVerticalPadding: 4,
              dotSize: 4,
              dotSpacing: 15,
              dotColor: primaryColor,
              dotIncreasedColor: primaryColor,
              autoplay: false,
              dotBgColor: Colors.transparent,
              images: product.images.map((url) => Image.network(url)).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                Divider(
                  color: Colors.transparent,
                  height: 16,
                ),
                Text(
                  "Tamanho:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 34,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.5),
                    children: product.sizes
                        .map((size) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  this.size = size;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  border: Border.all(
                                      color: this.size == size
                                          ? primaryColor
                                          : Colors.grey[500],
                                      width: 3),
                                ),
                                width: 50,
                                alignment: Alignment.center,
                                child: Text(size),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Divider(
                  height: 16,
                  color: Colors.transparent,
                ),
                SizedBox(
                    height: 44,
                    child: RaisedButton(
                      onPressed: this.size.isEmpty ? null : () {},
                      child: Text(
                        "Adicionar ao Carrinho",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      color: primaryColor,
                    )),
                Divider(
                  color: Colors.transparent,
                  height: 16,
                ),
                Text(
                  "Descrição",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
