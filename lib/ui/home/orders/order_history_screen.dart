import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruitshopweb/data/model/response/fruit_model.dart';
import 'package:fruitshopweb/data/model/response/order_model.dart';
import 'package:fruitshopweb/ui/home/sell/sell_screen.dart';
import 'package:fruitshopweb/ui/varialble_ext.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../constants/color_const.dart';
import '../../../widget/custom_button.dart';
import '../../widget/custom_dialogs.dart';


class OrderScreen extends StatefulWidget {
  static const routeName = "/order-screen";

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor:  ColorPath.OFF_WHITE,
      body: Container(
        width: width,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const SizedBox(height: 16,),
            SizedBox(
              height: 20,
              child: Text("Past Orders", textAlign: TextAlign.start,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: ColorPath.MAIN_COLOR,
                ),),
            ),
            const SizedBox(height: 16,),
            const Divider(),
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                width: 400,
                child: StreamBuilder<List<OrderModel>>(
                    stream: SellScreen.homeBloc.ordersStream,
                    builder: (context, snapshot) {
                      if(snapshot.hasError || snapshot.data==null ){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.line_weight_sharp,
                              color: ColorPath.MAIN_COLOR,
                              size: 100,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            SizedBox(
                              width: width / 1.5,
                              child: const Text(
                                'No items orders have added placed at the moment',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        );

                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          EdgeInsets padding = const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 12.0, bottom: 12.0);
                          final orders = snapshot.data![index];

                          return Card(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                              elevation: 1,
                              margin: EdgeInsets.only(top: 4,bottom: 4,left: 8, right: 8),
                              child: Container(
                                margin: EdgeInsets.zero,
                                height: 100,
                                padding: padding,
                                child: Container(
                                  padding: padding,
                                  child: Column(
                                    children: <Widget>[
                                      const SizedBox(height: 4,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 40,
                                            height: 30,
                                            margin: const EdgeInsets.only(bottom: 4.0,top: 4.0,right: 16.0,left: 0.0),
                                            alignment: Alignment.center,
                                            child: Icon(Icons.add_chart_sharp),
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text("CAD ${sumSellingPrices(orders.items?.fruitList)}", style: GoogleFonts.spaceGrotesk(color: ColorPath.MAIN_COLOR, fontSize: 14.0),),
                                              const SizedBox(height: 4,),
                                              Container(
                                                child: Text("Processing",style: GoogleFonts.spaceGrotesk(color: ColorPath.GREY, fontSize: 11.0,fontWeight: FontWeight.w100),overflow: TextOverflow.ellipsis,),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Container(
                                                alignment: Alignment.topRight,
                                                child: Text("${orders.items?.fruitList.length} item(s) ",style: GoogleFonts.spaceGrotesk(color: ColorPath.GREY, fontSize: 12.0,fontWeight: FontWeight.w300),overflow: TextOverflow.ellipsis)
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4,),
                                    ],
                                  ),
                                ),
                              ));
                        },
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data?.length,
                      );
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int sumSellingPrices(List<FruitModel>? products) {
    if(products==null){
      return 0;
    }
    return products.fold(0, (curr, next) => curr + ((next.nutritions?.carbohydrates?.toInt()??1) * (next.quantity??1)));
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

