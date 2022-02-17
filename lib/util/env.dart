import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

var dio = Dio();
late SharedPreferences preferences;
var db;