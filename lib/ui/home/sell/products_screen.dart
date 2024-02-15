import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fruitshopweb/data/model/response/fruit_model.dart';
import 'package:fruitshopweb/ui/home/sell/sell_screen.dart';
import 'package:fruitshopweb/ui/shared_prefs.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/color_const.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_progress.dart';
import '../../varialble_ext.dart';


class ProductsScreen extends StatefulWidget {

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
        width: width,
        height: height,
        color: ColorPath.OFF_WHITE,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                SizedBox(
                  height: 20,
                  child: Text("Fruits", textAlign: TextAlign.start,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: ColorPath.MAIN_COLOR,
                    ),),
                ),
                const Expanded(child: SizedBox(width: 8,),),
              ],
            ),
            const SizedBox(height: 8,),
            const Divider(),
            Expanded(
              child: StreamBuilder<FruitList>(
                  stream:  SellScreen.homeBloc.productsStream,
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return  SingleChildScrollView(
                        child: Container(
                          height: height-300,
                          margin: const EdgeInsets.only(left: 16,right: 16),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 64.0,),
                              Container(
                                height: 150.0,
                                width: 150.0,
                                alignment: Alignment.center,
                                child: const Icon(Icons.report_gmailerrorred_outlined, size: 80,color: ColorPath.BRICK,),
                              ),
                              const SizedBox(height: 32.0,),
                              SizedBox(
                                child: Text('Oops! \nSomething Went Wrong!',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.spaceGrotesk(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: ColorPath.MAIN_COLOR
                                  ),),),
                              const SizedBox(height: 24.0,),
                              Container(
                                width: 250,
                                alignment: Alignment.center,
                                child: Text(snapshot.error.toString(),
                                  textAlign: TextAlign.center,
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.spaceGrotesk(
                                      fontSize: 14,
                                      color: ColorPath.GREY
                                  ),),
                              ),
                              const SizedBox(height: 32.0,),
                              customButtonTwo("Retry", onClick: (){

                              }, height: 45,width: 150),
                              const SizedBox(height: 16.0,),
                            ],
                          ),
                        ),
                      );
                    }
                    if(snapshot.data==null){
                      return customProgress(Stream.value(true));
                    }
                    return Container(
                      height: height-200,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            childAspectRatio: 0.75,
                            children: List.generate(snapshot.data?.fruitList.length??0, (index) {
                              EdgeInsets padding = index == 0
                                  ? const EdgeInsets.only(
                                  left: 5.0, right: 5.0, top: 5.0, bottom: 5.0)
                                  : const EdgeInsets.only(
                                  left: 5.0, right: 5.0, top: 5.0, bottom: 5.0);

                              final product = snapshot.data?.fruitList[index];

                               return Card(
                                 elevation: 1,
                                 color: Colors.white,
                                 child: Container(
                                   margin: padding,
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.stretch,
                                     children: <Widget>[
                                       Flexible(
                                         child: Container(
                                           margin: const EdgeInsets.all(4),
                                           decoration: BoxDecoration(
                                             color: ColorPath.DARK_COLOR,
                                             borderRadius: BorderRadius.circular(5.0),
                                           ),
                                           child: SizedBox(
                                             child: ClipRRect(
                                               borderRadius: BorderRadius.circular(5.0),
                                               child: CachedNetworkImage(
                                                 imageUrl: product?.image??"",fit: BoxFit.cover,
                                                 errorWidget: (context, url, error) => Center(child: Icon(Icons.error,color: Colors.grey,)),
                                               ),
                                             ),
                                           ),
                                         ),
                                       ),
                                       SizedBox(height: 4,),
                                       Container(
                                           color:Colors.white,
                                           margin: EdgeInsets.fromLTRB(12,2,12,2),
                                           child: Text(
                                             product?.name??"",
                                             maxLines: 2,
                                             overflow: TextOverflow.ellipsis,
                                             style: TextStyle(
                                               color:ColorPath.BLACK,
                                               fontWeight: FontWeight.bold,
                                               fontSize: 12.0,
                                             ),
                                           )),
                                       Container(
                                           color:Colors.white,
                                           margin: EdgeInsets.fromLTRB(12,0,12,2),
                                           child: Text(
                                             (product?.nutritions?.carbohydrates??0).formatPrice(),
                                             overflow: TextOverflow.ellipsis,
                                             style: const TextStyle(
                                               color:ColorPath.BLACK,
                                               fontSize: 12.0,
                                             ),
                                           )),
                                       SizedBox(height: 4,),
                                       Container(
                                         margin: EdgeInsets.only(left: 8, right: 8),
                                         child: customButtonTwo("Add", height: 28, color: ColorPath.DARK_COLOR, onClick: (){
                                           setState(() {
                                             SellScreen.homeBloc.addToCart(product!);
                                           });
                                         }),

                                       ),
                                       // Add to cart
                                       SizedBox(height: 4,),

                                     ],
                                   ),
                                 ),
                               );
                            }),
                          );
                        },
                        itemCount: 1,
                      ),
                    );

                    return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        EdgeInsets padding = index == 0
                            ? const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 12.0, bottom: 12.0)
                            : const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 12, bottom: 12.0);
                        return Container(
                          padding: padding,
                          decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(8.0))),
                          margin: const EdgeInsets.only(top: 4,bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 40,
                                alignment: Alignment.center,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEDF5FD),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data?.fruitList[index].image??"",fit: BoxFit.cover,
                                    height: 40,width: 40,
                                    errorWidget: (context, url, error) => const Icon(Icons.error,color: Colors.grey,),
                                  ),
                                )
                              ),
                              const SizedBox(width: 12.0,),
                              Expanded(child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.fromLTRB(2,2,16,2),
                                      child:  Text( snapshot.data?.fruitList[index].name??"",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.spaceGrotesk(
                                          color:ColorPath.MAIN_COLOR,
                                          fontSize: 14.0,
                                        ),
                                      )),
                                  Row(
                                    children: [
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.fromLTRB(2,2,2,2),
                                          child:  Text( "${snapshot.data?.fruitList[index].family??""} * ",
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.spaceGrotesk(
                                              fontWeight: FontWeight.w400,
                                              color:ColorPath.GREY,
                                              fontSize: 12.0,
                                            ),
                                          )),
                                      Flexible(
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            margin: const EdgeInsets.fromLTRB(2,2,16,2),
                                            child:  Text( snapshot.data?.fruitList[index].genus??"",
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.spaceGrotesk(
                                                fontWeight: FontWeight.w400,
                                                color:ColorPath.GREY,
                                                fontSize: 12.0,
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ],)),
                              const SizedBox(width: 12.0,),
                              Container(
                                  alignment: Alignment.centerRight,
                                  margin: const EdgeInsets.fromLTRB(2,2,12,2),
                                  child: Text((snapshot.data?.fruitList[index].nutritions?.carbohydrates??0).formatPrice(),
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.spaceGrotesk(
                                      color:ColorPath.MAIN_COLOR,
                                      fontSize: 12.0,
                                    ),
                                  )),
                              InkWell(
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  child: const InkWell(
                                    child: Icon(Icons.add,color: ColorPath.ACCENT_COLOR,),
                                  ),
                                ),
                                onTap: () async {


                                },
                              ),

                            ],
                          ),
                        );
                      },
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.fruitList.length,
                    );
                  }
              ),
            )
          ],
        )
    );
  }
}

