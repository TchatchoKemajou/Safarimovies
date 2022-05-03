import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/LanguageChangeProvider.dart';

class SplashScreen extends StatefulWidget {
  final BuildContext context;
  const SplashScreen({Key? key, required this.context}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void getdata() async{
    await Future.delayed(Duration(seconds: 2));
    widget.context.read<LanguageChangeProvider>().doneLoading = true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          // child: Image(
          //   image: AssetImage('assets/images/logoc.png'),
          //   //height:  MediaQuery.of(widget.context).size.height *0.4,
          // ),
        ),
      ),
    );
  }
}
