import 'dart:io';

import 'package:api_repository/api_repository.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

enum ApiRepositoryStatus { ok, badRequest, internalServerError }

class ApiRepository {
  ApiRepository();

  final String address = "https://192.168.0.108:45455";

  final Dio _dio = new Dio();

  Future<Object?> AuthorizePerson({
    required String username,
    required String password,
  }) async {
    var options = Options(headers: {
      "Accept": "application/json",
      "ContentType": "application/json"
    });
    try {
      var res = await _dio.post('$address/Persons/authenticate',
          data: {"Username": "$username", "Password": "$password"},
          options: options);
      if (res.statusCode == 200) {
        List<dynamic> p = jsonDecode(res.data.toString());
        var psn = new Person(id: p[0], token: p[1]);
        print(psn);
        var rmp = await GetPersonById(id: p[0], token: p[1]);
        if (rmp is Person) {
          psn.Update(rmp);
          print(psn);
          return psn;
        } else {
          throw Exception('Get person by id return object type != person');
        }
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
        var p = Person.fromJson(jsonDecode(res.data.toString()));
        var pn = await AuthorizePerson(username: username, password: password);
        p.token = (pn as Person).token;
        return p;
      }
    } catch (e) {
      print(e);
      return ApiRepositoryStatus.badRequest;
    }
    return null;
  }

  Future<Object?> GetPersonById({
    required int id,
    required String token,
  }) async {
    var options = Options(headers: {
      "Accept": "application/json",
      "Authorization": "Bearer ${token}",
    });
    try {
      var res = await _dio.get('$address/Persons/$id', options: options);
      if (res.statusCode == 200) {
        var p = Person.fromJson(jsonDecode(res.data.toString()));
        return p;
      }
    } catch (e) {
      print(e);
      return ApiRepositoryStatus.badRequest;
    }
    return null;
  }

  Future<Object?> UpsertPerson({
    required Person person,
  }) async {
    var options = Options(headers: {
      "Accept": "application/json",
      "Authorization": "Bearer ${person.token}",
    });
    try {
      print("data: ${person.toJson().toString()}");
      var res = await _dio.put('$address/Persons/upsert',
          data: person.toJson(), options: options);
      print(res);
      if (res.statusCode == 200) {
        print(res);
        if (res.data) return res.data;
        // var p = Person.fromJson(jsonDecode(res.data.toString()));
        // return p;
      }
    } catch (e) {
      print(e);
      return ApiRepositoryStatus.badRequest;
    }
    return null;
  }
}
