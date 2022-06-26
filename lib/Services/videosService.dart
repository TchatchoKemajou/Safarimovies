import 'dart:convert';

import 'package:safarimovie/Api/safariapi.dart';
import 'package:http/http.dart' as http;

class VideosService{

  SafariApi safariApi = SafariApi();
  String allMoviesRequest = "/accueil";
  String infosMoviesRequest = "/detailpage";
  String episodeRequest = "/episodes";
  String addFavorieRequest = "/addfavoris";
  String moveFavorieRequest = "/deletefavoris";
  String favorieRequest = "/favoris";
  String isFavorieRequest = "/veriffavoris";
  String findAllRequest = "/search";
  String readNotifRequest = "/readnotification";
  String notificationRequest = "/notification";

  String notificationNonLuRequest = "/notificationnonlu";
  String checkVisibility = "/addvus";

  String saveSearchRequest = "/savesearch";


  postSearchRequest(String query) async {
    var fullUrl = safariApi.getUrl() + saveSearchRequest;
    final String token = await safariApi.getToken();
    Map<String, dynamic> data = {
      "nom": query
    };
    return http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: safariApi.setHeadersWithToken(token)
    );
  }

  postVisibility(id) async {
    var fullUrl = safariApi.getUrl() + checkVisibility + "/$id";
    final String token = await safariApi.getToken();
    return http.post(
        Uri.parse(fullUrl),
        headers: safariApi.setHeadersWithToken(token)
    );
  }

  getAllMovies(lang) async {
    var fullUrl = safariApi.getUrl() + allMoviesRequest + "/$lang";
    final String token = await safariApi.getToken();
    return http.get(
      Uri.parse(fullUrl),
      headers: safariApi.setHeadersWithToken(token)
    );
  }

  notificationNonLu() async{
    var fullUrl = safariApi.getUrl() + notificationNonLuRequest;
    final String token = await safariApi.getToken();

    return http.get(
        Uri.parse(fullUrl),
        headers: safariApi.setHeadersWithToken(token)
    );
  }

  notification(int pagination) async{
    var fullUrl = safariApi.getUrl() + notificationRequest + "?page=$pagination";
    final String token = await safariApi.getToken();

    return http.get(
        Uri.parse(fullUrl),
        headers: safariApi.setHeadersWithToken(token)
    );
  }

readNotification() async{
    var fullUrl = safariApi.getUrl() + readNotifRequest;
    final String token = await safariApi.getToken();

    return http.get(
      Uri.parse(fullUrl),
      headers: safariApi.setHeadersWithToken(token)
    );
}

  getInfosMovies(int id, String lang) async{
    var fullUrl = safariApi.getUrl() + infosMoviesRequest + "/$id/$lang";
    final String token = await safariApi.getToken();
    return http.get(
      Uri.parse(fullUrl),
      headers: safariApi.setHeadersWithToken(token)
    );
  }

  getEpisode(id) async{
    var fullUrl = safariApi.getUrl() + episodeRequest + "/$id";
    final String token = await safariApi.getToken();
    return http.get(
        Uri.parse(fullUrl),
        headers: safariApi.setHeadersWithToken(token)
    );
  }

  postFavorie(id) async{
    var fullurl = safariApi.getUrl() + addFavorieRequest + "/$id";
    final String token = await safariApi.getToken();
    return http.post(
      Uri.parse(fullurl),
      headers: safariApi.setHeadersWithToken(token)
    );
  }
  findAll(int pagination, String lang) async{
    var fullUrl = safariApi.getUrl() + findAllRequest + "/$lang/" + "?page=$pagination";
    final String token = await safariApi.getToken();
    return http.get(
        Uri.parse(fullUrl),
        headers: safariApi.setHeadersWithToken(token)
    );
  }

  findAllResult(String query, String lang) async{
    var fullUrl = safariApi.getUrl() + findAllRequest + "/$lang" + "/$query";
    final String token = await safariApi.getToken();
    return http.get(
      Uri.parse(fullUrl),
      headers: safariApi.setHeadersWithToken(token)
    );
  }

  moveFavorie(id) async{
    var fullurl = safariApi.getUrl() + moveFavorieRequest + "/$id";
    final String token = await safariApi.getToken();
    return http.delete(
        Uri.parse(fullurl),
        headers: safariApi.setHeadersWithToken(token)
    );
  }

  allFavorie() async{
    var fullurl = safariApi.getUrl() + favorieRequest;
    final String token = await safariApi.getToken();
    return http.get(
      Uri.parse(fullurl),
      headers: safariApi.setHeadersWithToken(token)
    );
  }

  verifyIsFavorie(id) async{
    var fullurl = safariApi.getUrl() + isFavorieRequest + "/$id";
    final String token = await safariApi.getToken();
    return http.get(
        Uri.parse(fullurl),
        headers: safariApi.setHeadersWithToken(token)
    );
  }

}