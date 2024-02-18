import 'package:fruitshopweb/data/model/request/auth_request.dart';
import 'package:fruitshopweb/data/model/response/auth_reponse.dart';
import 'package:fruitshopweb/data/model/response/fruit_model.dart';
import 'package:fruitshopweb/data/repository/repository.dart';

class MockRemoteDateSourceSuccess extends DataSource {

  @override
  Future<FruitList> getFruits() {
    return Future.value(FruitList(fruitList: []));
  }

  @override
  Future<AuthResponse> login(AuthRequest request) {
    return Future.value(AuthResponse(message: "Mock Result"));
  }

  @override
  Future<AuthResponse> register(AuthRequest request) {
    return Future.value(AuthResponse(message: "Mock Result"));
  }
}
