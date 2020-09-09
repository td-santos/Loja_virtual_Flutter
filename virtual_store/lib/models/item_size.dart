class ItemSize{

  String name;
  num price;
  int stock;

  bool get hasStock => stock > 0;

  ItemSize.fromMap(Map<String, dynamic> map){
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;

  }
  ItemSize({this.name,this.price,this.stock});

  ItemSize clone(){
    return ItemSize(
      name: name,
      price: price,
      stock: stock
    );
  }

  String toString(){
    return 'ItemSize{name: $name, price: $price, stock: $stock}';
  }
}