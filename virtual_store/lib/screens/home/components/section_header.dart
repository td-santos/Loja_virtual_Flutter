import 'package:flutter/material.dart';
import 'package:virtual_store/common/custom_icon_buttom.dart';
import 'package:virtual_store/models/home_manager.dart';
import 'package:virtual_store/models/section.dart';
import 'package:provider/provider.dart';

class SectionHeader extends StatelessWidget {
  //final Section section;

  //const SectionHeader({Key key, this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    final section = context.watch<Section>();

    if (homeManager.editing) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  initialValue: section.name,
                  decoration: InputDecoration(
                      hintText: 'Título',
                      isDense: true,
                      border: InputBorder.none),
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
          ),
          if(section.error != null)
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(section.error, style: TextStyle(
                color: Colors.red
              ),),
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
