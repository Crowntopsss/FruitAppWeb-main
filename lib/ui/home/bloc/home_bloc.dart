import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fruitshopweb/data/model/request/auth_request.dart';
import 'package:fruitshopweb/data/model/response/fruit_model.dart';
import 'package:fruitshopweb/data/model/response/order_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../data/repository/repository.dart';
import '../../shared_prefs.dart';

class HomeBloc  {
  final _repo = Repository();

  final _showProgressSubject = BehaviorSubject<bool>();
  Stream<bool> get progressStatusStream => _showProgressSubject.stream;
  Function(bool) get showProgressBar => _showProgressSubject.sink.add;

  final _productsSubject = BehaviorSubject<FruitList>();
  Stream<FruitList> get productsStream => _productsSubject.stream;

  final _cartItemsSubject = BehaviorSubject<List<FruitModel>>();
  Stream<List<FruitModel>> get cartItemsStream => _cartItemsSubject.stream;

  final _orderSubject = BehaviorSubject<List<OrderModel>>();
  Stream<List<OrderModel>> get ordersStream => _orderSubject.stream;

  init() async {
    _cartItemsSubject.sink.add((await MySharedPrefs.getCartItems()).fruitList);
    _orderSubject.add((await MySharedPrefs.getOrders()).orderList);
  }


  addToCart(FruitModel product) async {
    final value  = _cartItemsSubject.valueOrNull?? (await MySharedPrefs.getCartItems()).fruitList;
    if(value.contains(product)){
      final index = value.indexOf(product);
      value.remove(product);
      value.insert(index, product);
    }else{
      value.add(product);
    }
    MySharedPrefs.saveCartItems(FruitList(fruitList: value));
    _cartItemsSubject.sink.add(value);
  }

  removeFromCart(FruitModel product){
    final value  = _cartItemsSubject.valueOrNull?? <FruitModel>[];
    value.remove(product);
    _cartItemsSubject.sink.add(value);
    MySharedPrefs.saveCartItems(FruitList(fruitList: value));
  }

  saveOrder(OrderModel orderModel) async {
    final value  = _orderSubject.valueOrNull?? (await MySharedPrefs.getOrders()).orderList;
    value.add(orderModel);
    MySharedPrefs.saveOrder(OrderList(orderList: value));
    _cartItemsSubject.sink.add(<FruitModel>[]);
    MySharedPrefs.saveCartItems(FruitList(fruitList: <FruitModel>[]));

  }

  getProducts(){
    print("called");
    _showProgressSubject.sink.add(true);
     _repo.getFruits().then((response) async {
       print("Success");
      _showProgressSubject.sink.add(false);
      _productsSubject.sink.add(response);
    }, onError: (e) {
       print(e);
      _productsSubject.sink.addError(e);
      _showProgressSubject.sink.add(false);
    });
  }



  void dispose() async {
    _showProgressSubject.drain();
    await _showProgressSubject.close();
    _productsSubject.drain();
    await _productsSubject.close();
  }
}
