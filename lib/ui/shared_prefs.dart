import 'dart:async';
import 'dart:convert';
import 'package:fruitshopweb/data/model/response/fruit_model.dart';
import 'package:fruitshopweb/data/model/response/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPrefs {
  static Future<FruitList> getCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("cart");

    if (data == null) {
      return FruitList(fruitList: <FruitModel>[]);
    }
    Map map = jsonDecode(data);
    FruitList items = FruitList.fromJson(map["fruitList"] as List<dynamic>);
    return items;
  }

  static void saveCartItems(FruitList? fruitList) async {
    if(fruitList==null){return;}
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = jsonEncode(fruitList.toJson());
    prefs.setString("cart", data);
  }

  static Future<OrderList> getOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("order");

    if (data == null) {
      return OrderList(orderList: <OrderModel>[]);
    }
    Map map = jsonDecode(data);
    print("order: ${map["orderList"]}");
    OrderList items = OrderList.fromJson(map['orderList'] as List<dynamic>);
    return items;
  }

  static void saveOrder(OrderList? list) async {
    if(list==null){return;}
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = jsonEncode(list.toJson());
    prefs.setString("order", data);
  }



  static void clearDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
