import 'dart:math';

import 'package:flutter/material.dart';
import 'package:safarimovie/Api/safariapi.dart';
import 'package:safarimovie/Models/Users.dart';
import 'package:safarimovie/Services/userServeice.dart';
import 'dart:convert';

class UserProvider with ChangeNotifier{
  UserService userService = UserService();
  String? _registerMessage;
  String? _token;
  String? _loginMessage;
  String? _emailMessage;
  String? _id;
  String? _name;
  String? _email;
  String? _password;
  String? _type;
  String? _code;

  String get code => _code!;

  set Changecode(String value) {
    _code = value;
    notifyListeners();
  }

  String get id => _id!;

  set id(String value) {
    _id = value;
  }

  String get registerMessage => _registerMessage!;
  String get emailMessage => _emailMessage!;
  String get loginMessage => _loginMessage!;
  String get token => _token!;

  String get name => _name!;

  String get type => _type!;

  String get email => _email!;

  String get password => _password!;

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

  Map<String, dynamic> tomapsendMail(){
    return {
      "email": _email,
      "code": _code
    };
  }

  loadUser(dynamic user){
    _id = user["id"].toString();
    _name = user["name"];
    _email = user["email"];
    _type = user["type"].toString();
    notifyListeners();
  }

  loginToAccount() async{
    var res = await userService.loginUser(tomaplogin());
    var body = json.decode(res.body);
    // if(body == "Password mismatch"){
    //   _loginMessage = "Email ou Mot de passe incorrect";
    // }
    // if(body == "User does not exist"){
    //   _loginMessage = "Identifiant non valide";
    // }
    // else{
    //   _loginMessage = "success";
    // }
    if(body["message"] == "success"){
      _loginMessage = "success";
      var tk = body["access_token"]["token"];
      print(tk);
      _token = tk.toString();
      notifyListeners();
      print(body["user"]["name"]);
      print(body["user"]["email"]);
    }else{
      _loginMessage = "Email ou Mot de passe incorrect";
      notifyListeners();
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
    _emailMessage = body["message"];
    notifyListeners();
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
    }else{
      _registerMessage = "success";
    }
  }

  logAccountUser() async{
    var res = await userService.logout();
    var body = json.decode(res.body);
    if(body == "You have been successfully logged out!"){
      SafariApi().deleteToken();
      _loginMessage = "success";
    }
  }
}