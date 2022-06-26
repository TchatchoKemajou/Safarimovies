import 'dart:math';

import 'package:flutter/material.dart';
import 'package:safarimovie/Api/safariapi.dart';
import 'package:safarimovie/Services/userServeice.dart';
import 'dart:convert';

class UserProvider with ChangeNotifier{
  UserService userService = UserService();
  String? _registerMessage;
  String? _token;
  String? _loginMessage;
  String? _emailMessage;
  String _id = "";
  String _name= "";
  String _email= "";
  String _avatar= "";
  String _password= "";
  String _type= "";
  String? _code;
  String _oldpass = "";

  String get oldpass => _oldpass;

  set ChangeOldpass(String value) {
    _oldpass = value;
    notifyListeners();
  }

  Map<dynamic, dynamic> _user = {
    "id": "",
    "name": "",
    "email": "",
    "avatar": "",
    "type": "",
  };

  Map<dynamic, dynamic> get user => _user;

  set ChangeUser(Map<dynamic, dynamic> value) {
    _user = value;
    notifyListeners();
  }

  String get avatar => _avatar;

  set ChangeAvatar(String value) {
    _avatar = value;
    notifyListeners();
  }

  String get code => _code!;

  set Changecode(String value) {
    _code = value;
    notifyListeners();
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get registerMessage => _registerMessage!;
  String get emailMessage => _emailMessage!;
  String get loginMessage => _loginMessage!;
  String get token => _token!;

  String get name => _name;

  String get type => _type;

  String get email => _email;

  String get password => _password;

  set Changetype(String value) {
    _type = value;
    notifyListeners();
  }


  set Changepassword(String value) {
    _password = value;
    notifyListeners();
  }


  set Changeemail(String value) {
    _email = value;
    notifyListeners();
  }

  set Changename(String value) {
    _name = value;
    notifyListeners();
  }
  Map<String, dynamic> tomapregister(){
    return {
      "id": _id,
      "name": _name,
      "email": _email,
      "password": _password,
      "password_confirmation": _password
    };
  }

  Map<String, dynamic> tomaplogin(){
    return {
      "email": _email,
      "password": _password,
    };
  }

  Map<String, dynamic> tomapreset(){
    return {
      "password": _password,
      "password_confirmation": _password
    };
  }

  Map<String, dynamic> tomappass(){
    return {
      "password": _password
    };
  }
  Map<String, dynamic> tomapChangeName(name){
    return {
      "name": name
    };
  }
  Map<String, dynamic> tomapChangePass(){
    print(_oldpass + "  et " + _password);
    return {
      "oldpassword": _oldpass,
      "newpassword": _password
    };
  }

  Map<String, dynamic> tomapsendMail(){
    return {
      "email": _email,
      "code": _code,
      "name": _name,
      "password": _password,
      "password_confirmation": _password
    };
  }

  updatePassword(id) async{
    var res = await userService.changePassword(tomapChangePass(), id);
    var body = json.decode(res.body);
    _loginMessage = body['message'];
    notifyListeners();
  }

  updateName(id, name) async{
    var res = await userService.changeName(tomapChangeName(name), id);
    var body = json.decode(res.body);
    print(body);
    _loginMessage = body['message'];
    print(_loginMessage);
    print(body['name']);
    notifyListeners();
  }

  loadUser(dynamic user){
    _id = user["id"].toString();
    _name = user["name"] == null ? "" : user["name"];
    _email = user["email"] == null ? "" : user["email"];
    _avatar = user["avatar"] == null ? "" : user["avatar"];
    _type = user["type"].toString();
    notifyListeners();
  }

  Future<dynamic>getinfosuser() async{
    var res = await userService.getUser();
    var body = json.decode(res.body);
    print(body[0]);
    return body[0];
    //_user = body[0];
    //loadUser(body[0]);
    //notifyListeners();
  }

  loginToAccount() async{
    var res = await userService.loginUser(tomaplogin());
    var body = json.decode(res.body);
    if(body["message"] == "success"){
      _loginMessage = "success";
      var tk = body["access_token"]["token"];
      _token = tk.toString();
      notifyListeners();
    }else{
      print(body);

      if(body["message"] == null){
        _loginMessage = "Entrer un mot de passe supérieur à 8 caractère";
        notifyListeners();
      }

      if(body["message"] == "User does not exist"){
        _loginMessage = "Votre adresse est incorrecte";
        notifyListeners();
      }

      if(body["message"] == "Password mismatch"){
        _loginMessage = "Votre mot de passe est incorrect";
        notifyListeners();
      }
    }
    //_loginMessage = body["message"];
    //notifyListeners();
  }

  createAccount() async{
    print(tomapregister());
    var res = await userService.registerUser(tomapregister());
    var body = json.decode(res.body);
    print(body["message"]);
    _registerMessage = body["message"];
    notifyListeners();
  }

  String generateOtp(){
    var rand = new Random();
    int digit = rand.nextInt(889799)+110200;
    return digit.toString();
  }


  sendmailToUser() async{
    Changecode = generateOtp();
    var res = await userService.sendmailUser(tomapsendMail());
    var body = json.decode(res.body);
    if(body["message"] == "Mail send"){
      _emailMessage = "success";
      notifyListeners();
    }else{
      print(body);

      if(body["errors"][0] == "The email must be a valid email address."){
        _emailMessage = "votre addresse n'est pas valide";
        notifyListeners();
      }

      if(body["errors"][0] == "The email has already been taken."){
        _emailMessage = "Cette adresse existe déja";
        notifyListeners();
      }
      //
      // if(body["message"] == "Password mismatch"){
      //   _loginMessage = "Votre mot de passe est incorrect";
      //   notifyListeners();
      // }
    }
  }

  sendmailToUserPassword() async{
    Changecode = generateOtp();
    print(tomapsendMail());
    var res = await userService.sendmailToConfirmAccount(tomapsendMail());
    var body = json.decode(res.body);
    //print(body);
   //_emailMessage = "success";
   //  notifyListeners();
   //  loadUser(body);
    if(body["message"] != null){
      _emailMessage = "error";
      notifyListeners();
    }
    else{
      _emailMessage = "success";
      notifyListeners();
      loadUser(body);
      //print(id + name);
    }
  }

  sendresetPassword() async{
    var res = await userService.resetPassword(tomapreset(), id);
    var body = json.decode(res.body);
    print(res);
    print(body);
    if(body["errors"] != null){
      _registerMessage = "error";
      notifyListeners();
    }else{
      _registerMessage = "success";
      notifyListeners();
    }
  }

  logAccountUser() async{
    var res = await userService.logout();
    var body = json.decode(res.body);
    print(body);
    if(body == "success"){
      SafariApi().deleteToken();
      _loginMessage = "success";
      notifyListeners();
    }
  }
}