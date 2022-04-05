import 'dart:convert';

import 'package:safarimovie/Api/safariapi.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class UserService{
  SafariApi callapi = SafariApi();
  String registerRequest = '/register';
  String loginRequest = '/login';
  String emailRequest = '/send-email';
  String emailpasswordRequest = '/send-email-password';
  String confirmAccountRequest = '/resetpassword';
  String logoutRequest = '/logout';
  String userRequest = '/user';
  String updateProfilRequest = '/updateuser';
  String changePasswordRequest = '/updatepassword';
  String changeNameRequest = '/updatename';

  registerUser(data) async {
    var fullUrl = callapi.getUrl() + registerRequest;
    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: callapi.setHeaders()
    );
  }

  Future<Map<dynamic, dynamic>>getinfosuser() async{
    var res = await getUser();
    var body = json.decode(res.body);
    print(body[0]);
    return body[0];
  }


  getUser() async{
    var fullUrl = callapi.getUrl() + userRequest;
    final String token = await callapi.getToken();
    return await http.get(
      Uri.parse(fullUrl),
      headers: callapi.setHeadersWithToken(token)
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

  changePassword(data, id) async {
    var fullurl = callapi.getUrl() + changePasswordRequest + "/$id";
    final String token = await callapi.getToken();
    return await http.put(
      Uri.parse(fullurl),
      body: jsonEncode(data),
      headers: callapi.setHeadersWithToken(token)
    );
  }

  changeName(data, id) async{
    var fullurl = callapi.getUrl() + changeNameRequest + "/$id";
    final String token = await callapi .getToken();

    return await http.put(
      Uri.parse(fullurl),
      body: jsonEncode(data),
      headers: callapi.setHeadersWithToken(token)
    );
  }

  sendmailUser(data) async {
    var fullUrl = callapi.getUrl() + emailRequest;
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




  resetPassword(data, id) async {
    var fullUrl = callapi.getUrl() + confirmAccountRequest + "/$id";
    return await http.put(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: callapi.setHeaders()
    );
  }
  logout() async {
    var fullUrl = callapi.getUrl() + logoutRequest;
    final String token = await callapi .getToken();
    return await http.post(
        Uri.parse(fullUrl),
       //body: jsonEncode(data),
        headers: callapi.setHeadersWithToken(token)
    );
  }
}