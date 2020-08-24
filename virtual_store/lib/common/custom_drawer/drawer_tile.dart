import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/models/page_manager.dart';


class DrawerTile extends StatelessWidget {

  final IconData iconData;
  final String title;
  final int page;


  const DrawerTile({Key key, this.iconData, this.title, this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final int currentPage = context.watch<PageManager>().page;
    final primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: () {
        context.read<PageManager>().setPage(page);
        //debugPrint("toque ink - page: $page");
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                color: currentPage == page? primaryColor : Colors.grey[700],
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 16, color: currentPage == page ? primaryColor :Colors.grey[700]),
            )
          ],
        ),
      ),
    );
  }
}
