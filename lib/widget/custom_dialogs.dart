import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/color_const.dart';
import '../../constants/imagepath.dart';
import 'custom_button.dart';

class CustomDialogs {

  static AlertDialog showErrorDialog(context,String messsage, {String title ="Something went wrong", String buttonText = "Okay", bool showSecondaryButton = true,String secondaryButtonText = "Not Now",  Function()? positiveCallback, Function()? negativeCallback}) {
    // flutter defined function
    final _width = MediaQuery.of(context).size.width;
    return  AlertDialog(
      contentPadding: const EdgeInsets.only(left: 20.0,right: 16.0),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      content: SizedBox(
        height: 350,
        width: 320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 24.0,),
            Container(
              height: 85.0,
              width: 85.0,
              alignment: Alignment.center,
              child: const Icon(Icons.report_gmailerrorred_outlined, size: 80,color: ColorPath.BRICK,),
            ),
            const SizedBox(height: 16.0,),
            SizedBox(
              width: _width,
              child: Text('$title',
                textAlign: TextAlign.center,
                style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: ColorPath.MAIN_COLOR
                ),),),
            const SizedBox(height: 8.0,),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 16.0,right: 16.0),
              child: Text("$messsage",
                textAlign: TextAlign.center,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.spaceGrotesk(
                    fontSize: 14,
                    color: ColorPath.GREY
                ),),
            ),
            const SizedBox(height: 20.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 45,
                  width: 200,
                  child: Material(  //Wrap with Material
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8.0) ),
                    clipBehavior: Clip.antiAlias, // Add This
                    child: MaterialButton(
                      height: 45,
                      color: ColorPath.ACCENT_COLOR,
                      child: Text(
                          buttonText,
                          style: GoogleFonts.spaceGrotesk(fontSize: 14, color: ColorPath.WHITE)),
                      onPressed: (){
                        Navigator.of(context).pop();

                        if(positiveCallback!=null){
                          positiveCallback();
                        }

                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: false,
                  child: InkWell(
                    child: Container(
                      height: 50.0,
                      width: 200,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        secondaryButtonText,
                        style: GoogleFonts.spaceGrotesk(
                          color:ColorPath.GREY,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).pop();
                      if(negativeCallback!=null){
                        negativeCallback();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0,),
          ],
        ),
      ),
    );

  }

  static AlertDialog showMessageDialog(context,String messsage, {String title ="Success", String buttonText = "Okay",
    bool showSecondaryButton = true,String secondaryButtonText = "Not Now",  Function()? positiveCallback, Function()? negativeCallback}) {
    // flutter defined function
    final _width = MediaQuery.of(context).size.width;
    return  AlertDialog(
      contentPadding: const EdgeInsets.only(left: 20.0,right: 16.0),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      content: SizedBox(
        height: 350,
        width: 320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 24.0,),
            Container(
              height: 85.0,
              width: 85.0,
              alignment: Alignment.center,
              child: const Icon(Icons.check_circle_outline_rounded, size: 85,color: ColorPath.GREEN,),
            ),
            const SizedBox(height: 16.0,),
            SizedBox(
              width: _width,
              child: Text('$title',
                textAlign: TextAlign.center,
                style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: ColorPath.MAIN_COLOR
                ),),),
            const SizedBox(height: 8.0,),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 16.0,right: 16.0),
              child: Text("$messsage",
                textAlign: TextAlign.center,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.spaceGrotesk(
                    fontSize: 14,
                    color: ColorPath.GREY
                ),),
            ),
            const SizedBox(height: 20.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 45,
                  width: 200,
                  child: Material(  //Wrap with Material
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(6.0) ),
                    clipBehavior: Clip.antiAlias, // Add This
                    child: MaterialButton(
                      height: 45,
                      color: ColorPath.ACCENT_COLOR,
                      child: Text(
                          buttonText,
                          style: GoogleFonts.spaceGrotesk(fontSize: 14, color: ColorPath.WHITE)),
                      onPressed: (){
                        Navigator.of(context).pop();

                        if(positiveCallback!=null){
                          positiveCallback();
                        }

                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0,),
          ],
        ),
      ),
    );

  }

}
