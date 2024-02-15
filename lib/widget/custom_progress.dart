

import 'package:flutter/material.dart';

import '../../constants/color_const.dart';

Widget customProgress(Stream<bool> loadingState){
  return StreamBuilder(
      stream: loadingState,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if(snapshot.hasData && snapshot.data==true){
          return Container(
            color: ColorPath.OFF_WHITE.withOpacity(0.85),
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(0.0),
                  margin: EdgeInsets.all(0.0),
                  child: Container(
                    width: 100.0,
                    height: 100,
                    alignment: Alignment.center,
                    child:  CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(ColorPath.DARK_COLOR),
                      strokeWidth: 2,
                      backgroundColor: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      border: Border.all(
                        color: ColorPath.DARK_COLOR,
                        width: 2
                      ),
                      color: Colors.transparent,
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 16,left: 16),
                  child: Text("B",maxLines:1,overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(color: ColorPath.DARK_COLOR,fontSize: 16,
                        fontWeight: FontWeight.normal, fontStyle: FontStyle.normal),textAlign: TextAlign.center,),
                ),
              ],
            ),
          );
        }else{
          return SizedBox();
        }
      }
  );
}