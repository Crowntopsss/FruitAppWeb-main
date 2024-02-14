import 'package:dio/dio.dart';
import 'package:fruitshopweb/data/model/request/auth_request.dart';
import 'package:fruitshopweb/data/model/response/auth_reponse.dart';

import '../model/response/fruit_model.dart';
import '../provider/api_providers.dart';


class Repository extends DataSource {
  final apiProvider = ApiProvider();

  @override
  Future<AuthResponse> login(AuthRequest request) =>
      apiProvider.login(request);

  @override
  Future<AuthResponse> register(AuthRequest request) =>
      apiProvider.register(request);

  @override
  Future<FruitList> getFruits() =>
      apiProvider.getFruits();

}


abstract class DataSource {

  Future<AuthResponse> login(AuthRequest request);

  Future<AuthResponse> register(AuthRequest request);

  Future<FruitList> getFruits();

}
