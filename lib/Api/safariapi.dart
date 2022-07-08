import 'package:shared_preferences/shared_preferences.dart';
class SafariApi{

  static const String baseurl = 'http://172.20.10.2:8000';
  //static const String baseurl = 'http://172.20.10.4:8000';
  //static const String baseurl = 'http://192.168.43.183:8000';
 // static const String baseurl = "https://3b28-129-0-76-21.eu.ngrok.io";
  final String _url = baseurl + '/api';
  final String _imgUrl= baseurl + '/images/';
  final String _imgUrlPub= baseurl + '/publicites/';
  final String _photoUrl= baseurl + '/acteurs/';
  final String _profilUrl= baseurl + '/profils/';
  final String _logoUrl= baseurl + '/logos/';
  final String _filmUrl= baseurl + '/films/';
  final String _episodeUrl= baseurl + '/episodes/';
  // final String _imgUrl='http://192.168.100.4:8000/images/';
  // final String _imgUrlPub='http://192.168.100.4:8000/publicites/';
  // final String _photoUrl='http://192.168.100.4:8000/acteurs/';
  // final String _profilUrl='http://192.168.100.4:8000/profils/';
  // final String _logoUrl='http://192.168.100.4:8000/logos/';
  // final String _filmUrl='https://192.168.100.4:8000/films/';
  // final String _episodeUrl='http://192.168.100.4:8000/episodes/';

  getProfil() => _profilUrl;
  // php artisan serve --host 192.168.100.50 --port 8000

  getLogo() => _logoUrl;

  getFilm() => _filmUrl;

  getEpisode() => _episodeUrl;

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
  }

  deleteToken() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
  }
}