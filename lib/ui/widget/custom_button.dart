import 'package:flutter/material.dart';

import '../../constants/color_const.dart';

Widget customButton (String label, {VoidCallback? onClick, double width = 250, double height = 55, double radius = 16.0,color = ColorPath.DARK_COLOR  }){
  return Center(
    child: Container(
      height: height,
      width: width,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius)),
      ),
      child: TextButton(
        onPressed: (){
          if(onClick!=null){
            onClick();
          }
        },
        child: Text(label, style: TextStyle(
            color: Colors.white,
            fontSize: 12
        )
        ),
        // shape: RoundedRectangleBorder(side: BorderSide(
        //     color: Colors.white,
        //     width: 1,
        //     style: BorderStyle.solid
        // ), borderRadius: BorderRadius.circular(6)),
      ),
    ),
  );

}

Widget customIconButton ({VoidCallback? onClick, double width = 100, double height = 55, double radius = 8.0,color = ColorPath.MAIN_COLOR ,  icon =Icons.chevron_left_outlined, iconColor = Colors.black}){
  return Center(
    child: InkWell(
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
        ),
        child: Icon(icon, color: iconColor,size: 20,),
      ),
      onTap: (){
        if(onClick!=null){
          onClick();
        }
      },
    ),
  );

}
Widget customButtonTwo(String label,
    {VoidCallback? onClick,
      double width = 250,
      double height = 50,
      double radius = 8.0,
      color = ColorPath.MAIN_COLOR}) {
  return InkWell(
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          border: Border.all(color: color, width: 1.4),
          color: Colors.transparent),
      child: Center(
        child: Text(label,
            style: new TextStyle(
                fontSize: 12, color:color)),
      ),
    ),
    onTap: (){
      if (onClick != null) {
        onClick();
      }
    },
  );
}