import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruitshopweb/data/model/response/fruit_model.dart';
import 'package:fruitshopweb/data/model/response/order_model.dart';
import 'package:fruitshopweb/ui/home/base_home_view.dart';
import 'package:fruitshopweb/ui/home/sell/sell_screen.dart';
import 'package:fruitshopweb/ui/varialble_ext.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../constants/color_const.dart';
import '../../../widget/custom_button.dart';
import '../../widget/custom_dialogs.dart';
import '../orders/order_history_screen.dart';


class CartScreen extends StatefulWidget {

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      color: Colors.grey.withOpacity(0.2),
      alignment: Alignment.topCenter,
      child: StreamBuilder<List<FruitModel>>(
          stream: SellScreen.homeBloc.cartItemsStream,
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
                      'No items has been added at the moment',
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
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      EdgeInsets padding = const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 12.0, bottom: 12.0);
                      final product = snapshot.data![index];

                      return Card(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                          elevation: 1,
                          margin: EdgeInsets.only(top: 4,bottom: 4,left: 8, right: 8),
                          child: Container(
                            margin: EdgeInsets.zero,
                            height: 80,
                            padding: padding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 45,
                                  width: 60,
                                  margin: const EdgeInsets.only(left: 0,right: 0),
                                  alignment: Alignment.center,
                                  child: TextField(
                                    keyboardType:  TextInputType.number,
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    onChanged: (value){
                                      product.quantity = int.tryParse(value.toString())??1;
                                      SellScreen.homeBloc.addToCart(product);
                                    },
                                    cursorColor: Colors.transparent,
                                    cursorWidth: 1,
                                    style: GoogleFonts.spaceGrotesk(
                                      color: ColorPath.MAIN_COLOR,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.0,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "${product.quantity??1}",
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: ColorPath.GREY, width: 0.3),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: ColorPath.GREY, width: 0.4),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: ColorPath.ACCENT_COLOR, width: 1.0),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      hintStyle: GoogleFonts.spaceGrotesk(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16,),
                                SizedBox(
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          text: product.name,
                                          style: GoogleFonts.spaceGrotesk(
                                              fontSize: 14,
                                              wordSpacing: 1.0,
                                              color: ColorPath.MAIN_COLOR
                                          ),
                                          children:  <TextSpan>[
                                            TextSpan(text: "", style: GoogleFonts.spaceGrotesk( fontSize: 14,wordSpacing: 1,)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8,),
                                      Text(((product.nutritions?.carbohydrates??1)*(product.quantity??1)).formatPrice(),
                                        style: GoogleFonts.spaceGrotesk(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold
                                        ),),
                                    ],
                                  ),
                                ),
                                const Expanded(child: SizedBox(width: 16,)),
                                InkWell(
                                  child: const Icon(Icons.delete_outline, size: 20,color: Colors.red,),
                                  onTap: (){
                                    SellScreen.homeBloc.removeFromCart(product);
                                  },
                                ),
                                const SizedBox(width: 16,),
                              ],
                            ),
                          ));
                    },
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data?.length,
                  ),
                ),
                SizedBox(width: 8,),
                Container(
                  child: customButton("Check Out", onClick: () async {
                    final order = OrderModel(id: "${snapshot.data.hashCode}", timestamp: DateTime.now().toIso8601String(), items: FruitList(fruitList: snapshot.data??<FruitModel>[]));
                    await SellScreen.homeBloc.saveOrder(order);
                    BaseHomeView.navigatorKey.currentState?.pushReplacementNamed(OrderScreen.routeName);

                  }),
                ),
                const SizedBox(width: 8,),
                Container(
                  height: 70,
                  margin: EdgeInsets.only(top: 8,bottom: 8,left: 8, right: 8),
                  padding: EdgeInsets.all(16),
                  color:  ColorPath.OFF_WHITE,
                  child:  Row(
                    children: [
                      Expanded(
                          child: Text("TOTAL",
                            style: GoogleFonts.spaceGrotesk(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: ColorPath.MAIN_COLOR
                            ),)),
                      Text("${sumSellingPrices(snapshot.data??<FruitModel>[]).formatPrice()}",
                        style: GoogleFonts.spaceGrotesk(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: ColorPath.MAIN_COLOR
                        ),),
                    ],
                  ),
                )
              ],
            );
          }
      ),
    );
  }

  int sumSellingPrices(List<FruitModel> products) {
    print("sumSellingPrices: ${products.length}");
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

