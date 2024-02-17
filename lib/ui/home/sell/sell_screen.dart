import 'package:flutter/material.dart';
import 'package:fruitshopweb/constants/color_const.dart';
import 'package:fruitshopweb/ui/home/sell/products_screen.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../widget/custom_progress.dart';
import '../bloc/home_bloc.dart';
import 'cart_screen.dart';

class SellScreen extends StatefulWidget {
  static const routeName = "/sell-screen";
  const SellScreen({Key? key}) : super(key: key);

   static final  homeBloc = HomeBloc();

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {

  @override
  void initState() {
    super.initState();
    SellScreen.homeBloc.getProducts();
    SellScreen.homeBloc.init();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
          backgroundColor:  ColorPath.OFF_WHITE,
          body: Container(
            width: width,
            height: height,
            child: Stack(
              children: [
                Container(
                    width: width,
                    alignment: Alignment.center,
                    height: height,
                    child:  ResponsiveBuilder(
                        builder: (context, sizingInformation) {
                          if(sizingInformation.screenSize.width<900){
                            return Column(
                              children: [
                                Container(
                                  height: 230,
                                  child: ProductsScreen(),
                                ),
                                const SizedBox(height: 8,),
                                Expanded(child: CartScreen()),
                              ],
                            );
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 8,),
                              Expanded(
                                  child: ProductsScreen(),
                              ),
                              const SizedBox(width: 4,),
                              Container(height: height,color: Colors.grey,width: 5,),
                              Container(
                                  width: 450,
                                  child: CartScreen()
                              ),
                              const SizedBox(width: 8,),
                            ],
                          );
                        }
                    )
                ),
                Container(
                    width: width,
                    height: height,
                    child: customProgress(SellScreen.homeBloc.progressStatusStream)
                )
              ],
            ),
          ),
        );
  }
}