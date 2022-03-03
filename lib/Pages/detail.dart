import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safarimovie/Api/safariapi.dart';
import 'package:safarimovie/Providers/videosProvider.dart';

import '../constantes.dart';


class DetailPage extends StatefulWidget {
  final Map<dynamic, dynamic> film;
  final bool issimilaire;
  //final List<String> s;
  DetailPage({required this.film, required this.issimilaire});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var incre;
  String saison = "Saison 1";
  int saisonId = 1;
  bool iffavori = false;
  List<String> saisons = [];
   late bool ifsimilaire;
  List imgList = [
    'assets/images/movie1.jpg',
    'assets/images/movie2.jpg',
    'assets/images/movie3.jpg',
    'assets/images/movie4.jpg',
    'assets/images/movie5.jpg',
    'assets/images/movie6.jpg',
  ];
  SafariApi safariapi = SafariApi();

  @override
  void initState() {
    // TODO: implement initState
    ifsimilaire = widget.issimilaire;
    //saisons = ["Saison 1", "Saison 2", "Saison 3", "Saison 4", "Saison 5", "Saison 6"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     final videoprovider = Provider.of<VideosProviders>(context, listen: false);
     videoprovider.loadFilm(widget.film);
    //videoprovider.ifSimilaire();
    //videoprovider.allSaisons();
    //print(videoprovider.saison);
    // setState(() {
    //   ifsimilaire = videoprovider.similaire;
    // });
    //print(ifsimilaire);
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 20),
          color: fisrtcolor,
          child: Column(
            children: [
              affiche(),
              SizedBox(
                height: 15,
              ),
              description(),
              SizedBox(
                height: 25,
              ),
              listViewActeur(),
              widget.film['rubrique'] != "Film" ? listViewEpisode() : SizedBox(),
              ifsimilaire == true ? listViewSimilaire() : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
  appBar() {
    final videoprovider = Provider.of<VideosProviders>(context);
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(
        widget.film['titre'],
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'PopRegular'
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            iffavori == true ? Icons.favorite :Icons.favorite_outline_rounded,
            color: iffavori == true ? Colors.red :Colors.white,
          ),
          onPressed: () async{
            videoprovider.addToFavorie(widget.film["creator_id"]);
            setState(() {
              iffavori = videoprovider.isfavori;
            });
          },
        ),
      ],
      centerTitle: true,
      backgroundColor: fisrtcolor,
      elevation: .0,
    );
  }

  affiche() {
    final videoprovider = Provider.of<VideosProviders>(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, right: 10, left: 10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: NetworkImage(safariapi.getImage() + widget.film['image'].toString()),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: fisrtcolor.withOpacity(0.4),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 30,
              child: Row(
                children: [
                  Container(
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
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Jouer maintenant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontFamily: 'PopBold',
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              right: 30,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
                child: Center(
                    child: Text(
                      '+' + widget.film['age'].toString(),
                      style: TextStyle(color: Colors.black, fontFamily: 'PopBold'),
                    )),
              ),
            )
          ],
        ),
        FutureBuilder<List<dynamic>>(
          future: videoprovider.infosMovies(2),
            builder: (context, snapshot){
              if(snapshot.data != null){
                //print(snapshot.data);
                incre = snapshot.data?.length;
                int ic = (incre as int);
                return Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 5.0,
                    runSpacing: 5.0,
                    children: [
                     // for(int i = 0; i <= ic; i++)
                      ic >= 1 ? Text(
                        snapshot.data![0]["nom"].toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ) :SizedBox(),
                      ic > 1 ? Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                        size: 20,
                      ) : SizedBox(),
                      ic >= 2 ? Text(
                        snapshot.data![1]["nom"].toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ) :SizedBox(),
                      ic > 2 ? Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                        size: 15,
                      ) :SizedBox(),
                      ic >= 3 ? Text(
                        snapshot.data![2]["nom"].toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ) :SizedBox(),
                      // Text(
                      //   'Documentaire',
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //     fontSize: 15,
                      //   ),
                      // ),
                      // Icon(
                      //   Icons.arrow_right,
                      //   color: Colors.white,
                      //   size: 15,
                      // ),
                      // Text(
                      //   'Histoire',
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //     fontSize: 15,
                      //   ),
                      // ),
                    ],
                  ),
                );
              }else{
                return Text("");
              }
            }
        )
      ],
    );
  }

  description() {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Description',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'PopBold',
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        //border: Border.all(color: Colors.white)
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Center(
                        child: Text(
                          widget.film['langue'].toString().toUpperCase(),
                          style: TextStyle(
                            color: secondcolor,
                            fontSize: 14,
                            fontFamily: 'PopRegular',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      widget.film['qualite'].toString().toUpperCase(),
                      style: TextStyle(
                        color: secondcolor,
                        fontSize: 14,
                        fontFamily: 'PopRegular',
                      ),
                    ),
                  ],
                )
              ],
            )),
        SizedBox(
          height: 20,
        ),
        Container(
            padding: EdgeInsets.only(left: 15, right: 10),
            width: double.infinity,
            child: Text(
              widget.film['description'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
                fontFamily: 'PopRegular'
              ),
              textAlign: TextAlign.justify,
            )),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date de sortie:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'PopBold',
                ),
              ),
              Text(
                widget.film['date_de_sortie'],
                style: TextStyle(
                  color: secondcolor,
                  fontSize: 14,
                  fontFamily: 'PopRegular',
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  episode(item){
    return Container(
      child: ListTile(
        title: Text(
          item["nom"] + ':  ' + item["titre"],
              maxLines: 1,
              softWrap: true,
              style: TextStyle(
                fontFamily: 'PopRegular',
                overflow: TextOverflow.ellipsis,
                fontSize: 14,
                color: Colors.white
              ),
            ),
        // title:  Row(
        //   children: [
        //     Text(
        //        item["nom"] + ':  ',
        //       style: TextStyle(
        //           fontFamily: 'PopBold',
        //           color: Colors.white,
        //
        //       ),
        //     ),
        //     Text(
        //       item["titre"],
        //       maxLines: 1,
        //       softWrap: true,
        //       style: TextStyle(
        //         fontFamily: 'PopRegular',
        //         overflow: TextOverflow.ellipsis,
        //         fontSize: 14,
        //         color: Colors.white
        //       ),
        //     ),
        //   ],
        // ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                    'Durée: ',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                  ),
                ),
                Text(
                  item["duree"].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: secondcolor,
                  ),
                ),
              ],
            ),
            Text(
              'HD',
              style: TextStyle(
                  color: Colors.white,
                fontFamily: 'PopRegular'
              ),
            ),
          ],
        ),
        leading: Image.network(
            safariapi.getImage() + widget.film['image'].toString(),
          height: 80,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  myActeur(String imageVal, String heading, String subHeading) {
    return Container(
      width: 150.0,
      child: Card(
        elevation: 20.0,
        color: fisrtcolor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              imageVal,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: TextStyle(
                        color: Colors.white,
                      fontFamily: 'PopRegular'
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    subHeading,
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  listViewActeur() {
    final videoprovider = Provider.of<VideosProviders>(context);
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(left: 20),
            width: double.infinity,
            child: Text(
              'Acteurs',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'PopBold',
                fontSize: 18,
              ),
            )),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 230,
          child: FutureBuilder<List<dynamic>>(
            future: videoprovider.infosMovies(1),
            builder: (context, snapshot){
              if(snapshot.data != null){
                return ListView.builder(
                  padding: EdgeInsets.only(left: 15),
                  scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) => myActeur(safariapi.getPhoto()+snapshot.data![index]["photo"].toString(), snapshot.data![index]['nom'], "nom acteur")
                );
              }else{
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ],
    );
  }

  listViewEpisode(){
    final videoprovider = Provider.of<VideosProviders>(context);
    return Container(
      // height: 500,
      padding: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                  FutureBuilder<List<dynamic>>(
                      future: videoprovider.allSaisons(widget.film["creator_id"]),
                      builder: (context, snapshot){
                        print(snapshot.data);
                        if(snapshot.data != null){
                          print(snapshot.data);
                          return DropdownButton<int>(
                            dropdownColor: fisrtcolor,
                            value: saisonId,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            iconSize: 24,
                            //elevation: 16,
                            underline: Container(
                              height: 1,
                              color: Colors.white,
                            ),
                            onChanged: (e){
                              setState(() {
                                saisonId = e!;
                                print(e);
                              });
                            },
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'PopRegular'
                              // backgroundColor: fisrtcolor,
                            ),
                            items: snapshot.data
                                ?.map((map) {
                              return DropdownMenuItem<int>(
                                value: map['id'],
                                child: Text(map['nom']),
                              );
                            }).toList(),
                          );
                        }else{
                          return SizedBox();
                        }
                      }
                  )
              ],
            ),
          ),
          Container(
              height: 200,
            child: FutureBuilder<List<dynamic>>(
                      future: videoprovider.episodes(saisonId),
                      builder: (context, snapshot){
                        if(snapshot.data != null){
                          return ListView.builder(
                            itemCount: snapshot.data?.length,
                              itemBuilder: (context, index){
                                return episode(snapshot.data![index]);
                              }
                          );
                        }else{
                          return CircularProgressIndicator();
                        }
                      }
                   )
          )
        ],
      ),
    );
  }

  listViewSimilaire(){
    final videoprovider = Provider.of<VideosProviders>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 20),
            width: double.infinity,
            child: Text(
              'Films similaire',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'PopBold',
                fontSize: 18,
              ),
            )),
        SizedBox(
          height: 20,
        ),
        FutureBuilder<List<dynamic>>(
            future: videoprovider.infosMovies(4),
            builder: (context, snapshot){
              if(snapshot.data != null){
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 400.0,
                    initialPage: 0,
                    enlargeCenterPage: true,
                  ),
                  // onPageChanged: (index) {
                  //   setState(() {
                  //     index = 0;
                  //   });
                  // },
                  items: snapshot.data?.map((imgUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                          ),
                          child: Image.network(
                            safariapi.getImage() + imgUrl['image'].toString(),
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              }else{
                return CircularProgressIndicator();
              }
            }
        ),
      ],
    );
  }
}

