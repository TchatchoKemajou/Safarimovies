import 'package:flutter/cupertino.dart';
import 'package:safarimovie/utilitaire.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeProvider with ChangeNotifier{
  SharedPreferences? langueStorage;
  Utilitaire utilitaire = Utilitaire();
  Locale? _currentLocale;
  String _currentLocaleName = "";
  bool _doneLoading = false;

  Locale? get currentLocale => _currentLocale;
  String get currentLocaleName => _currentLocaleName;

  bool get doneLoading => _doneLoading;

  set doneLoading(bool value) {
    _doneLoading = value;
    notifyListeners();
  }

  LanguageChangeProvider(){
    loadLanguage();
  }
  changeLocaleName(String value) {
    _currentLocaleName = value;
    notifyListeners();
  }

  initPreference() async{
    if(langueStorage == null){
      langueStorage = await SharedPreferences.getInstance();
    }else{
    }
  }

  loadLanguage() async {
    await initPreference();
    this._currentLocale = langueStorage!.getString('lang') == null || langueStorage!.getString('lang') ==  "" ? new Locale("fr")  :new Locale(langueStorage!.getString('lang')!);
    this._currentLocaleName = langueStorage!.getString('langName') ?? "All";
    notifyListeners();
  }

  setLanguage(String lang, String langName) async {
    await initPreference();
    langueStorage?.setString('lang', lang);
    langueStorage?.setString('langName', langName);
    notifyListeners();
  }

  changeLocale(String _locale, String _localeName){
    this._currentLocale = new Locale(_locale);
    this._currentLocaleName = _localeName;
    notifyListeners();
    setLanguage(_locale, _localeName);
    print("apres     " + langueStorage!.getString('lang')!);
  }

}