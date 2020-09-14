import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:virtual_store/models/home_manager.dart';
import 'package:virtual_store/models/section.dart';
import 'package:virtual_store/screens/home/components/add_tile_widget.dart';
import 'package:virtual_store/screens/home/components/section_header.dart';
import 'item_tile.dart';
import 'package:provider/provider.dart';

class SectionStaggered extends StatelessWidget{
  
  final Section section;

  const SectionStaggered({Key key, this.section}) : super(key: key);  

  @override
  Widget build(BuildContext context) {

    final homeManager = context.watch<HomeManager>();

    return ChangeNotifierProvider.value(
      value: section,
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SectionHeader(section: section),
            Consumer<Section>(
              builder: (_,section,__){
                return StaggeredGridView.countBuilder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              crossAxisCount: 4, 
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount: homeManager.editing ? section.items.length + 1 : section.items.length,
              itemBuilder: (_,index){

                if(index < section.items.length){
                  return ItemTile(
                    item: section.items[index]
                  );
                }else{
                  return AddTileWidget();
                }
                
              }, 
              staggeredTileBuilder: (index)=> StaggeredTile.count(
                2, index.isEven ? 2 : 1)
            );
              },
            )
          ],
        ),
      ),
    );
  }
}