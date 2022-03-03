import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safarimovie/Api/safariapi.dart';
import 'package:safarimovie/Pages/detail.dart';
import 'package:safarimovie/Providers/videosProvider.dart';
import 'package:safarimovie/Services/videosService.dart';
import 'package:safarimovie/constantes.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SafariApi safariapi = SafariApi();
  VideosService videoservice = VideosService();
  var incre;
  //List data = [];
  late Map datas;
  List<dynamic> userData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              background: pub(),
              centerTitle: true,
            ),
          ),
          SliverFixedExtentList(
              delegate: SliverChildListDelegate([
                Container(
                  height: 1500.0,
                  decoration: BoxDecoration(color: fisrtcolor),
                  child: continu(),
                )
              ]),
              itemExtent: 1500.0)
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
          // Text(
          //   'Safari Movies',
          //   style: TextStyle(
          //       fontFamily: 'RoboItalic',
          //       fontSize: 30,
          //       color: Colors.white,
          //       fontWeight: FontWeight.w800),
          // ),
          Image.asset(
            "assets/images/logo.png",
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ),
                onPressed: null,
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    image: DecorationImage(
                        image: AssetImage("assets/images/person3.jpg"),
                        fit: BoxFit.cover)),
              ),
            ],
          )
        ],
      ),
    );
  }

  pub() {
    final videoprovider = Provider.of<VideosProviders>(context);
    return Stack(
      children: [
        FutureBuilder<List<dynamic>>(
          future: videoprovider.allMovies(4),
            builder: (context, snapshot){
              if(snapshot.data != null){
                incre = snapshot.data?.length;
                int ic = (incre as int) - 1;
                return Container(
                  width: double.infinity,
                  child: Carousel(
                    dotSize: 6.0,
                    dotSpacing: 20.0,
                    dotColor: secondcolor,
                    indicatorBgPadding: 120.0,
                    dotBgColor: Colors.transparent,
                    autoplay: true,
                    borderRadius: true,
                    images: [
                      for(int i = 0; i <= ic; i++)
                        slide(snapshot.data![i])
                    ],
                  ),
                );
              }else{
                return CircularProgressIndicator();
              }
            }
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
                  Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () {},
                // color: thirdcolor,
              ),
            ),
          ),
        )
      ],
    );
  }

  slide(item) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(safariapi.getImagePub() + item['pub'].toString()), fit: BoxFit.fill),
        ),
        child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Stack(
              children: [
                Padding(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Film",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PopBold',
                            ),
                          ),
                          Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                          ),
                          Text(
                            "Comedie",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PopBold',
                            ),
                          ),
                          Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                          ),
                          Text(
                            "Drame",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PopBold',
                            ),
                          ),
                        ],
                      )
                    ],
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
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 14, right: 2),
          child: Row(
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
        listViewWebSeries(),
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
      child: FutureBuilder<List<dynamic>>(
        future: videosProviders.allMovies(0),
        builder: (context, snapshot){
          if(snapshot.data != null){
            return ListView.builder(
              padding: EdgeInsets.only(left: 20),
              itemCount: snapshot.data?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    // dynamic film = videosProviders.returnFilm(snapshot.data![index]);
                    // List<String> ss = videosProviders.saison;
                    //videosProviders.infosMovies(4);
                    dynamic item = videosProviders.returnFilm(snapshot.data![index]);

                    videosProviders.ifSimilaire(snapshot.data![index]['id']);
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(film: item, issimilaire: videosProviders.similaire,)));
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
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(safariapi.getImage() + snapshot.data![index]['image'].toString()),
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
                              snapshot.data![index]['titre'].toString(),
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
                              children: [
                                Text(
                                  'Serie',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 8,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                Text(
                                  'Documentaire',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 8,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                Text(
                                  'Histoire',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  listViewSeries() {
    final videosProviders = Provider.of<VideosProviders>(context);
    return Container(
      height: 250,
      width: double.infinity,
      child: FutureBuilder<List<dynamic>>(
          future: videosProviders.allMovies(1),
          builder: (context, snapshot){
            if(snapshot.data != null){
              return ListView.builder(
                padding: EdgeInsets.only(left: 20),
                itemCount: snapshot.data?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                      dynamic item = videosProviders.returnFilm(snapshot.data![index]);

                      videosProviders.ifSimilaire(snapshot.data![index]['id']);
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(film: item, issimilaire: videosProviders.similaire,)));
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
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(safariapi.getImage() + snapshot.data![index]['image'].toString()),
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
                                snapshot.data![index]['titre'],
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
                                children: [
                                  Text(
                                    'Serie',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 8,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_right,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                                  Text(
                                    'Documentaire',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 8,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_right,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                                  Text(
                                    'Histoire',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            else{
              return CircularProgressIndicator();
            }
          }
      ),
    );
  }

  listViewWebSeries() {
    final videosProviders = Provider.of<VideosProviders>(context);
    return Container(
      height: 250,
      width: double.infinity,
      child: FutureBuilder<List<dynamic>>(
        future: videosProviders.allMovies(3),
        builder: (context, snapshot){
          if(snapshot.data != null){
            return ListView.builder(
              padding: EdgeInsets.only(left: 20),
              itemCount: snapshot.data?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    dynamic item = videosProviders.returnFilm(snapshot.data![index]);

                    videosProviders.ifSimilaire(snapshot.data![index]['id']);
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(film: item, issimilaire: videosProviders.similaire,)));
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
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(safariapi.getImage() + snapshot.data![index]['image'].toString()),
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
                              snapshot.data![index]['titre'],
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
                              children: [
                                Text(
                                  'Serie',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 8,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                Text(
                                  'Documentaire',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 8,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                Text(
                                  'Histoire',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }else{
            return CircularProgressIndicator();
          }
        },
      )
    );
  }

  listViewNovelas() {
    final videosProviders = Provider.of<VideosProviders>(context);
    return Container(
      height: 250,
      width: double.infinity,
      child: FutureBuilder<List<dynamic>>(
        future: videosProviders.allMovies(2),
        builder: (context, snapshot){
          if(snapshot.data != null){
            return ListView.builder(
              padding: EdgeInsets.only(left: 20),
              itemCount: snapshot.data?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    dynamic item = videosProviders.returnFilm(snapshot.data![index]);

                    videosProviders.ifSimilaire(snapshot.data![index]['id']);
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(film: item, issimilaire: videosProviders.similaire,)));
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
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(safariapi.getImage() + snapshot.data![index]['image'].toString()),
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
                              snapshot.data![index]['titre'],
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
                              children: [
                                Text(
                                  'Serie',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 8,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                Text(
                                  'Documentaire',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 8,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                Text(
                                  'Histoire',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}