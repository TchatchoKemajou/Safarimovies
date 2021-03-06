import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';
import 'package:safarimovie/Api/safariapi.dart';
import 'package:safarimovie/Pages/Auth/changepassword.dart';
import 'package:safarimovie/Pages/Auth/login.dart';
import 'package:safarimovie/Providers/userProvider.dart';
import 'package:safarimovie/Services/userServeice.dart';
import 'package:safarimovie/constantes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

import '../Providers/LanguageChangeProvider.dart';

class ProfilePage extends StatefulWidget {
  //final Map<dynamic, dynamic> user;
  const ProfilePage({
    Key? key,
   // required this.user
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker picker = ImagePicker();
  bool ischange = false;
  bool modifying = false;
  bool isLoading = false;
  late Timer time;
  XFile? image;
  String name = "";
  //late final  PickedFile file;
  //late final File image;
  Map<dynamic, dynamic> user = {};
  SafariApi safariApi = SafariApi();
  UserService userservice = UserService();
  List<String> langues = ["Français", "Anglais"];
  String currentlanguage = "Français";

  Future<void> getuser() async {
    final Map<dynamic, dynamic> u = await userservice.getinfosuser();
    setState((){
      user = u;
    });
    print("user: $user");
  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser();
  }

  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context);
    userprovider.loadUser(user);
    final langueProvider = Provider.of<LanguageChangeProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: fisrtcolor,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Stack(
              children: [
                isLoading == true ? CircularProgressIndicator(color: secondcolor,) : CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  backgroundImage: userprovider.avatar == null || userprovider.avatar == "" || userprovider.avatar == "null" ? NetworkImage(safariApi.getLogo() + "logomobilenoir.png") : NetworkImage(safariApi.getProfil() + userprovider.avatar),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: fisrtcolor, borderRadius: BorderRadius.circular(25.0)),
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        onPressed: () async{
                          // setState(() {
                          //   isLoading = true;
                          // });
                          var imagepicker = await picker.pickImage(source: ImageSource.gallery);
                          if(imagepicker != null){
                            setState(() {
                              image = imagepicker;
                             // user['avatar'] = image!.path.split("/").last;
                              isLoading = true;
                            });

                            try{
                              String filename = image!.path.split("/").last;
                              final String token = await safariApi.getToken();
                              var postUri = Uri.parse(safariApi.getUrl() + '/updateuser');
                              var request = new http.MultipartRequest("POST", postUri)
                                ..headers.addAll(safariApi.setHeadersFormdata(token))
                                ..files.add(await http.MultipartFile.fromPath('avatar', image!.path , filename: filename, contentType: MediaType('application', 'x-tar')));
                              request.send().then((response) {
                                response.stream.transform(utf8.decoder).listen((value) {
                                  print(value);
                                  getuser();
                                  setState(() {
                                    isLoading = false;
                                    userprovider.loadUser(user);
                                    image = null;
                                  });
                                });
                              });
                            }catch(e){
                              print(e);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child:
                  modifying == false
                  ? Text(
                    userprovider.name != null ? userprovider.name : "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'PopBold',
                    ),
                  )
                  : Container(
                    margin: EdgeInsets.only(top: 5),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (e) {
                        setState(() {
                          name = e;
                        });
                      },
                      validator: (e) => e!.isEmpty ? " incorrect" : null,
                     // controller: usernameController,
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.white
                      ),
                      decoration: InputDecoration(
                        hoverColor: Colors.white,
                        // hintText: 'login',
                        // hintStyle: TextStyle(
                        //   color: Colors.white54,
                        // ),
                        //labelText: 'Username',
                        //hintText: userprovider.name,
                        hintStyle: TextStyle(
                          color: Colors.white
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        isDense: true,                      // Added this
                        contentPadding: EdgeInsets.all(10),
                        //hintText: "login",
                        suffixIcon: Icon(Icons.person, color: kSecondaryColor,),
                        //suffixStyle: ,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child:
                      modifying == false
                      ? InkWell(
                        onTap: () {
                          setState(() {
                            modifying = true;
                          });
                        },
                          child: Icon(Icons.edit, color: Colors.white,)
                      )
                      : Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: InkWell(
                            onTap: () async{
                              print("je me nomme" + name);
                              await userprovider.updateName(userprovider.id, name);
                              if(userprovider.loginMessage == "success"){
                                setState(() async {
                                  getuser();
                                  modifying = false;
                                });
                              }else{
                                setState(() {
                                  modifying = false;
                                });
                                errorMessage("échec de mise à jour");
                              }
                            },
                            child: Icon(Icons.check, color: Colors.white,)
                        ),
                      )
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              userprovider.email != null ? userprovider.email : "",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontFamily: 'PopBold',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "Parametres de l'application",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'PopRegular',
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassWord(id: userprovider.id,)));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                "Changer le mot de passe",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'PopRegular',
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.help_outline_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "Aide",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'PopRegular',
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                InkWell(
                  onTap: () async{
                    //await safariApi.deleteToken();
                    // await userprovider.logAccountUser();
                    // if(userprovider.loginMessage == "success"){
                    //   print(userprovider.loginMessage);
                    //   await safariApi.deleteToken();
                    //   Navigator.pop(context);
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                    // }
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      await userprovider.logAccountUser();
                  },
                  child: Text(
                    "Se deconnecter",
                    style: TextStyle(
                      color: secondcolor,
                      fontSize: 15,
                      fontFamily: 'PopBold',
                    ),
                  ),
                ),
                SizedBox(height: 12,),
                Text(
                  "Copyright by Codex SARL",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontFamily: 'PopBold'
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
  appBar() {
    return AppBar(
      elevation: .0,
      title: Image.asset(
        "assets/images/logo.png",
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.5,
      ),
      //centerTitle: true,
      backgroundColor: fisrtcolor,
    );
  }

  void errorMessage(String message){
    MotionToast.error(
      title: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Please enter your name'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
}
