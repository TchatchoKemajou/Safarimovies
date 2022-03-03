import 'package:safarimovie/Api/safariapi.dart';
import 'package:http/http.dart' as http;

class VideosService{

  SafariApi safariApi = SafariApi();
  String allMoviesRequest = "/accueil";
  String infosMoviesRequest = "/detailpage";
  String episodeRequest = "/episodes";
  String addFavorieRequest = "/addfavoris";

  getAllMovies() async {
    var fullUrl = safariApi.getUrl() + allMoviesRequest;
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


}