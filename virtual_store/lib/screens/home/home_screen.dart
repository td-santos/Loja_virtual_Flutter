import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/common/custom_drawer/custom_drawer.dart';
import 'package:virtual_store/models/home_manager.dart';

import 'components/section_list.dart';
import 'components/section_staggered.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [ Colors.deepPurple,Colors.deepPurple[300]]
              )
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Loja do Thiago'),
                  centerTitle: true,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.shopping_cart), 
                    onPressed: ()=> Navigator.of(context).popAndPushNamed('/cart')
                  )
                ],
              ),
              Consumer<HomeManager>(
                builder: (_,homeManager,__){

                  final List<Widget> children = homeManager.sections.map<Widget>((section){
                    switch(section.type){
                      case 'Staggered':
                        return SectionStaggered(section: section);

                      case 'List':
                        return SectionList(section: section);                      
                      
                      default:
                        return Container();
                    }
                  }).toList();
                  return SliverList(
                    delegate: SliverChildListDelegate(children)
                  );
                }),
            ],
          )
        ],
      ),
    );
  }
}
