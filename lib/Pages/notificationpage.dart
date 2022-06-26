import 'package:flutter/material.dart';
import 'package:loader_skeleton/loader_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:safarimovie/constantes.dart';
import 'dart:convert';

import '../Providers/videosProvider.dart';

class NotificationPage extends StatefulWidget {
  //final List<dynamic> notifications;
  const NotificationPage({
    Key? key,
    //required this.notifications
  }) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  List<dynamic> notifications = [];
  int pagination = 1;

  allNotification() async{
    final videoprovider = Provider.of<VideosProviders>(context, listen: false);
    List<dynamic> n = await videoprovider.allNotifications(pagination);
    setState(() {
      notifications.addAll(n);
      pagination++;
    });
    print(notifications);
  }
  
  @override
  void initState(){
    super.initState();
    allNotification();
  }
  
  
  @override
  Widget build(BuildContext context) {
    //var res =
    //print(notifications);
    return Scaffold(
      backgroundColor: fisrtcolor,
      appBar: AppBar(
        backgroundColor: fisrtcolor,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.white, size: 24,),
        ),
        title: Text(
          "Centre de notification",
          softWrap: true,
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: false,
        onLoading: () async{
          int p = pagination;
          allNotification();
          if(notifications != []){
            refreshController.loadComplete();
          }else{
            refreshController.loadFailed();
          }
        },
        child: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              if(notifications != []){
                return Card(
                  margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  color: thirdcolor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10, bottom: 5, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage("assets/images/logonoir.png"),
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(height: 10,),
                        Text(
                          json.decode(notifications[index][0]['data'])['titre'],
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PopLight'
                          ),
                          //maxLines: 3,
                        ),
                        SizedBox(height: 10,),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            notifications[index][1].toString(),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontFamily: 'PopRegular',
                                color: Colors.white,
                                fontSize: 13
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }else{
                return DarkCardListSkeleton(
                  isCircularImage: true,
                  isBottomLinesActive: true,
                  length: 10,
                );
              }
            }),
      ),
    );
  }
}
