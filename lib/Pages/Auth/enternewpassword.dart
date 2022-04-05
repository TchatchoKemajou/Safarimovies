import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';
import 'package:safarimovie/Providers/userProvider.dart';

import '../../constantes.dart';

class EnterNewPassword extends StatefulWidget {
  final String id;
  const EnterNewPassword({
    Key? key,
    required this.id
  }) : super(key: key);

  @override
  _EnterNewPasswordState createState() => _EnterNewPasswordState();
}

class _EnterNewPasswordState extends State<EnterNewPassword> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
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
      "Entrez un nouveau mot de passe pour vous connecter en toute sécurité",
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
          // TextFormField(
          //   keyboardType: TextInputType.text,
          //   //controller: passwordController,
          //   onChanged: (e){
          //     userprovider.ChangeOldpass = e;
          //   },
          //   validator: (e) => e!.isEmpty ? "Mot de passe non valide":null,
          //   maxLines: 1,
          //   obscureText: true,
          //   style: TextStyle(
          //       color: Colors.white
          //   ),
          //   decoration: InputDecoration(
          //     hoverColor: Colors.white,
          //     // hintText: 'login',
          //     // hintStyle: TextStyle(
          //     //   color: Colors.white54,
          //     // ),
          //     labelText: 'Ancien mot de passe',
          //     focusedBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(5)),
          //         borderSide: BorderSide(
          //             color: Colors.white
          //         )
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(5)),
          //         borderSide: BorderSide(
          //             color: Colors.white
          //         )
          //     ),
          //     labelStyle: TextStyle(
          //       color: Colors.white,
          //     ),
          //     isDense: true,                      // Added this
          //     contentPadding: EdgeInsets.all(10),
          //     //hintText: "login",
          //     suffixIcon: Icon(Icons.lock, color: kSecondaryColor,),
          //     //suffixStyle: ,
          //     floatingLabelBehavior: FloatingLabelBehavior.auto,
          //     border: OutlineInputBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(5))
          //     ),
          //   ),
          // ),
          // SizedBox(height: 20,),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: passwordController,
            onChanged: (e){
              userprovider.Changepassword = e;
            },
            validator: (e) => e!.isEmpty ? "Mot de passe non valide":null,
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
              labelText: 'Nouveau mot de passe',
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
            child: isLoading == true
                ? smallButton()
                : ElevatedButton(
              onPressed: () async{
                if(_formKey.currentState!.validate()){
                  setState(() {
                    isLoading = true;
                  });
                  await userprovider.updatePassword(widget.id);
                  if(userprovider.loginMessage == "success"){
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }else{
                    setState(() {
                      isLoading = false;
                    });
                    errorMessage("la vérification a échouée");
                  }
                }
              },

              child: Text(
                "Valider",
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

  // bigBotton(){
  //   return ElevatedButton(
  //     onPressed: () async{
  //       if(_formKey.currentState!.validate()){
  //         await userprovider.sendresetPassword();
  //         if(userprovider.registerMessage == "success"){
  //           Navigator.pop(context);
  //           Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  //         }
  //       }
  //     },
  //
  //     child: Text(
  //       "Valider",
  //       style: TextStyle(
  //         fontSize: 18,
  //         fontFamily: 'PopRegular',
  //       ),
  //     ),
  //     style: ButtonStyle(
  //         backgroundColor: MaterialStateProperty.resolveWith((states) => secondcolor),
  //         padding: MaterialStateProperty.all(EdgeInsets.only(left: 50, right: 50)),
  //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //             RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(5.0),
  //               // side: BorderSide(color: Colors.red)
  //             )
  //         )
  //     ),
  //   );
  // }
  smallButton(){
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: secondcolor,
      ),
      child: Center(
        child: CircularProgressIndicator(color: Colors.white,),
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
