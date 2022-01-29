import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safarimovie/Pages/Auth/login.dart';
import 'package:safarimovie/Providers/userProvider.dart';
import 'package:safarimovie/constantes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fisrtcolor,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            avatar(),
            name(),
          ],
        ),
      ),
    );
  }
  appBar() {
    return AppBar(
      elevation: .0,
      title: Text(
        'Mon profil',
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontFamily: 'RoboItalic',
        ),
      ),
      //centerTitle: true,
      backgroundColor: fisrtcolor,
    );
  }

  avatar() {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                image: DecorationImage(
                    image: AssetImage("assets/images/person3.jpg"),
                    fit: BoxFit.cover)),
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
                  onPressed: () {},
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  name() {
    UserProvider userprovider = Provider.of<UserProvider>(context, listen: false);
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        Text(
          "Eken Franky",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'PopBold',
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          "ekenfranky@gmail.com",
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
                          Icons.person_outline,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "Compte",
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
                userprovider.logAccountUser();
                if(userprovider.loginMessage == "success"){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                }
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
    );
  }
}
