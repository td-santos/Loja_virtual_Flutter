import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/common/custom_drawer/custom_drawer.dart';
import 'package:virtual_store/models/home_manager.dart';
import 'package:virtual_store/models/user_manager.dart';

import 'components/add_section_widget.dart';
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
                colors: [ Colors.grey[900],Colors.grey[850]]
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
                  ),
                  Consumer2<UserManager,HomeManager>(
                    builder: (_,userManager,homeManager,__){
                      if(userManager.adminEnabled && !homeManager.loading){
                        if(homeManager.editing){
                          return PopupMenuButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                            onSelected: (e){
                              if(e == 'Salvar'){
                                homeManager.saveEditing();
                              }else{
                                homeManager.discardEditing();
                              }
                            },
                            itemBuilder: (_){
                              return ['Salvar','Descartar'].map((e) {
                                return PopupMenuItem(
                                  value: e,
                                  child: Text(e));
                              }).toList();
                            }
                          );
                        }else{
                          return IconButton(
                            icon: Icon(Icons.edit), 
                            onPressed: homeManager.enterEditing
                          );
                        }
                        
                      }else{
                        return Container();
                      }
                    },
                  )
                ],
              ),
              Consumer<HomeManager>(
                builder: (_,homeManager,__){
                  if(homeManager.loading){
                    return SliverToBoxAdapter(
                      child: LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                        backgroundColor: Colors.transparent,                        
                      ),
                    );
                  }
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
                  if(homeManager.editing)
                    children.add(AddSectionWidget());
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
