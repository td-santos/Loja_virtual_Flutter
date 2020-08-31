import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/common/custom_drawer/custom_drawer.dart';
import 'package:virtual_store/models/product_manager.dart';
import 'package:virtual_store/screens/products/components/product_list_tile.dart';

import 'components/search_dialog.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return Text('Produtos');
            } else {
              return LayoutBuilder(
                builder: (_, constraints) {
                  constraints.biggest.width;
                  return GestureDetector(
                    onTap: () async {
                      final search = await showDialog<String>(
                          context: context, builder: (_) => SearchDialog(initialText: productManager.search,));

                      if (search != null) {
                        productManager.search = search;
                      }
                    },
                    child: Container(
                      width: constraints.biggest.width,                      
                      child: Text(productManager.search,textAlign: TextAlign.center,)
                    ),
                  );
                },
              );
            }
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ProductManager>(builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  final search = await showDialog<String>(
                      context: context, builder: (_) => SearchDialog(initialText: productManager.search,));

                  if (search != null) {
                    productManager.search = search;
                  }
                },
              );
            } else {
              return IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  productManager.search = '';
                },
              );
            }
          })
        ],
      ),
      drawer: CustomDrawer(),
      body: Consumer<ProductManager>(builder: (_, productManager, __) {
        final filteredProducts = productManager.filteredProducts;
        return ListView.builder(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            itemCount: filteredProducts.length,
            itemBuilder: (_, index) {
              return ProductListTile(product: filteredProducts[index]);
            });
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          Navigator.of(context).pushNamed('/cart');
        },
        child: Icon(Icons.shopping_cart),
        ),
    );
  }
}
