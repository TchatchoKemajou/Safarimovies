import 'dart:convert';

import 'package:safarimovie/Api/safariapi.dart';
import 'package:http/http.dart' as http;

class UserService{
  SafariApi callapi = SafariApi();
  String registerRequest = '/register';
  String loginRequest = '/login';
  String emailRequest = '/send-email';
  String emailpasswordRequest = '/send-email-password';
  String confirmAccountRequest = '/resetpassword';
  String logoutRequest = '/logout';

  registerUser(data) async {
    var fullUrl = callapi.getUrl() + registerRequest;
    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: callapi.setHeaders()
    );
  }

  loginUser(data) async {
    var fullUrl = callapi.getUrl() + loginRequest;
    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: callapi.setHeaders()
    );
  }

  sendmailUser(data) async {
    var fullUrl = callapi.getUrl() + emailRequest + await callapi.getToken();
    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: callapi.setHeaders()
    );
  }

  sendmailToConfirmAccount(data) async {
    var fullUrl = callapi.getUrl() + emailpasswordRequest;
    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: callapi.setHeaders()
    );
  }


  resetPassword(data, String id) async {
    var fullUrl = callapi.getUrl() + confirmAccountRequest + "/$id";
    return await http.put(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: callapi.setHeaders()
    );
  }
  logout() async {
    var fullUrl = callapi.getUrl() + logoutRequest + await callapi.getToken();
    return await http.post(
        Uri.parse(fullUrl),
       //body: jsonEncode(data),
        headers: callapi.setHeaders()
    );
  }
}