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

  getAllMovies(pays, lang) async {
    var fullUrl = safariApi.getUrl() + allMoviesRequest + "/$pays/$lang";
    final String token = await safariApi.getToken();
    return http.get(
      Uri.parse(fullUrl),
      headers: safariApi.setHeadersWithToken(token)
    );
  }

  notification() async{
    var fullUrl = safariApi.getUrl() + notificationRequest;
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

  getInfosMovies(id) async{
    var fullUrl = safariApi.getUrl() + infosMoviesRequest + "/$id";
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

  findAll() async{
    var fullUrl = safariApi.getUrl() + findAllRequest;
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