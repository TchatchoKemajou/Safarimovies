import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:safarimovie/Services/videosService.dart';

class VideosProviders with ChangeNotifier{
  VideosService videosService = VideosService();


  int? _videoCreatorId;
  String? _videoTitle;
  String? _videoContent;
  String? _videoImages;
  String? _videoRubrique;
  String? _videoDateOut;
  String? _videoDuration;
  String? _videoPub;
  String? _videoBannier;
  String? _videoAge;
  String? _videoQuality;
  String? _videoDescription;
  String? _videoLangue;
  dynamic _movies;
  late bool _similaire = true;
  String _isfavori = "faux";
  String? _ifAddorRetrive;
  List<String>? _saison;

  String get ifAddorRetrive => _ifAddorRetrive!;

  set ChangeifAddorRetrive(String value) {
    _ifAddorRetrive = value;
    notifyListeners();
  }

  List<String> get saison => _saison!;

  set saison(List<String> value) {
    _saison = value;
  }


  dynamic get movies => _movies;

  set Changemovies(dynamic value) {
    _movies = value;
    notifyListeners();
  }

  String get isfavori => _isfavori;

  set Changeisfavori(String value) {
    _isfavori = value;
    notifyListeners();
  }

  bool get similaire => _similaire;

  set ChangeSimilaire(bool value) {
    _similaire = value;
    notifyListeners();
  }

  String get videoLangue => _videoLangue!;

  set videoLangue(String value) {
    _videoLangue = value;
    notifyListeners();
  }

  int get videoCreatorId => _videoCreatorId!;

  set videoCreatorId(int value) {
    _videoCreatorId = value;
  }

  String get videoTitle => _videoTitle!;

  set changeVideoTitle(String value) {
    _videoTitle = value;
    notifyListeners();
  }

  String get videoContent => _videoContent!;

  set changeVideoContent(String value) {
    _videoContent = value;
    notifyListeners();
  }

  String get videoDescription => _videoDescription!;

  set changeVideoDescription(String value) {
    _videoDescription = value;
    notifyListeners();
  }

  String get videoQuality => _videoQuality!;

  set changeVideoQuality(String value) {
    _videoQuality = value;
    notifyListeners();
  }

  String get videoAge => _videoAge!;

  set changeVideoAge(String value) {
    _videoAge = value;
    notifyListeners();
  }

  String get videoBannier => _videoBannier!;

  set changeVideoBannier(String value) {
    _videoBannier = value;
    notifyListeners();
  }

  String get videoPub => _videoPub!;

  set changeVideoPub(String value) {
    _videoPub = value;
    notifyListeners();
  }

  String get videoDuration => _videoDuration!;

  set changeVideoDuration(String value) {
    _videoDuration = value;
    notifyListeners();
  }

  String get videoDateOut => _videoDateOut!;

  set changeVideoDateOut(String value) {
    _videoDateOut = value;
    notifyListeners();
  }

  String get videoRubrique => _videoRubrique!;

  set changeVideoRubrique(String value) {
    _videoRubrique = value;
    notifyListeners();
  }

  String get videoImages => _videoImages!;

  set changeVideoImages(String value) {
    _videoImages = value;
    notifyListeners();
  }


  readNotification() async{
    var res = await videosService.readNotification();
    var body = json.decode(res.body);
    print(body);
  }

  postSearchRequest(String query) async{
    await videosService.postSearchRequest(query);
    // var body = json.decode(res.body);
    // print(body);
  }

  Future<List<dynamic>> selectAllVideo(int pagination, String lang) async{
    final res = await videosService.findAll(pagination, lang);
    var body = json.decode(res.body);
    return body['data'];
  }


  Future<List<dynamic>> selectAllResult(String query, String lang) async{
    final res = await videosService.findAllResult(query, lang);
    var body = json.decode(res.body);
    print(body);
    return body;
  }

Future<List<dynamic>> getAllFavoris() async{
    final res = await videosService.allFavorie();
    //var body = json.decode(res.body);
    return json.decode(res.body);
}

  // Future<List<dynamic>> allSaisons(id) async{
  //   final res = await videosService.getInfosMovies(_videoCreatorId!);
  //   return json.decode(res.body)[3];
  // }

  addToFavorie(id) async{
    final res = await videosService.postFavorie(id);
    var body = json.decode(res.body);
    print(body["message"]);
    if(body["message"] == "success"){
      _ifAddorRetrive = "success";
      notifyListeners();
    }else{
      _ifAddorRetrive = "null";
      notifyListeners();
    }
  }

  deleteToFavorie(id) async{
    final res = await videosService.moveFavorie(id);
    var body = json.decode(res.body);
    print(body["message"]);
    if(body["message"] == "success"){
      _ifAddorRetrive = "success";
      notifyListeners();
    }else{
      _ifAddorRetrive = "null";
      notifyListeners();
    }
  }

  Future<List<dynamic>> allNotificationNonLu() async{
    final res = await videosService.notificationNonLu();
     return json.decode(res.body);
  }

  Future<List<dynamic>> allNotifications(int pagination) async{
    final res = await videosService.notification(pagination);
    return json.decode(res.body);
  }

  verifyFavori() async{
    final res = await videosService.verifyIsFavorie(_videoCreatorId!);
    _isfavori = json.decode(res.body);
    print(_isfavori);
    notifyListeners();
  }

  postVideoVue(int id) async{
    await videosService.postVisibility(id);
  }

  Future<List<dynamic>> infosMovies(String lang) async{
    final res = await videosService.getInfosMovies(_videoCreatorId!, lang);
    return json.decode(res.body);
  }

  Future<List<dynamic>> episodes(int i) async{
    // int id = (_videoCreatorId as int);
    final res = await videosService.getEpisode(i);
    return json.decode(res.body);
  }

  Future<List<dynamic>> allMovies(String lang) async{
    final res = await videosService.getAllMovies(lang);
    //print(json.decode(res.body));
    return json.decode(res.body);
  }


  loadFilm(Map<dynamic, dynamic> item){
    _videoCreatorId = item["creator_id"];
    _videoTitle = item["titre"];
    _videoContent = item["video"];
    _videoImages = item["image"];
    _videoRubrique = item["rubrique"];
    _videoDateOut = item["date_de_sortie"];
    _videoDuration = item["duree"];
    _videoPub = item["pub"];
    _videoBannier = item["banniere"].toString();
    _videoAge = item["age"];
    _videoQuality = item["qualite"];
    _videoLangue = item["langue"];
    _videoDescription = item["description"];
    notifyListeners();
  }

  returnFilm(item){
    return {
      "creator_id" : item["id"],
      "titre" : item["titre"],
      "video" : item["video"],
      "image" : item["image"],
      "rubrique" : item["rubrique"],
      "date_de_sortie" : item["date_de_sortie"],
      "duree" : item["duree"],
      "pub" : item["pub"],
      "banniere" : item["banniere"],
      "age": item["age"],
      "qualite" : item["qualite"],
      "langue" : item["langue"],
      "description" : item["description"]
    };
  }

  // Future<List<dynamic>> allSeries() async{
  //   final res = await videosService.getAllMovies();
  // }
}