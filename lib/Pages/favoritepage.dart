import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:safarimovie/Api/safariapi.dart';
import 'package:safarimovie/Providers/videosProvider.dart';
import '../constantes.dart';
import 'detail.dart';


class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  SafariApi safariapi = SafariApi();
  @override
  Widget build(BuildContext context) {
    final videoprovider = Provider.of<VideosProviders>(context);
    return Scaffold(
      backgroundColor: fisrtcolor,
      appBar: appBar(),
      body: FutureBuilder<List<dynamic>>(
        future: videoprovider.getAllFavoris(),
        builder: (context, snapshot) {
          if(snapshot.data != null){
            return StaggeredGridView.countBuilder(
              padding: EdgeInsets.all(8),
              itemCount: snapshot.data?.length,
              staggeredTileBuilder: (index) => StaggeredTile.fit(2),
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemBuilder: (context, index) {
                final note = snapshot.data![index];
                return InkWell(
                  onTap: (){
                    dynamic item = videoprovider.returnFilm(snapshot.data![index]);

                    videoprovider.ifSimilaire(snapshot.data![index]['id']);
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(film: item, issimilaire: videoprovider.similaire,)));
                  },
                  child: Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(safariapi.getImage() + note['image'].toString()),
                            fit: BoxFit.cover),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                );
              },
            );
          }else{
            return CircularProgressIndicator();
          }
        }
      )
    );
  }
  appBar() {
    return AppBar(
      elevation: .0,
      title: Text(
        'Favoris',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontFamily: 'PopBold',
        ),
      ),
      //centerTitle: true,
      backgroundColor: fisrtcolor,
    );
  }
}
