import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/models/product.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Carousel(
              dotSize: 6,
              autoplay: false,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(product.name, style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text('A partir de', style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600]
                  ),),
                ),
                Text('R\$ 19,99', style: TextStyle(
                  fontSize: 22,
                  color: primaryColor,
                  fontWeight: FontWeight.bold
                ),),
                Padding(
                  padding: EdgeInsets.only(top: 16,bottom: 8),
                  child: Text('Descrição',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),),
                ),
                Text(product.description,style: TextStyle(
                  fontSize: 16
                ),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
