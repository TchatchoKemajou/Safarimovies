import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';
import 'package:safarimovie/Models/Users.dart';
import 'package:safarimovie/Pages/Auth/otpscreen.dart';
import 'package:safarimovie/Providers/userProvider.dart';

import '../../constantes.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  String email = "";

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
            "Mot de passe oublié",
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
              forgetPasswordForm(),
              SizedBox(height: 30,),
            ],
          ),
        )
    );
  }
  headerForm(){
    return Text(
      "Un code de vérifacation sera envoyé à cette addresse pour verifier votre identité",
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
        InkWell(
          onTap: () {
            //Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => Register()));
          },
          child: Text(
            "Se connecter",
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

  forgetPasswordForm() {
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
            validator: (e) => e!.isEmpty ? "Ce champ est obligatoire" : null,
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
          Center(
            child: ElevatedButton(
              onPressed: () async{
                if(_formKey.currentState!.validate()){
                  await userprovider.sendmailToUserPassword();
                  if(userprovider.emailMessage == "error"){
                    String message = "email n'exsiste pas";
                    errorMessage(message);
                  }else{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(user: userprovider.tomapregister(), otp: userprovider.code, action: "changepassword",)));
                  }
                }
               // Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(user: userprovider.tomapregister(), otp: userprovider.code, action: "changepassword",)));
              },

              child: Text(
                "Envoyer",
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
