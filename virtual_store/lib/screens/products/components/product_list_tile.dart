import 'package:flutter/material.dart';
import 'package:virtual_store/models/product.dart';

class ProductListTile extends StatelessWidget {
  final Product product;

  const ProductListTile({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/product',arguments: product);
      },
      child: Card(
        //margin: EdgeInsets.symmetric(horizontal: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 100,
          padding: EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(product.images.first),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      'A partir de',
                      style: TextStyle(color: Colors.grey[300], fontSize: 12),
                    ),
                  ),
                  Text(
                    'R\$ 19,99',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).primaryColor),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
