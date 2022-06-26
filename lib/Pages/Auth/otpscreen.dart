import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:safarimovie/Api/safariapi.dart';
import 'package:safarimovie/Pages/Auth/changepassword.dart';
import 'package:safarimovie/Pages/Auth/enternewpassword.dart';
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
  SafariApi safariapi = SafariApi();
  String otpvalue = "";
  String sendOtp = "";
  bool iscorrect = false, isValide = false;
  bool isLoading = false;

  addOtp(){
    setState(() {
      sendOtp = widget.otp;
    });
  }

  @override
  void initState(){
    super.initState();
    addOtp();
  }

  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context,);
    print(widget.otp);
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
                color: Colors.red,
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
              },
              onChanged: (value) {
                print(value);
                setState(() {
                  otpvalue = value;
                });
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
                isLoading == true ? smallButton() :ElevatedButton(
                  onPressed: () async{
                    setState(() {
                      iscorrect = false;
                      isLoading = true;
                    });
                    if(otpvalue == sendOtp){
                      if(widget.action == "register"){
                        await userprovider.createAccount();
                        if(userprovider.registerMessage == "success"){
                          userprovider.Changeemail = widget.user['email'];
                          userprovider.Changepassword = widget.user['password'];
                          await userprovider.loginToAccount();
                          print(userprovider.loginMessage);
                          if(userprovider.loginMessage == "success"){
                            setState(() {
                              isLoading = false;
                            });
                            await safariapi.setToken(userprovider.token);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.push(context, new MaterialPageRoute(builder: (context) => HomePages()));
                          }else{
                            setState(() {
                              iscorrect = true;
                              isLoading = false;
                            });
                          }
                        }
                      }else{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EnterNewPassword(id: widget.user['id'],)));
                      }
                    }else{
                      setState(() {
                        iscorrect = true;
                        isLoading = false;
                      });
                    }
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
                Row(
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
                      onTap: () async{
                        userprovider.loadUser(widget.user);
                        await userprovider.sendmailToUser();

                        if(userprovider.emailMessage == "success"){
                          setState(() {
                            sendOtp = userprovider.code;
                          });
                        }
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
