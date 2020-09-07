import 'package:flutter/material.dart';
import 'package:virtual_store/common/custom_icon_buttom.dart';
import 'package:virtual_store/models/item_size.dart';
import 'package:virtual_store/models/product.dart';

import 'edit_item_size.dart';

class SizesForm extends StatelessWidget {
  final Product product;

  const SizesForm({Key key, this.product}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
      initialValue: List.from(product.sizes),
      builder: (state) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Tamanhos',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                CustomIconButtom(
                  iconData: Icons.add,
                  color: Colors.black,
                  ontap: () {
                    state.value.add(ItemSize());
                    state.didChange(state.value);
                  },
                )
              ],
            ),
            Column(
              children: state.value.map((size) {
                return EditItemSize(
                  key: ObjectKey(size),
                  size: size,
                  onRemove: (){
                    state.value.remove(size);
                    state.didChange(state.value);
                  },
                  onMoveUp: size != state.value.first ? (){
                    final index = state.value.indexOf(size);
                    state.value.remove(size);
                    state.value.insert(index -1, size);
                    state.didChange(state.value);
                  }: null,
                  onMoveDown: size != state.value.last ? (){
                    final index = state.value.indexOf(size);
                    state.value.remove(size);
                    state.value.insert(index +1, size);
                    state.didChange(state.value);
                  }: null,
                );
              }).toList(),
            )
          ],
        );
      },
    );
  }
}
