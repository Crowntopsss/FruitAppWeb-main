import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class NetworkManager {
  static BaseOptions options = BaseOptions(
    connectTimeout: Duration(seconds: 30000),
    receiveTimeout: Duration(seconds: 30000),
  );
  Dio client = new Dio(options);
  String? token;

  Future<dynamic> networkRequestManager(
      RequestType vrxRequestType, String requestUrl,
      {dynamic body,
      queryParameters,
      BehaviorSubject<int>? progressStream,
      File? backFile}) async {

    var baseUrl = "https://fruitappwp.azurewebsites.net/";
    String url = '$baseUrl$requestUrl';

    log("url: $url");

    try {
      switch (vrxRequestType) {
        case RequestType.GET:
          var response = await client.get(
            url,
            queryParameters: queryParameters,
          );
          log("get: ${response.data.toString()}");
          return response.data;
          break;
        case RequestType.POST:
          var response = await client
              .post(url, data: body, queryParameters: queryParameters,
                  onSendProgress: (int count, int total) {
            if (progressStream != null) {
              double percentage = (count / total) * 100;
              progressStream.sink.add(percentage.toInt());
            }
          });
          log("post: ${response.data.toString()}");
          print("error location: ${response.statusCode}");
          return response.data;
        case RequestType.MULTI_PART_POST:
          var response = await client.post(
            url,
            data: body,
            queryParameters: queryParameters,
          );
          print("post: ${response.data.toString()}");
          return response.data;
        case RequestType.PUT:
          print("Request type put");
          var response = await client.put(url,
              data: body, queryParameters: queryParameters);
          print("put: ${response.data.toString()}");
          return response.data;
        case RequestType.PATCH:
          var response = await client.patch(url,
              data: body, queryParameters: queryParameters);
          return response.data;
        case RequestType.DELETE:
          var response = await client.delete(url,
              data: body, queryParameters: queryParameters);
          return response.data;
        default:
          var response = await client.post(url,
              data: body, queryParameters: queryParameters);
          return response.data;
      }
    } on TimeoutException catch (n) {
      print("Network Timeout Error response: $n");
      throw ("Network timed out, please check your network connection and try again");
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectionTimeout == e.type) {
        print("Network Timeout Error response: $e");
        throw ("Network timed out, please check your network connection and try again");
      } else if (DioErrorType.unknown == e.type) {
        if (e.message?.contains('SocketException')==true) {
          print("No Network Error response: $e");
          throw ("No internet connection, please check your network connection and try again");
        } else {
          print("No Network Error response: $e");
          throw ("An error occurred processing this request, please try again later");
        }
      }


      if (e.response!.statusCode == 401) {
        throw ("Invalid credentials, please try again");
      } else if (e.response!.statusCode == 404) {
        throw ("Resource not found, please try again later");
      } else if (e.response!.statusCode!.isBetween(399, 499)) {
        final data = json.decode(e.response.toString());
        if(data!=null && data["message"]!=null){
           throw (data["message"]);
        }
        throw ("${json.decode(e.response.toString())}");
      } else if ((e.response?.statusCode??0) >= 500) {
        throw ("We are unable to process request at this time, please try again later");
      } else {
        throw ("Unable to process request at this time");
      }
    } catch (e) {
      print("Internal Error response: $e");
      throw ("An error occurred while processing this request");
    }
  }
}

extension Range on num {
  bool isBetween(num from, num to) {
    return from < this && this < to;
  }
}

enum RequestType {
  GET,
  POST,
  PUT,
  PATCH,
  DELETE,
  MULTI_PART_POST,
}
