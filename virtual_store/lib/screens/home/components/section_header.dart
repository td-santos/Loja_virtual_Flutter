import 'package:flutter/material.dart';
import 'package:virtual_store/common/custom_icon_buttom.dart';
import 'package:virtual_store/models/home_manager.dart';
import 'package:virtual_store/models/section.dart';
import 'package:provider/provider.dart';

class SectionHeader extends StatelessWidget {
  final Section section;

  const SectionHeader({Key key, this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    if (homeManager.editing) {
      return Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              initialValue: section.name,
              decoration: InputDecoration(
                  hintText: 'Título', isDense: true, border: InputBorder.none),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
              onChanged: (text) => section.name = text,
            ),
          ),
          CustomIconButtom(
            iconData: Icons.remove,
            color: Colors.white,
            ontap: () {
              homeManager.removeSection(section);
            },
          )
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          section.name ?? '',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }
  }
}