// class ListViewSimilarMovies extends StatefulWidget {
//   @override
//   _ListViewSimilarMoviesState createState() => _ListViewSimilarMoviesState();
// }
//
// class _ListViewSimilarMoviesState extends State<ListViewSimilarMovies> {
//   List imgList = [
//     'assets/images/movie1.jpg',
//     'assets/images/movie2.jpg',
//     'assets/images/movie3.jpg',
//     'assets/images/movie4.jpg',
//     'assets/images/movie5.jpg',
//     'assets/images/movie6.jpg',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Container(
//               padding: EdgeInsets.only(left: 20),
//               width: double.infinity,
//               child: Text(
//                 'Films similaire',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontFamily: 'PopBold',
//                   fontSize: 18,
//                 ),
//               )),
//           SizedBox(
//             height: 20,
//           ),
//           CarouselSlider(
//             options: CarouselOptions(
//                 height: 400.0,
//                 initialPage: 0,
//                 enlargeCenterPage: true,
//             ),
//             // onPageChanged: (index) {
//             //   setState(() {
//             //     index = 0;
//             //   });
//             // },
//             items: imgList.map((imgUrl) {
//               return Builder(
//                 builder: (BuildContext context) {
//                   return Container(
//                     width: MediaQuery.of(context).size.width,
//                     margin: EdgeInsets.symmetric(horizontal: 10.0),
//                     decoration: BoxDecoration(
//                       color: Colors.green,
//                     ),
//                     child: Image.asset(
//                       imgUrl,
//                       fit: BoxFit.fill,
//                     ),
//                   );
//                 },
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
