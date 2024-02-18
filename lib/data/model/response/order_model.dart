import 'package:fruitshopweb/data/model/response/fruit_model.dart';

/// name : "Persimmon"
/// id : 52
/// family : "Ebenaceae"
/// order : "Rosales"
/// genus : "Diospyros"
/// image : "https://orderstorage.blob.core.windows.net/images/persimmon.png"
/// nutritions : {"calories":81,"fat":0,"sugar":18,"carbohydrates":18,"protein":0}

class OrderModel {
  OrderModel({
      this.id,
      this.timestamp,
      this.items
   });

  OrderModel.fromJson(dynamic json) {
    id = json['id'];
    timestamp = json['timestamp'];
    if(json['items'] is Map){
      items = FruitList.fromJson(json['items']["fruitList"]);
    }else{
      items = FruitList.fromJson(json['items']);
    }
  }
  String? id;
  String? timestamp;
  FruitList? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['timestamp'] = timestamp;
    map['items'] = items?.toJson();
    return map;
  }

}


class OrderList {
  List<OrderModel> orderList = [];

  OrderList({required this.orderList});

  factory OrderList.fromJson(List<dynamic> parsedJson){

    if(parsedJson.isEmpty){
      return  OrderList(orderList: []);
    }

    List<OrderModel> list = parsedJson.map((i) => OrderModel.fromJson(i)).toList();
    return OrderList(
      orderList: list,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderList'] = orderList.map((v) => v.toJson()).toList();
    return data;
  }
}