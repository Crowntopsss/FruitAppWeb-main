import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fruitshopweb/data/model/request/auth_request.dart';
import 'package:fruitshopweb/data/model/response/fruit_model.dart';
import 'package:fruitshopweb/data/model/response/auth_reponse.dart';

import '../network_manager/network_manager.dart';

class ApiProvider {
  NetworkManager networkManager = NetworkManager();

  Future<AuthResponse> login(AuthRequest request) async {
    NetworkManager networkManager = NetworkManager();
    var completer = Completer<AuthResponse>();
    try {
      final response = await networkManager.networkRequestManager(
          RequestType.POST, "api/users/login",
          body: json.encode(request.toJson()));
      var result = AuthResponse.fromJson(response);
      completer.complete(result);
    } catch (e) {
      print(e);
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<AuthResponse> register(AuthRequest request) async {
    NetworkManager networkManager = NetworkManager();
    var completer = Completer<AuthResponse>();
    try {
      final response = await networkManager.networkRequestManager(
          RequestType.POST, "api/users/register",
          body: json.encode(request.toJson()));
      var result = AuthResponse.fromJson(response);
      completer.complete(result);
    } catch (e) {
      print(e);
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<FruitList> getFruits() async {
    NetworkManager networkManager = NetworkManager();
    var completer = Completer<FruitList>();
    try {
      final response = await networkManager.networkRequestManager(
          RequestType.GET, "fruits");
      var result = FruitList.fromJson(response);
      completer.complete(result);
    } catch (e) {
      print(e);
      completer.completeError(e);
    }
    return completer.future;
  }

}
