import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:safarimovie/Pages/splashscreen.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:safarimovie/Pages/Auth/login.dart';
import 'package:safarimovie/Providers/videosProvider.dart';
import 'Providers/LanguageChangeProvider.dart';
import 'Providers/userProvider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    //  DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserProvider>(create: (_) => UserProvider()),
        Provider<VideosProviders>(create: (_) => VideosProviders()),
        ChangeNotifierProvider(
          create: (context) =>  LanguageChangeProvider(),
        )
      ],
      child: Builder(
        builder: (context) =>
        Consumer<LanguageChangeProvider>(
            builder: (context, value, child){
              return value.doneLoading == true ? MaterialApp(
                locale: Provider.of<LanguageChangeProvider>(context, listen: true).currentLocale,
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                debugShowCheckedModeBanner: false,
                home: Login(),
              ) : SplashScreen(context: context,);
            }
        ),
      ),
    );
  }
}


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
