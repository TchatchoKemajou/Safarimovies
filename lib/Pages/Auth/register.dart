import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';
import 'package:safarimovie/Pages/Auth/otpscreen.dart';
import 'package:safarimovie/Providers/userProvider.dart';

import '../../constantes.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  bool isLoading = false;
  String? email;
  String? password;
 // String? conform_password;
  bool remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
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
          "Creation de Compte",
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
            signUpForm(),
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
        Text(
          "Vous avez déja un compte?  ",
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
            Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => Login()));
          },
          child: Text(
            "Connexion",
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

  signUpForm() {
    final userprovider = Provider.of<UserProvider>(context,);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            onChanged: (e) {
              userprovider.Changename = e;
            },
            validator: (e) => e!.isEmpty || e.length > 16 ? "votre nom d'utilisateur doit être compris entre 1 et 16 caractères" : null,
            controller: usernameController,
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
              labelText: 'Username',
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
          SizedBox(height: 20,),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: mailController,
            validator: (e) => e!.isEmpty ? " adresse mail obligatoire":null,
            onChanged: (e){
              userprovider.Changeemail = e;
            },
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
              labelText: 'E-mail',
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
            controller: passwordController,
            onChanged: (e){
              userprovider.Changepassword = e;
            },
            validator: (e) => e!.isEmpty || e.length < 8 ? "Mot de passe non valide":null,
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
          SizedBox(height: 20,),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: confirmpasswordController,
            validator: (e) => e!.isEmpty || e != passwordController.text ? " confirmation non valide":null,
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
              labelText: 'Confirmer',
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
                  await userprovider.sendmailToUser();
                  if(userprovider.emailMessage == "success"){
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => OtpScreen(user: userprovider.tomapregister(), otp: userprovider.code, action: "register",)));
                  }else{
                    setState(() {
                      isLoading = false;
                    });
                    errorMessage("error", userprovider.emailMessage);
                  }
                }
              },
              child: Text(
                "Continuer",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'PopRegular',
                ),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) => secondcolor),
                  padding: MaterialStateProperty.all(EdgeInsets.only(left: 50, right: 50, top: 5, bottom: 5)),
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
