import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:provider/provider.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:safarimovie/Api/safariapi.dart';
import 'package:safarimovie/Pages/detail.dart';
import 'package:safarimovie/Providers/videosProvider.dart';
import 'package:safarimovie/Services/videosService.dart';
import 'package:safarimovie/constantes.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'dart:async';

import '../Providers/LanguageChangeProvider.dart';
import '../generated/l10n.dart';
import 'notificationpage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SafariApi safariapi = SafariApi();
  VideosService videoservice = VideosService();
  String currentlanguage = "All";
  String language = "Français";
  String lang = "fr";
  List<String> langues = ["All", "Français", "Anglais"];
  var incre;
  int currentPub = 3;
  int nonlu = 0;
  bool lu = false;
  Timer? timer;
  //List data = [];
  late Map datas;
  List<dynamic> userData = [];
  List<dynamic> allMovies = [];
  List<dynamic> films = [];
  List<dynamic> series = [];
  List<dynamic> novelas = [];
  List<dynamic> publicite = [];
  List<dynamic> webSeries = [];
  List<dynamic> avatar = [];
  List<dynamic> notificationsNonLu = [];

  loadLanguage() {
    final languageProvider = Provider.of<LanguageChangeProvider>(context, listen: false);
    String l = languageProvider.currentLocale.toString();
    setState(() {
      language = languageProvider.currentLocaleName;
      if(language == "All"){
        lang = "all";
      }else{
        lang = l;
      }
    });
  }

  findAllVideos(lang) async{
    //loadLanguage();
    final videoprovider = Provider.of<VideosProviders>(context, listen: false);
    List<dynamic> a = await videoprovider.allMovies(lang);
    print(lang);
    setState(() {
      allMovies = a;
      films = a[1];
      series = a[2];
      webSeries = a[3];
      novelas = a[4];
      avatar = a[5];
      publicite = a[0];
    });
    print("films : $webSeries");
  }
  allNotificationNonlu() async{
    final videoprovider = Provider.of<VideosProviders>(context, listen: false);
   // await videoprovider.allNotificationNonLu().delayed(Duration(seconds: 2))
    List<dynamic> n = await videoprovider.allNotificationNonLu();
    setState(() {
      notificationsNonLu = n;
    });
  }
  //Future<List<dynamic>> notificationList =  [] as Future<List<dynamic>>;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadLanguage();
    findAllVideos(lang);
    allNotificationNonlu();
    timer = Timer.periodic(Duration(seconds: 60), (timer) {
      setState(() {
        //nonlu = 0;
        allNotificationNonlu();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    //loadFutureList();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: appBar(),
            snap: false,
            pinned: true,
            floating: false,
            centerTitle: false,
            titleSpacing: .0,
            backgroundColor: fisrtcolor,
            expandedHeight: MediaQuery.of(context).size.height,
            flexibleSpace: FlexibleSpaceBar(
              background: publicite == [] ? CircularProgressIndicator() :pub(),
              centerTitle: true,
            ),
          ),
          SliverFixedExtentList(
              delegate: SliverChildListDelegate([
                Container(
                  decoration: BoxDecoration(color: fisrtcolor),
                  child: continu(),
                )
              ]),
              itemExtent: films.length > 0 && series.length > 0 && webSeries.length > 0 && novelas.length > 0 ? 1550.0
                  : films.length > 0 && series.length > 0 && webSeries.length > 0 && novelas.length <= 0 ? 1300.0
                  : films.length > 0 && series.length > 0 && webSeries.length <= 0 && novelas.length > 0 ? 1300.0
                  : films.length > 0 && series.length <= 0 && webSeries.length > 0 && novelas.length > 0 ? 1300.0
                  : films.length <= 0 && series.length > 0 && webSeries.length > 0 && novelas.length > 0 ? 1300.0
                  : films.length > 0 && series.length > 0 && webSeries.length <= 0 && novelas.length <= 0 ? 1050.0
                  : films.length > 0 && series.length <= 0 && webSeries.length <= 0 && novelas.length <= 0 ? 800.0
                  : films.length <= 0 && series.length > 0 && webSeries.length <= 0 && novelas.length > 0 ? 800.0
                  : films.length <= 0 && series.length <= 0 && webSeries.length <= 0 && novelas.length > 0 ? 800.0
                  : 800.0
          )
        ],
      ),
    );
  }

  appBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Image.asset(
              "assets/images/logo.png",
              height: AppBar().preferredSize.height,
              width: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.contain,
            ),
          ),
          Row(
            children: [
             notificationsNonLu.length > 0 ? profile() : Padding(
               padding: const EdgeInsets.only(right: 24),
               child: InkWell(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
                 },
                   child: Icon(Icons.notifications_none)),
             ),
             avatar.length > 0 ? CircleAvatar(
                 radius: 15,
                 backgroundColor: Colors.white,
                 backgroundImage: avatar[0]['avatar'] != null ? NetworkImage(safariapi.getProfil() + avatar[0]['avatar'].toString()) : NetworkImage(safariapi.getLogo() + "logomobilenoir.png")
             ) : CircleAvatar(
               radius: 15,
               backgroundColor: Colors.white,
               child: Center(child: Icon(Icons.person, size: 20,),),
               //backgroundImage: Icon(Icons.person),
             ),
            ],
          )
        ],
      ),
    );
  }

  profile(){
    final videosProviders = Provider.of<VideosProviders>(context, listen: false);
    nonlu = notificationsNonLu.length;
    // for(int i=0; i < notifications.length; i++){
    //   if(notifications[i][0]['read_at'].toString() == "null"){
    //     setState(() {
    //       nonlu = i + 1;
    //     });
    //   }
    // }
    return IconBadge(
      icon: Icon(Icons.notifications_none),
      itemCount: nonlu,
      badgeColor: secondcolor,
      maxCount: 99,
      top: 6,
      right: 5,
      itemColor: Colors.white,
      hideZero: true,
      onTap: () async{
        setState(() {
          lu = true;
          nonlu = 0;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
        await videosProviders.readNotification();
        notificationsNonLu.clear();
      },
    );
  }

  pub() {
    final videosProviders = Provider.of<VideosProviders>(context);
    if(publicite.length > 0){
      incre = publicite.length;
      int ic = (incre as int) - 1;
      //pubencour = snapshot.data![i][0];
      return Stack(
        children: [
          Container(
            width: double.infinity,
            child: Carousel(
              dotSize: 6.0,
              dotSpacing: 20.0,
              dotColor: secondcolor,
              indicatorBgPadding: 120.0,
              dotBgColor: Colors.transparent,
              autoplay: true,
              borderRadius: true,
              onImageChange: (i, j){
                //print("$i   ||   $j");
                setState(() {
                  currentPub = j;
                });
              },
              images: [
                for(int i = 0; i <= ic; i++)
                  publicite == [] ? SizedBox() : slide(publicite[i][0], publicite[i][1])
              ],
            ),
          ),
          Positioned(
            bottom: 120,
            right: 30,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: secondcolor, borderRadius: BorderRadius.circular(25.0)),
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    dynamic item = videosProviders.returnFilm(publicite[currentPub][0]);
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(film: item)));
                  },
                  // color: thirdcolor,
                ),
              ),
            ),
          )
        ],
      );
    }else{
      return CircularProgressIndicator();
    }
  }

  slide(item, genres) {
    incre = genres.length;
    int ic = (incre as int);
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(safariapi.getImagePub() + item['pub'].toString()), fit: BoxFit.fill),
        ),
        child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 185, left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Disponible maintenant",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontFamily: 'PopRegular',
                          ),
                        ),
                        Text(
                          item['titre'].toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'PopBold',
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 5,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          //crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 5.0,
                          runSpacing: 5.0,
                          children: [
                            // for(int i = 0; i <= ic; i++)
                            ic >= 1 ? Text(
                              genres[0]["nom"].toString(),
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                 color: Colors.white,
                                fontFamily: 'PopBold',
                                fontSize: 15,
                              ),
                            ) :SizedBox(),
                            ic > 1 ? Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Icon(
                                Icons.arrow_right,
                                color: Colors.white,
                                size: 20,
                              ),
                            ) : SizedBox(),
                            ic >= 2 ? Text(
                              genres[1]["nom"].toString(),
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'PopBold',
                                fontSize: 15,
                              ),
                            ) :SizedBox(),
                            ic > 2 ? Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Icon(
                                Icons.arrow_right,
                                color: Colors.white,
                                size: 20,
                              ),
                            ) :SizedBox(),
                            ic >= 3 ? Text(
                              genres[2]["nom"].toString(),
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'PopBold',
                                fontSize: 15,
                              ),
                            ) :SizedBox(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 120,
                  left: 30,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Center(
                        child: Text(
                          '+' + item['age'].toString(),
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'PopBold'),
                        )),
                  ),
                )
              ],
            )));
  }

  continu() {
    final langueProvider = Provider.of<LanguageChangeProvider>(context, listen: false);
    final videosProviders = Provider.of<VideosProviders>(context);
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),

        Padding(
          padding: EdgeInsets.only(left: 14, right: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).langue,
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'PopRegular',
                      color: Colors.white,
                    ),
                  ),
                  Consumer<LanguageChangeProvider>(
                      builder: (context, value, child){
                        return DropdownButton<String>(
                          value: value.currentLocaleName,
                          dropdownColor: fisrtcolor,
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Icon(
                              Icons.translate,
                              color: secondcolor,
                              size: 18,
                            ),
                          ),
                          iconSize: 24,
                          //elevation: 16,
                          underline: Container(
                            height: 1,
                            color: fisrtcolor,
                          ),
                          alignment: Alignment.centerRight,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'PopRegular',
                          ),
                          onChanged: (e)  {
                            setState(() {
                              currentlanguage = e!;
                            });
                            switch (e!) {
                              case "All":
                                value.changeLocale("fr", "All");
                                //await videosProviders.allMovies(1);
                                break;

                              case "Français":
                                value.changeLocale("fr", "Français");
                                   //await videosProviders.allMovies(1);
                                break;

                              case "Anglais":
                                value.changeLocale("en", "Anglais");
                                break;
                            }
                            loadLanguage();
                            findAllVideos(lang);
                          },
                          items: langues
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        );
                      }
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Continuer',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'PopBold',
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        listViewContinue(),
        Padding(
          padding: EdgeInsets.only(left: 14, right: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Movies',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'PopBold',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: secondcolor,
                  size: 15,
                ),
                onPressed: null,
              ),
            ],
          ),
        ),
        listViewMovie(),
        Padding(
          padding: EdgeInsets.only(left: 14, right: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Series',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'PopBold',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: secondcolor,
                  size: 15,
                ),
                onPressed: null,
              ),
            ],
          ),
        ),
        listViewSeries(),
        webSeries == [] || webSeries.length <= 0 ? SizedBox() : Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 14, right: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Web Series',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'PopBold',
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: secondcolor,
                      size: 15,
                    ),
                    onPressed: null,
                  ),
                ],
              ),
            ),
            listViewWebSeries()
          ],
        ),
       // webSeries == [] ? SizedBox() :listViewWebSeries(),
        Padding(
          padding: EdgeInsets.only(left: 14, right: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Series Novelas',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'PopBold',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: secondcolor,
                  size: 15,
                ),
                onPressed: null,
              ),
            ],
          ),
        ),
        listViewNovelas()
      ],
    );
  }

  listViewContinue() {
    return Container(
      height: 250,
      width: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 20),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
              right: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/movie4.jpg"),
                          fit: BoxFit.cover),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.play_circle_outline,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () {},
                      // color: thirdcolor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                StepProgressIndicator(
                  totalSteps: 100,
                  currentStep: 32,
                  fallbackLength: 250,
                  size: 2,
                  padding: 0,
                  selectedColor: Colors.yellow,
                  unselectedColor: Colors.white,
                  roundedEdges: Radius.circular(10),
                  selectedGradientColor: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.red, Colors.red],
                  ),
                  unselectedGradientColor: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Colors.white],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'African safari 3D',
                      style: TextStyle(
                          fontFamily: 'PopRegular',
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Serie',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'PopLight',
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.circle,
                          size: 8,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Saison 3',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'PopLight',
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Eps. 03',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'PopLight',
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
  listViewMovie() {
    final videosProviders = Provider.of<VideosProviders>(context);
    return Container(
      height: 250,
      width: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 20),
        itemCount: films.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          incre = films[index][1].length;
          int ic = (incre as int);
          return InkWell(
            onTap: (){
              // dynamic film = videosProviders.returnFilm(snapshot.data![index]);
              // List<String> ss = videosProviders.saison;
              //videosProviders.infosMovies(4);
              dynamic item = videosProviders.returnFilm(films[index][0]);
              // int id = (films[index][0]['id'] as int);
              // videosProviders.ifSimilaire(id);
              Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(film: item)));
              //Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(film: item, issimilaire: videosProviders.similaire,)));
            },
            child: Container(
              width: 150,
              padding: EdgeInsets.only(
                right: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: 150,
                    foregroundDecoration: films[index][0]['status_periodique'] == "nouveau"
                        ? const RotatedCornerDecoration(
                      color: secondcolor,
                      geometry: const BadgeGeometry(width: 48, height: 48),
                      textSpan: const TextSpan(
                        text: 'Nouveau',
                        style: TextStyle(
                          fontSize: 10,
                          // letterSpacing: 1,
                          // fontWeight: FontWeight.bold,
                          fontFamily: 'PopBold',
                          color: Colors.white,
                          shadows: [BoxShadow(color: Colors.yellowAccent, blurRadius: 5)],
                        ),
                      ),
                    )
                        : BoxDecoration(),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(safariapi.getImage() + films[index][0]['image'].toString()),
                            fit: BoxFit.cover),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        films[index][0]['titre'].toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                            fontFamily: 'PopRegular',
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        // alignment: WrapAlignment.center,
                        // runAlignment: WrapAlignment.center,
                        // // crossAxisAlignment: WrapCrossAlignment.center,
                        // spacing: 5.0,
                        // runSpacing: 5.0,
                        children: [
                          // for(int i = 0; i <= ic; i++)
                          ic >= 1 ? Text(
                            films[index][1][0]["nom"].toString(),
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 8,
                            ),
                          ) :SizedBox(),
                          ic > 1 ? Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                            size: 10,
                          ) : SizedBox(),
                          ic >= 2 ? Text(
                            films[index][1][1]["nom"].toString(),
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 8,
                            ),
                          ) :SizedBox(),
                          ic > 2 ? Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                            size: 10,
                          ) :SizedBox(),
                          ic >= 3 ? Expanded(
                            child: Text(
                              films[index][1][2]["nom"].toString(),
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 8,
                              ),
                            ),
                          ) :SizedBox(),
                        ],
                      )
                      // Row(
                      //   children: [
                      //     Text(
                      //       'Serie',
                      //       style: TextStyle(
                      //         color: Colors.grey,
                      //         fontSize: 8,
                      //       ),
                      //     ),
                      //     Icon(
                      //       Icons.arrow_right,
                      //       color: Colors.white,
                      //       size: 10,
                      //     ),
                      //     Text(
                      //       'Documentaire',
                      //       style: TextStyle(
                      //         color: Colors.grey,
                      //         fontSize: 8,
                      //       ),
                      //     ),
                      //     Icon(
                      //       Icons.arrow_right,
                      //       color: Colors.white,
                      //       size: 10,
                      //     ),
                      //     Text(
                      //       'Histoire',
                      //       style: TextStyle(
                      //         color: Colors.grey,
                      //         fontSize: 8,
                      //       ),
                      //     ),
                      //   ],
                      // )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  // listViewMovie() {
  //   final videosProviders = Provider.of<VideosProviders>(context);
  //   return Container(
  //     height: 250,
  //     width: double.infinity,
  //     child: FutureBuilder<List<dynamic>>(
  //       future: videosProviders.allMovies(1),
  //       builder: (context, snapshot){
  //         if(snapshot.data != null){
  //           return ListView.builder(
  //             padding: EdgeInsets.only(left: 20),
  //             itemCount: snapshot.data?.length,
  //             scrollDirection: Axis.horizontal,
  //             itemBuilder: (BuildContext context, int index) {
  //               incre = snapshot.data?[index][1].length;
  //               int ic = (incre as int);
  //               return InkWell(
  //                 onTap: (){
  //                   // dynamic film = videosProviders.returnFilm(snapshot.data![index]);
  //                   // List<String> ss = videosProviders.saison;
  //                   //videosProviders.infosMovies(4);
  //                   dynamic item = videosProviders.returnFilm(snapshot.data![index][0]);
  //
  //                   videosProviders.ifSimilaire(snapshot.data![index][0]['id']);
  //                   Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(film: item, issimilaire: videosProviders.similaire,)));
  //                 },
  //                 child: Container(
  //                   width: 150,
  //                   padding: EdgeInsets.only(
  //                     right: 10,
  //                   ),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                         height: 200,
  //                         width: 150,
  //                         foregroundDecoration: snapshot.data![index][0]['status_periodique'] == "nouveau"
  //                         ? const RotatedCornerDecoration(
  //                         color: secondcolor,
  //                         geometry: const BadgeGeometry(width: 48, height: 48),
  //                         textSpan: const TextSpan(
  //                           text: 'Nouveau',
  //                           style: TextStyle(
  //                             fontSize: 10,
  //                             // letterSpacing: 1,
  //                             // fontWeight: FontWeight.bold,
  //                             fontFamily: 'PopBold',
  //                             color: Colors.white,
  //                             shadows: [BoxShadow(color: Colors.yellowAccent, blurRadius: 5)],
  //                           ),
  //                         ),
  //                       )
  //                         : BoxDecoration(),
  //                         decoration: BoxDecoration(
  //                             image: DecorationImage(
  //                                 image: NetworkImage(safariapi.getImage() + snapshot.data![index][0]['image'].toString()),
  //                                 fit: BoxFit.cover),
  //                             color: Colors.white,
  //                             borderRadius: BorderRadius.circular(5.0)),
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             snapshot.data![index][0]['titre'].toString(),
  //                             maxLines: 1,
  //                             overflow: TextOverflow.ellipsis,
  //                             softWrap: true,
  //                             style: TextStyle(
  //                                 fontFamily: 'PopRegular',
  //                                 fontSize: 12,
  //                                 color: Colors.white,
  //                                 fontWeight: FontWeight.w800),
  //                           ),
  //                           SizedBox(
  //                             height: 5,
  //                           ),
  //                           Wrap(
  //                             alignment: WrapAlignment.center,
  //                             runAlignment: WrapAlignment.center,
  //                             // crossAxisAlignment: WrapCrossAlignment.center,
  //                             spacing: 5.0,
  //                             runSpacing: 5.0,
  //                             children: [
  //                               // for(int i = 0; i <= ic; i++)
  //                               ic >= 1 ? Text(
  //                                 snapshot.data![index][1][0]["nom"].toString(),
  //                                       style: TextStyle(
  //                                         color: Colors.grey,
  //                                         fontSize: 8,
  //                                       ),
  //                               ) :SizedBox(),
  //                               ic > 1 ? Icon(
  //                                 Icons.arrow_right,
  //                                 color: Colors.white,
  //                                 size: 10,
  //                               ) : SizedBox(),
  //                               ic >= 2 ? Text(
  //                                 snapshot.data![index][1][1]["nom"].toString(),
  //                                 style: TextStyle(
  //                                   color: Colors.grey,
  //                                   fontSize: 8,
  //                                 ),
  //                               ) :SizedBox(),
  //                               ic > 2 ? Icon(
  //                                 Icons.arrow_right,
  //                                 color: Colors.white,
  //                                 size: 10,
  //                               ) :SizedBox(),
  //                               ic >= 3 ? Text(
  //                                 snapshot.data![index][1][2]["nom"].toString(),
  //                                 style: TextStyle(
  //                                   color: Colors.grey,
  //                                   fontSize: 8,
  //                                 ),
  //                               ) :SizedBox(),
  //                             ],
  //                           )
  //                           // Row(
  //                           //   children: [
  //                           //     Text(
  //                           //       'Serie',
  //                           //       style: TextStyle(
  //                           //         color: Colors.grey,
  //                           //         fontSize: 8,
  //                           //       ),
  //                           //     ),
  //                           //     Icon(
  //                           //       Icons.arrow_right,
  //                           //       color: Colors.white,
  //                           //       size: 10,
  //                           //     ),
  //                           //     Text(
  //                           //       'Documentaire',
  //                           //       style: TextStyle(
  //                           //         color: Colors.grey,
  //                           //         fontSize: 8,
  //                           //       ),
  //                           //     ),
  //                           //     Icon(
  //                           //       Icons.arrow_right,
  //                           //       color: Colors.white,
  //                           //       size: 10,
  //                           //     ),
  //                           //     Text(
  //                           //       'Histoire',
  //                           //       style: TextStyle(
  //                           //         color: Colors.grey,
  //                           //         fontSize: 8,
  //                           //       ),
  //                           //     ),
  //                           //   ],
  //                           // )
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //           );
  //         }else{
  //           return CircularProgressIndicator();
  //         }
  //       },
  //     ),
  //   );
  // }

  listViewSeries() {
    final videosProviders = Provider.of<VideosProviders>(context);
    return Container(
      height: 250,
      width: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 20),
        itemCount: series.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          incre = series[index][1].length;
          int ic = (incre as int);
          return InkWell(
            onTap: (){
              dynamic item = videosProviders.returnFilm(series[index][0]);
              Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(film: item)));
              // Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(film: videosProviders.returnFilm(snapshot.data![index]))));
            },
            child: Container(
              width: 150,
              padding: EdgeInsets.only(
                right: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: 150,
                    foregroundDecoration: series[index][0]['status_periodique'] == "nouveau"
                        ? const RotatedCornerDecoration(
                      color: secondcolor,
                      geometry: const BadgeGeometry(width: 48, height: 48),
                      textSpan: const TextSpan(
                        text: 'Nouveau',
                        style: TextStyle(
                          fontSize: 10,
                          // letterSpacing: 1,
                          // fontWeight: FontWeight.bold,
                          fontFamily: 'PopBold',
                          color: Colors.white,
                          shadows: [BoxShadow(color: Colors.yellowAccent, blurRadius: 5)],
                        ),
                      ),
                    )
                        : BoxDecoration(),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(safariapi.getImage() + series[index][0]['image'].toString()),
                            fit: BoxFit.cover),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        series[index][0]['titre'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                        style: TextStyle(
                            fontFamily: 'PopRegular',
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        // alignment: WrapAlignment.center,
                        // runAlignment: WrapAlignment.center,
                        // // crossAxisAlignment: WrapCrossAlignment.center,
                        // spacing: 5.0,
                        // runSpacing: 5.0,
                        children: [
                          // for(int i = 0; i <= ic; i++)
                          ic >= 1 ? Text(
                            series[index][1][0]["nom"].toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 8,
                            ),
                          ) :SizedBox(),
                          ic > 1 ? Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                            size: 10,
                          ) : SizedBox(),
                          ic >= 2 ? Text(
                            series[index][1][1]["nom"].toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 8,
                            ),
                          ) :SizedBox(),
                          ic > 2 ? Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                            size: 10,
                          ) :SizedBox(),
                          ic >= 3 ? Expanded(
                            child: Text(
                              series[index][1][2]["nom"].toString(),
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 8,
                              ),
                            ),
                          ) :SizedBox(),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  listViewWebSeries() {
    final videosProviders = Provider.of<VideosProviders>(context);
    return Container(
      height: 250,
      width: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 20),
        itemCount: webSeries.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          incre = webSeries[index][1].length;
          int ic = (incre as int);
          return InkWell(
            onTap: (){
              dynamic item = videosProviders.returnFilm(webSeries[index][0]);
              Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(film: item)));
              // Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(film: videosProviders.returnFilm(snapshot.data![index]))));
            },
            child: Container(
              width: 150,
              padding: EdgeInsets.only(
                right: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: 150,
                    foregroundDecoration: webSeries[index][0]['status_periodique'] == "nouveau"
                        ? const RotatedCornerDecoration(
                      color: secondcolor,
                      geometry: const BadgeGeometry(width: 48, height: 48),
                      textSpan: const TextSpan(
                        text: 'Nouveau',
                        style: TextStyle(
                          fontSize: 10,
                          // letterSpacing: 1,
                          // fontWeight: FontWeight.bold,
                          fontFamily: 'PopBold',
                          color: Colors.white,
                          shadows: [BoxShadow(color: Colors.yellowAccent, blurRadius: 5)],
                        ),
                      ),
                    )
                        : BoxDecoration(),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(safariapi.getImage() + webSeries[index][0]['image'].toString()),
                            fit: BoxFit.cover),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        webSeries[index][0]['titre'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                            fontFamily: 'PopRegular',
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        // alignment: WrapAlignment.center,
                        // runAlignment: WrapAlignment.center,
                        // // crossAxisAlignment: WrapCrossAlignment.center,
                        // spacing: 5.0,
                        // runSpacing: 5.0,
                        children: [
                          // for(int i = 0; i <= ic; i++)
                          ic >= 1 ? Text(
                            webSeries[index][1][0]["nom"].toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 8,
                            ),
                          ) :SizedBox(),
                          ic > 1 ? Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                            size: 10,
                          ) : SizedBox(),
                          ic >= 2 ? Text(
                            webSeries[index][1][1]["nom"].toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 8,
                            ),
                          ) :SizedBox(),
                          ic > 2 ? Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                            size: 10,
                          ) :SizedBox(),
                          ic >= 3 ? Expanded(
                            child: Text(
                              webSeries[index][1][2]["nom"].toString(),
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 8,
                              ),
                            ),
                          ) :SizedBox(),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }

  listViewNovelas() {
    final videosProviders = Provider.of<VideosProviders>(context);
    return Container(
      height: 250,
      width: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 20),
        itemCount: novelas.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          incre = novelas[index][1].length;
          int ic = (incre as int);
          return InkWell(
            onTap: (){
              dynamic item = videosProviders.returnFilm(novelas[index][0]);
              Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(film: item)));
              // Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(film: videosProviders.returnFilm(snapshot.data![index]))));
            },
            child: Container(
              width: 150,
              padding: EdgeInsets.only(
                right: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: 150,
                    foregroundDecoration: novelas[index][0]['status_periodique'] == "nouveau"
                        ? const RotatedCornerDecoration(
                      color: secondcolor,
                      geometry: const BadgeGeometry(width: 48, height: 48),
                      textSpan: const TextSpan(
                        text: 'Nouveau',
                        style: TextStyle(
                          fontSize: 10,
                          // letterSpacing: 1,
                          // fontWeight: FontWeight.bold,
                          fontFamily: 'PopBold',
                          color: Colors.white,
                          shadows: [BoxShadow(color: Colors.yellowAccent, blurRadius: 5)],
                        ),
                      ),
                    )
                        : BoxDecoration(),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(safariapi.getImage() + novelas[index][0]['image'].toString()),
                            fit: BoxFit.cover),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        novelas[index][0]['titre'],
                        style: TextStyle(
                            fontFamily: 'PopRegular',
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        // alignment: WrapAlignment.center,
                        // runAlignment: WrapAlignment.center,
                        // // crossAxisAlignment: WrapCrossAlignment.center,
                        // spacing: 5.0,
                        // runSpacing: 5.0,
                        children: [
                          // for(int i = 0; i <= ic; i++)
                          ic >= 1 ? Text(
                            novelas[index][1][0]["nom"].toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 8,
                            ),
                          ) :SizedBox(),
                          ic > 1 ? Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                            size: 10,
                          ) : SizedBox(),
                          ic >= 2 ? Text(
                            novelas[index][1][1]["nom"].toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 8,
                            ),
                          ) :SizedBox(),
                          ic > 2 ? Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                            size: 10,
                          ) :SizedBox(),
                          ic >= 3 ? Expanded(
                            child: Text(
                              novelas[index][1][2]["nom"].toString(),
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 8,
                              ),
                            ),
                          ) :SizedBox(),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }
}