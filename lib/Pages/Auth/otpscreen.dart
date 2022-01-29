import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:safarimovie/Pages/Auth/changepassword.dart';
import 'package:safarimovie/Pages/homepages.dart';
import 'package:safarimovie/Providers/userProvider.dart';

import '../../constantes.dart';

class OtpScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  final String otp;
  final String action;
  const OtpScreen({Key? key, required this.user, required this.otp, required this.action}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  //String otpvalue = "";
  bool iscorrect = false, isValide = false;
  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context,);
    return Scaffold(
      backgroundColor: fisrtcolor,
      appBar: AppBar(
        backgroundColor: fisrtcolor,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        title: Text(
          "Verification de numéro",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'PopBold',
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Un code à été envoyé à l'adresse email  " + widget.user["email"] + "  entrer le code de confirmation",
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'PopBold',
                  color: Colors.white
              ),
              //maxLines: 2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50,),
            iscorrect == false ? Text("") :Text(
              "code incorrect",
              style: TextStyle(
                color: secondcolor,
              ),
            ),
            PinCodeTextField(
              appContext: context,
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.circle,
                //borderRadius: BorderRadius.circular(5),
                fieldHeight: 40,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                inactiveColor: Colors.grey,
                inactiveFillColor: Colors.grey,
                activeColor: Colors.white,
                selectedColor: Colors.blueGrey,
                selectedFillColor: Colors.blueGrey
              ),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: fisrtcolor,
              enableActiveFill: true,
              //errorAnimationController: errorController,
              //controller: textEditingController,
              onCompleted: (value) async{
                if(value == widget.otp){
                  setState(() {
                    isValide = true;
                  });
                  if(widget.action == "register"){
                    await userprovider.createAccount();
                    print(userprovider.registerMessage);
                    if(userprovider.registerMessage == "success"){
                      userprovider.loginToAccount();
                      print(userprovider.loginMessage);
                      if(userprovider.loginMessage == "success"){
                        setState(() {
                          isValide = false;
                        });
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.push(context, new MaterialPageRoute(builder: (context) => HomePages()));
                      }
                    }
                  }else{
                    setState(() {
                      isValide = false;
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassWord()));
                  }
                }else{
                  setState(() {
                    iscorrect = true;
                  });
                }
              },
              onChanged: (value) {
                // print(value);
                // setState(() {
                //   otpvalue = value;
                // });
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                return true;
              },
            ),
            SizedBox(height: 30,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isValide == true ? smallButton() :ElevatedButton(
                  onPressed: () async{
                    // if(otpvalue == widget.otp){
                    //   if(widget.action == "register"){
                    //     await userprovider.createAccount();
                    //     print(userprovider.registerMessage);
                    //     if(userprovider.registerMessage == "success"){
                    //       userprovider.loginToAccount();
                    //       print(userprovider.loginMessage);
                    //       if(userprovider.loginMessage == "success"){
                    //         Navigator.of(context).pop();
                    //         Navigator.of(context).pop();
                    //         Navigator.push(context, new MaterialPageRoute(builder: (context) => HomePages()));
                    //       }
                    //     }
                    //   }else{
                    //
                    //   }
                    // }else{
                    //   setState(() {
                    //     iscorrect = true;
                    //   });
                    // }
                    // bool isvalide = validateOtp(code);
                    // await userprovider.validatePin();
                    // if(userprovider.pinMessage == "success"){
                    //   Navigator.of(context).pop();
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (_) => Register(phone: widget.phoneasVerified, prefix: widget.prefix,)),
                    //   );
                    // }else{
                    //   //Toast.show("code incorrect!" , context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP);
                    // }
                  },
                  child: Text(
                    "Valider",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'PopBold',
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((states) => secondcolor),
                      padding: MaterialStateProperty.all(EdgeInsets.only(left: 50, right: 50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            // side: BorderSide(color: Colors.red)
                          )
                      )
                  ),
                ),
                InkWell(
                  onTap: (){
                    // Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(builder: (_) => PhoneAuth()),
                    // );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Vous n'avez pas reçu?  ",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontFamily: 'PopBold',
                            fontSize: 12
                        ),
                      ),
                      InkWell(
                        onTap: () {
                         // Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          "Renvoyer",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 13,
                            fontFamily: 'PopBold',
                            color: Colors.red,
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  smallButton(){
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: secondcolor
      ),
      child: Center(
        child: CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
