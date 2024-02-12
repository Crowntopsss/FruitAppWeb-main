import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/color_const.dart';
import '../../constants/imagepath.dart';
import '../widget/custom_dialogs.dart';


class OnBoardingBannerScreen extends StatefulWidget {

  @override
  _OnBoardingBannerScreenState createState() => _OnBoardingBannerScreenState();
}

class _OnBoardingBannerScreenState extends State<OnBoardingBannerScreen> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

   return Container(
     color: ColorPath.OFF_WHITE,
     child: CarouselSlider(
         options: CarouselOptions(
           height: height,
           aspectRatio: 16/9,
           viewportFraction: 1,
           initialPage: 0,
           enableInfiniteScroll: true,
           reverse: false,
           autoPlay: true,
           autoPlayInterval: const Duration(seconds: 5),
           autoPlayAnimationDuration: Duration(milliseconds: 1000),
           autoPlayCurve: Curves.fastOutSlowIn,
           enlargeCenterPage: true,
           scrollDirection: Axis.horizontal,
         ),
        items: [ImagePath.LANDING_IMAGE,ImagePath.LANDING_TWO_IMAGE,ImagePath.LANDING_THREE_IMAGE].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.only(top: 64, bottom: 64, left: 32, right: 32),
                padding: const EdgeInsets.all(64),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 2,
                      spreadRadius: 1,
                      color: Colors.black26,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child:  Image(
                    image: AssetImage(i),
                    loadingBuilder: (context, widget, value) {
                      if (value == null) return widget;
                      return Container(
                          height: height*0.7,
                          child: const CupertinoActivityIndicator()
                      );
                    },
                    fit: BoxFit.contain,),
                ),
              );
            },
          );
        }).toList(),
      ),
   );
  }


  void showSuccessMessage(message,context){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogs.showMessageDialog(context, message.toString());
        }
    );
  }

  void showErrorDialog(message,context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogs.showErrorDialog(context, message.toString());
        }
    );
  }
}

