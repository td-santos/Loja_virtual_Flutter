import 'package:flutter/material.dart';

class CustomIconButtom extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final VoidCallback ontap;
  final double size;

  const CustomIconButtom({Key key, this.iconData, this.color, this.ontap, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: ontap,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              iconData,
              color:ontap != null ? color : Colors.grey[400],
              size: size ?? 24,
            ),
          ),
        ),
      ),
    );
  }
}
