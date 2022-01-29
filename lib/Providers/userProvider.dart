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

  Map<String, dynamic> tomapsendMail(){
    return {
      "email": _email,
      "code": _code
    };
  }

  loadUser(Users user){
    _id = user.userId;
    _name = user.userName;
    _email = user.userMail;
    _password = user.userPassword;
    _type = user.userType;
  }

  loginToAccount() async{
    var res = await userService.loginUser(tomaplogin());
    var body = json.decode(res.body);
    if(body == "Password mismatch"){
      _loginMessage = "Email ou Mot de passe incorrect";
    }
    if(body == "User does not exist"){
      _loginMessage = "Identifiant non valide";
    }
    else{
      _loginMessage = "success";
    }
    //_loginMessage = body["message"];
    notifyListeners();
    var tk = body["token"];
    _token = tk.toString();
    print(body["user"]["name"]);
    print(body["user"]["email"]);
    //notifyListeners();
  }

  createAccount() async{
    var res = await userService.registerUser(tomapregister());
    var body = json.decode(res.body);
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
    var res = await userService.sendmailToConfirmAccount(tomapsendMail());
    var body = json.decode(res);
    if(body["message"]){
      _emailMessage = "error";
      notifyListeners();
    }
    else{
      Users user = Users.fromjson(body);
      loadUser(user);
      _emailMessage = "success";
      notifyListeners();
    }
  }

  sendresetPassword() async{
    var res = await userService.resetPassword(tomaplogin(), id);
    var body = json.decode(res);
    if(body["user"]){
      _registerMessage = "success";
    }else{
      _registerMessage = "error";
    }
  }

  logAccountUser() async{
    var res = await userService.logout();
    var body = json.decode(res);
    if(body == "You have been successfully logged out!"){
      SafariApi().deleteToken();
      _loginMessage = "success";
    }
  }
}