import 'package:dio/adapter.dart';
import 'package:eclipse_digital_studio_test/models/models.dart';
import 'dart:async';
import 'dart:io';
import 'package:eclipse_digital_studio_test/util/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'users.dart';

class Splash extends StatefulWidget {
  static const routeName = 'splashScreen';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // Do not check http certificates
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    dio.options.baseUrl = 'https://jsonplaceholder.typicode.com/';
    //Get data and navigate to home page
    Future.delayed(const Duration(milliseconds: 4000), () async {
      await Hive.initFlutter();
      //Register adapters for hive
      Hive.registerAdapter(UserAdapter());
      Hive.registerAdapter(UserDetailAdapter());
      Hive.registerAdapter(PostsAdapter());
      Hive.registerAdapter(PostDetailAdapter());
      Hive.registerAdapter(AlbumsAdapter());
      Hive.registerAdapter(AlbumDetailAdapter());

      db = await Hive.openBox('db');

      preferences = await SharedPreferences.getInstance();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Users(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Logo
            SvgPicture.asset('images/eclipseLogo.svg'),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
