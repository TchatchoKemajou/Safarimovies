import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class SafariApi{

  final String _url = 'http://192.168.0.101:8000/api';
  final String _imgUrl='http://mark.dbestech.com/uploads/';
  // php artisan serve --host 192.168.100.50 --port 8000


  getImage() => _imgUrl;

  getUrl() => _url;

  setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
  };

  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }
  setToken(String token) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', token);
    //localStorage.setString('user', json.encode(body['user']));
  }

  deleteToken() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
  }
}