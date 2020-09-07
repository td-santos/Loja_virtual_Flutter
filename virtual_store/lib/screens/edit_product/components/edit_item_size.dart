import 'package:flutter/material.dart';
import 'package:virtual_store/common/custom_icon_buttom.dart';
import 'package:virtual_store/models/item_size.dart';

class EditItemSize extends StatelessWidget {
  final ItemSize size;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;


  const EditItemSize({Key key, this.size, this.onRemove, this.onMoveUp, this.onMoveDown}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.name,
            decoration: InputDecoration(
              labelText: 'Título',
              isDense: true
            ),
          ),
        ),
        SizedBox(width: 4,),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.stock?.toString(),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Estoque',
              isDense: true
            ),
          ),
        ),
        SizedBox(width: 4,),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size.price?.toStringAsFixed(2),
            keyboardType: TextInputType.numberWithOptions(
              decimal: true
            ),
            decoration: InputDecoration(
              labelText: 'Preço',
              isDense: true,
              prefixText: 'R\$ '
            ),
          ),
        ),
        CustomIconButtom(
          iconData: Icons.remove,
          color: Colors.red,
          ontap: onRemove,
        ),
        CustomIconButtom(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          ontap: onMoveUp,
        ),
        CustomIconButtom(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          ontap: onMoveDown,
        )
      ],
    );
  }
}
