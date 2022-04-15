import 'package:flutter/material.dart';
import 'package:loader_skeleton/loader_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:safarimovie/constantes.dart';
import 'dart:convert';

import '../Providers/videosProvider.dart';

class NotificationPage extends StatefulWidget {
  final List<dynamic> notifications;
  const NotificationPage({
    Key? key,
    required this.notifications
  }) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void dispose() {
    // final videosProviders = Provider.of<VideosProviders>(context, listen: false);
    // videosProviders.readNotification();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //var res =
    print(json.decode(widget.notifications[0][0]['data'])['titre']);
    return Scaffold(
      backgroundColor: fisrtcolor,
      appBar: AppBar(
        backgroundColor: fisrtcolor,
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
      body: ListView.builder(
        itemCount: widget.notifications.length,
          itemBuilder: (context, index) {
            if(widget.notifications != null){
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
                        json.decode(widget.notifications[index][0]['data'])['titre'],
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
                          widget.notifications[index][1].toString(),
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
    );
  }
}
