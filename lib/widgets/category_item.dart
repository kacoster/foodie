import 'package:flutter/material.dart';
import 'package:foodie/theme/color.dart';
import 'package:foodie/utils/global.dart' as globals;

// ignore: must_be_immutable
class CategoryItem extends StatefulWidget {
  CategoryItem({Key? key, required this.data, this.seleted = true, this.onTap})
      : super(key: key);
  final data;
  bool seleted;
  final GestureTapCallback? onTap;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          globals.category = widget.data['name'];
          print(globals.category);
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(right: 10),
        width: 90,
        decoration: BoxDecoration(
          color: widget.seleted ? primary : cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.05),
              spreadRadius: .5,
              blurRadius: .5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.data["icon"],
                size: 17, color: widget.seleted ? Colors.white : darker),
            SizedBox(
              width: 7,
            ),
            Text(
              widget.data["name"],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 13, color: widget.seleted ? Colors.white : darker),
            )
          ],
        ),
      ),
    );
  }
}
