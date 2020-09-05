import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:virtual_store/models/section.dart';
import 'package:virtual_store/screens/home/components/section_header.dart';

import 'item_tile.dart';

class SectionStaggered extends StatelessWidget{
  
  final Section section;

  const SectionStaggered({Key key, this.section}) : super(key: key);  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(section: section),
          StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            crossAxisCount: 4, 
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemCount: section.items.length,
            itemBuilder: (_,index){
              return ItemTile(
                item: section.items[index]
              );
            }, 
            staggeredTileBuilder: (index)=> StaggeredTile.count(
              2, index.isEven ? 2 : 1)
          )
        ],
      ),
    );
  }
}