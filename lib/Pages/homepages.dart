import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safarimovie/Pages/homepage.dart';
import 'package:safarimovie/Pages/profilpage.dart';
import 'package:safarimovie/Pages/searchpage.dart';
import 'package:safarimovie/Providers/userProvider.dart';
import 'package:safarimovie/Services/userServeice.dart';
import 'package:safarimovie/constantes.dart';

import 'favoritepage.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  UserService userservice = UserService();
  List<Widget> pages = [];
  int _currentPage = 0;
  late Map<dynamic, dynamic> user;

  @override
  void initState() {
    // TODO: implement initState
    pages = [MyHomePage(), FavoritePage(), SearchPage(), ProfilePage()];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentPage],
      bottomNavigationBar: BottomBar(
        backgroundColor: fisrtcolor,
        selectedIndex: _currentPage,
        onTap: (int index) {
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.home),
            title: Text(
                'Accueil',
              style: TextStyle(
                  fontFamily: 'PopRegular'
              ),
            ),
            activeColor: Colors.white,
          ),
          BottomBarItem(
            icon: Icon(Icons.favorite),
            title: Text(
                'Favories',
              style: TextStyle(
                  fontFamily: 'PopRegular'
              ),
            ),
            activeColor: Colors.white,
            darkActiveColor: Colors.yellow, // Optional
          ),
          BottomBarItem(
            icon: Icon(Icons.search),
            title: Text(
                'Recherche',
              style: TextStyle(
                  fontFamily: 'PopRegular'
              ),
            ),
            activeColor: Colors.white,
            darkActiveColor: Colors.greenAccent.shade400, // Optional
          ),
          BottomBarItem(
            icon: Icon(Icons.person),
            title: Text(
                'Profil',
                style: TextStyle(
                  fontFamily: 'PopRegular'
                ),
            ),
            activeColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
