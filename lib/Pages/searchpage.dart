import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:safarimovie/Api/safariapi.dart';
import 'package:safarimovie/Providers/videosProvider.dart';
import '../Providers/LanguageChangeProvider.dart';
import '../constantes.dart';
import 'detail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  final searchController = TextEditingController();
  bool isSearch = false;
  bool isValidSearch = false;
  String querySearch = "";
  int pagination = 1;
  List<dynamic> videos = [];
  List<dynamic> videosSearch = [];
  SafariApi safariapi = SafariApi();

  String language = "Français";
  String lang = "";

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

  getAllVideo() async{
    loadLanguage();
    final videoprovider = Provider.of<VideosProviders>(context, listen: false);
    List<dynamic> newvideo = (await videoprovider.selectAllVideo(pagination, lang)).toList();
    setState(() {
      videos.addAll(newvideo);
      pagination++;
    });
    //print(videos);
  }

  getAllResult() async{
    loadLanguage();
    final videoprovider = Provider.of<VideosProviders>(context, listen: false);
    List<dynamic> newvideo = (await videoprovider.selectAllResult(querySearch, lang)).toList();
    setState(() {
      videosSearch.clear();
      videosSearch.addAll(newvideo);
    });
    // print(querySearch);
    // print(videosSearch);
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
    if(searchController.text.isEmpty){
      isValidSearch = false;
      videosSearch.clear();
      searchController.clear();
    }
    bool isListExist = (videos.length > 0);
    bool isListSearchExist = (videosSearch.length > 0) && (isValidSearch == true);
    return Scaffold(
      backgroundColor: fisrtcolor,
      appBar: appBar(),
      body: Column(
        children: [
          searchWidget(),
          Expanded(
              child: isListExist == true
                  ? SmartRefresher(
                      controller: refreshController,
                      enablePullUp: true,
                      enablePullDown: false,
                      onLoading: () async{
                        int p = pagination;
                        getAllVideo();
                        if(videos != []){
                          refreshController.loadComplete();
                        }else{
                          refreshController.loadFailed();
                        }
                      },
                    child: StaggeredGridView.countBuilder(
                        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                        crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        itemCount: isValidSearch == true ? videosSearch.length : videos.length,
                        itemBuilder: (context, index){
                            final video = isValidSearch == true ? videosSearch[index] :videos[index];
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
              ),
                  )
                  : isValidSearch == true && videosSearch.length < 0
              ? Container(
                child: Center(
                  child: Text(
                    "Aucun élément trouvé, votre requête à été enregistrée, vous serez notifiez si nous trouvons un résultat"
                  ),
                )
              ) : Container()
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

  searchWidget(){
    final videoprovider = Provider.of<VideosProviders>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (e) {
            setState(() {
              isSearch = true;
              querySearch = e;
            });
        },
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
                isValidSearch = false;
                isSearch = false;
                videosSearch.clear();
                searchController.clear();
              });
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
                  color: Colors.white
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
          prefixIcon: InkWell(
            onTap: () async{
              await getAllResult();
              isValidSearch = true;
              if(videosSearch.length  <= 0){
                await videoprovider.postSearchRequest(querySearch);
              }
            },
            child: Container(
              margin: EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                color: isSearch == true ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomLeft: Radius.circular(25))
              ),
              child: Icon(Icons.search, color: isSearch == true ? secondcolor : Colors.white,),
            ),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
        ),
      ),
    );
  }
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
