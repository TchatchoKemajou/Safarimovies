import "package:flutter/material.dart";
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';
import 'package:safarimovie/Api/safariapi.dart';
import 'package:safarimovie/Pages/Auth/forgetpassword.dart';
import 'package:safarimovie/Pages/Auth/register.dart';
import 'package:safarimovie/Pages/homepages.dart';
import 'package:safarimovie/Providers/userProvider.dart';

import '../../constantes.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  SafariApi safariapi = SafariApi();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: fisrtcolor,
        appBar: AppBar(
          backgroundColor: fisrtcolor,
          elevation: 0.0,
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text(
            "Connexion",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'PopBold',
                fontSize: 24
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, right: 20, top: 30),
          //height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              headerForm(),
              SizedBox(height: 30,),
              SignInForm(),
              SizedBox(height: 30,),
              footerForm(),
              SizedBox(height: 15,),
            ],
          ),
        )
    );
  }
  headerForm(){
    return Text(
      "Se connecter pour streamer en toute sécurité",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.grey,
          fontFamily: 'PopRegular'
      ),
    );
  }

  footerForm(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Vous n'avez pas encore de compte?  ",
          style: TextStyle(
              fontSize: 12,
              fontFamily: 'PopBold',
              color: Colors.blueGrey
          ),
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => Register()));
          },
          child: Text(
            "créer",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 12,
              fontFamily: 'PopBold',
              color: Colors.red,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  SignInForm() {
    final userprovider = Provider.of<UserProvider>(context,);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (e) {
              userprovider.Changeemail = e;
            },
            validator: (e) => e!.isEmpty ? "email incorrect" : null,
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
              labelText: 'Email',
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
              suffixIcon: Icon(Icons.email, color: kSecondaryColor,),
              //suffixStyle: ,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
            ),
          ),
          SizedBox(height: 20,),
          TextFormField(
            keyboardType: TextInputType.text,
            onChanged: (e){
              userprovider.Changepassword = e;
            },
            validator: (e) => e!.isEmpty ? "Mot de passe incorrect ou non valide":null,
            maxLines: 1,
            obscureText: true,
            style: TextStyle(
                color: Colors.white
            ),
            decoration: InputDecoration(
              hoverColor: Colors.white,
              // hintText: 'login',
              // hintStyle: TextStyle(
              //   color: Colors.white54,
              // ),
              labelText: 'Mot de passe',
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
              suffixIcon: Icon(Icons.lock, color: kSecondaryColor,),
              //suffixStyle: ,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
            ),
          ),
          SizedBox(height: 5,),
          InkWell(
            onTap: (){
              Navigator.push(context, new MaterialPageRoute(builder: (context) => ForgetPassword()));
            },
            child: Text(
              "Mot de passe oublié?",
              style: TextStyle(
                color: secondcolor,
                fontFamily: 'PopRegular',
                fontSize: 12
              ),
            ),
          ),
          SizedBox(height: 30,),
          Center(
            child:
            isLoading == true
            ? smallButton()
            : ElevatedButton(
              onPressed: () async{
                if(_formKey.currentState!.validate()){
                  setState(() {
                    isLoading = true;
                  });
                  await userprovider.loginToAccount();
                  print(userprovider.loginMessage);
                  if(userprovider.loginMessage == "success"){
                    setState(() {
                      isLoading = false;
                    });
                    print(userprovider.token);
                    await safariapi.setToken(userprovider.token);
                    Navigator.of(context).pop();
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => HomePages()));
                  }else{
                    setState(() {
                      isLoading = false;
                    });
                    errorMessage("error", userprovider.loginMessage);
                  }
                }
              },

              child: Text(
                "Connexion",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'PopRegular',
                ),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) => secondcolor),
                  padding: MaterialStateProperty.all(EdgeInsets.only(left: 50, right: 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        // side: BorderSide(color: Colors.red)
                      )
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }

  void errorMessage(String title, message){
    MotionToast.error(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(
        message,
        maxLines: 2,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }

  smallButton(){
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: secondcolor,
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 3.0,
        ),
      ),
    );
  }
}
