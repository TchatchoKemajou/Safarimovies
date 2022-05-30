import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:safarimovie/Api/safariapi.dart';
import 'package:safarimovie/Providers/videosProvider.dart';
import '../constantes.dart';
import 'detail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  bool isSearch = false;
  List<dynamic> videos = [];
  List<dynamic> videosSearch = [];
  SafariApi safariapi = SafariApi();

  getAllVideo() async{
    final videoprovider = Provider.of<VideosProviders>(context, listen: false);
    List<dynamic> newvideo = (await videoprovider.selectAllVideo()).toList();
    setState(() {
      videos = newvideo;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllVideo();
  }

  @override
  Widget build(BuildContext context) {
    final videoprovider = Provider.of<VideosProviders>(context);
    isSearch = (searchController.text.isNotEmpty);
    bool isListExist = (videos.length > 0);
    return Scaffold(
      backgroundColor: fisrtcolor,
      appBar: appBar(),
      body: Column(
        children: [
          searchWidget(),
          Expanded(
              child: isListExist == true
                  ? StaggeredGridView.countBuilder(
                staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                itemCount: isSearch == true ? videosSearch.length : videos.length,
                itemBuilder: (context, index){
                  final video = isSearch == true ? videosSearch[index] :videos[index];
                  return InkWell(
                    onTap: (){
                      dynamic item = videoprovider.returnFilm(video);
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(film: item)));
                    },
                    child: Container(
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(safariapi.getImage() + video['image'].toString()),
                              fit: BoxFit.cover),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  );
                },
              )
                  : Container()
          )
        ],
      )
    );
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  searchFunction(String query){
    setState(() {
      isSearch = true;
    });
    setState(() {
      videosSearch = videos.where((element) {
        return element['titre'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
    // final List<dynamic> newVideoList = videos.where((element) {
    //   return element['titre'].toLowerCase().contains(query.toLowerCase());
    // }).toList();
    // setState(() {
    //   print(newVideoList);
    //   videosSearch = newVideoList;
    // });
  }

  searchWidget(){
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: searchFunction,
        controller: searchController,
        maxLines: 1,
        style: TextStyle(
            color: Colors.white
        ),
        decoration: InputDecoration(
          hoverColor: Colors.white,
          suffixIcon: isSearch == true
          ? InkWell(
            child: Icon(Icons.close, color: secondcolor,),
            onTap: (){
              setState(() {
                isSearch = false;
              });
              searchController.clear();
              FocusScope.of(context).requestFocus(FocusNode());
            },
          )
          : SizedBox(),
          hintText: 'recherche',
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(
                  color: secondcolor
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(
                  color: Colors.white
              )
          ),
          isDense: true,                      // Added this
          contentPadding: EdgeInsets.all(10),
          //hintText: "login",
          prefixIcon: Icon(Icons.search, color: Colors.white,),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
        ),
      ),
    );
  }

  // sedfedfsfs(){
  //   return FutureBuilder<List<dynamic>>(
  //       future: videoprovider.selectAllVideo(),
  //       builder: (context, snapshot) {
  //         if(snapshot.data != null){
  //           return StaggeredGridView.countBuilder(
  //             staggeredTileBuilder: (index) => StaggeredTile.fit(2),
  //             crossAxisCount: 4,
  //             mainAxisSpacing: 4,
  //             crossAxisSpacing: 4,
  //             itemCount: snapshot.data?.length,
  //             itemBuilder: (context, index){
  //               return InkWell(
  //                 onTap: (){
  //                   // dynamic item = videoprovider.returnFilm(snapshot.data![index]);
  //                   //
  //                   // videoprovider.ifSimilaire(snapshot.data![index]['id']);
  //                   // Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(film: item, issimilaire: videoprovider.similaire,)));
  //                 },
  //                 child: Container(
  //                   height: 200,
  //                   width: 150,
  //                   decoration: BoxDecoration(
  //                       image: DecorationImage(
  //                           image: NetworkImage(safariapi.getImage() + snapshot.data![index]['image'].toString()),
  //                           fit: BoxFit.cover),
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.circular(5.0)),
  //                 ),
  //               );
  //             },
  //           );
  //         }else{
  //           return CircularProgressIndicator();
  //         }
  //       });
  // }
  appBar() {
  return AppBar(
    elevation: .0,
    title: Image.asset(
      "assets/images/logo.png",
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.5,
    ),
    //centerTitle: true,
    backgroundColor: fisrtcolor,
  );
}
}
