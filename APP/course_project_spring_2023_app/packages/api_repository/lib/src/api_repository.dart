import 'dart:io';

import 'package:api_repository/api_repository.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

enum ApiRepositoryStatus { ok, badRequest, internalServerError }

class ApiRepository {
  ApiRepository();

  final String address = "https://192.168.0.108:45456";

  final Dio _dio = new Dio();

  Future<Object?> AuthorizePerson({
    required String username,
    required String password,
  }) async {
    // var r = await _dio.get('$address/Persons/test');
    // if (r.data == 'Hello')
    //   print('Server is online');
    // else
    //   print("Server: ${r.statusCode}");

    // print('$address/Persons/authenticate');
    // print({"Username": "$username", "Password": "$password"});

    var options = Options(headers: {
      "Accept": "application/json",
      "ContentType": "application/json"
    });
    try {
      var res = await _dio.post('$address/Persons/authenticate',
          data: {"Username": "$username", "Password": "$password"},
          options: options);
      // print(res);
      // print(res.statusCode);
      if (res.statusCode == 200) {
        List<dynamic> p = jsonDecode(res.data.toString());
        // print(p);
        return new Person(p[0], p[1]);
      }
    } catch (e) {
      print(e);
      return ApiRepositoryStatus.badRequest;
    }
    return null;
  }

  Future<Object?> RegistratePerson({
    required String username,
    required String password,
  }) async {
    var options = Options(headers: {
      "Accept": "application/json",
      "ContentType": "application/json"
    });
    try {
      var res = await _dio.post('$address/Persons/register',
          data: {"Username": "$username", "Password": "$password"},
          options: options);
      if (res.statusCode == 200) {
        Map<String, dynamic> p = jsonDecode(res.data.toString());
        return new Person(p['Id'], p['Username'], isNewPerson: true);
      }
    } catch (e) {
      print(e);
      return ApiRepositoryStatus.badRequest;
    }
    return null;
  }
}
