import 'dart:io';

import 'package:eclipse_digital_studio_test/ui/app.dart';
import 'package:flutter/material.dart';
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

