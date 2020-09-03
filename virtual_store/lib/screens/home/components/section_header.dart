import 'package:flutter/material.dart';
import 'package:virtual_store/models/section.dart';

class SectionHeader extends StatelessWidget {

  final Section section;

  const SectionHeader({Key key, this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(section.name,style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),),
    );
  }
}