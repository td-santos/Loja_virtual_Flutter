import 'package:flutter/material.dart';
import 'package:virtual_store/models/home_manager.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/models/section.dart';

class AddSectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final homeManager = context.watch<HomeManager>();

    return Row(
      children: <Widget>[
        Expanded(
          child: FlatButton(
            textColor: Colors.white,
            onPressed: () {
              homeManager.addSection(Section(type: 'List'));
            },
            child: Text('Adicionar Lista'),
          ),
        ),
        Expanded(
          child: FlatButton(
            textColor: Colors.white,
            onPressed: () {
              homeManager.addSection(Section(type: 'Staggered'));
            },
            child: Text('Adicionar grade'),
          ),
        ),
      ],
    );
  }
}
