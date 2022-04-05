import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class SafariApi{

  final String _url = 'http://192.168.100.4:8000/api';
  final String _imgUrl='http://192.168.100.4:8000/images/';
  final String _imgUrlPub='http://192.168.100.4:8000/publicites/';
  final String _photoUrl='http://192.168.100.4:8000/acteurs/';
  final String _profilUrl='http://192.168.100.4:8000/profils/';
  final String _logoUrl='http://192.168.100.4:8000/logos/';

  getProfil() => _profilUrl;
  // php artisan serve --host 192.168.100.50 --port 8000

  getLogo() => _logoUrl;

  getImagePub() => _imgUrlPub;

  getImage() => _imgUrl;

  getUrl() => _url;

  getPhoto() => _photoUrl;

  setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
  };

  setHeadersFormdata(String token) => {
    //'method': 'PUT',
    'Content-type' : 'multipart/form-data',
    'Accept' : 'multipart/form-data',
    "Authorization" : 'Bearer $token',
  };

  setHeadersWithToken(String token) => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    "Authorization" : 'Bearer $token',
  };

  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '$token';
  }
  setToken(String token) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', token);
    //localStorage.setString('user', json.encode(body['user']));
  }

  deleteToken() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    localStorage.clear();
  }
}