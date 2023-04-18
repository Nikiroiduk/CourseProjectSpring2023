import 'dart:io';

import 'package:flutter/widgets.dart';
import 'app.dart';
import 'package:dio/dio.dart';

import 'package:dcdg/dcdg.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
