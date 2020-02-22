import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waterreminder/Pages/HomeScreen.dart';
import 'package:waterreminder/Pages/Setting.dart';
import 'package:waterreminder/Pages/bot.dart';
import 'package:waterreminder/Pages/chatBotPage.dart';
import 'package:waterreminder/Pages/history.dart';
import 'package:waterreminder/Routes.dart';

class tipsFile extends StatefulWidget {
  @override
  _tipsFileState createState() => _tipsFileState();
}

class _tipsFileState extends State<tipsFile> {
  int _page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        backgroundColor: Colors.blue.withOpacity(0.6),


        height: 44.0,
        items: <Widget>[
          Icon(Icons.home, size: 30.0,
            color: Theme
                .of(context)
                .brightness == Brightness.dark
                ? Colors.white
                : Colors.black,),
          Icon(Icons.menu, size: 30.0,
            color: Theme
                .of(context)
                .brightness == Brightness.dark
                ? Colors.white
                : Colors.black,),

          Icon(Icons.history, size: 30.0,
            color: Theme
                .of(context)
                .brightness == Brightness.dark
                ? Colors.white
                : Colors.black,),
          Icon(Icons.settings, size: 30.0,
            color: Theme
                .of(context)
                .brightness == Brightness.dark
                ? Colors.white
                : Colors.black,),
        ],
        color:  Theme
            .of(context)
            .brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        buttonBackgroundColor: Colors.blueAccent.withOpacity(0.7),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index){
          setState(() {
            _page = index;
            if(_page == 3){
              Navigator.push(context, routeanimation(page: Setting()));
            }

            if(_page == 2){
              Navigator.push(context, routeanimation(page: history()));
            }
            if(_page == 0){
              Navigator.push(context, routeanimation(page: HomeScreen()));
            }
          });
        },

      ),
      body: Container(
        child: Center(
          child: Stack(
            children: <Widget>[
              FutureBuilder(
                future: DefaultAssetBundle
                    .of(context)
                    .loadString('lib/json/tips.json'),
                builder: (context, snapshot){
                  var mydata = json.decode(snapshot.data.toString());
                  return ListView.builder(
                    itemCount: mydata == null ? 0 : mydata.length,
                    itemBuilder: (BuildContext context ,  i){
                      return  ListTile(
                        contentPadding: EdgeInsets.all(10.0),

                        trailing:  Icon(Icons.arrow_forward_ios,size: 20.0,),
                        leading:CircleAvatar(
                            backgroundImage: AssetImage(mydata[i]["img"]),
                          ),

                        title: Text(mydata[i]["title"],
                          style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          ),),
                        subtitle: Text(mydata[i]["tip"],
                          style: TextStyle(
                              fontSize: 18.0
                          ),),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  details(mydata[i])
                          ));
                        },
                      );
                    },
                  );
                },
              ),

            ],
          )
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.comment,
            color: Colors.white,),
            onPressed: (){
              Navigator.push(context, routeanimation(page:api()));
            },
          )
        ],
        centerTitle: true,
        title: Text('Tips',style: TextStyle(
          color: Colors.white,
          fontSize: 25.0
        ),),
        backgroundColor:  Theme
          .of(context)
          .brightness == Brightness.dark
          ? Colors.lightBlue.shade800
          : Colors.blue,

        leading: Icon(Icons.backspace, color:  Theme
            .of(context)
            .brightness == Brightness.dark
            ? Colors.lightBlue.shade800
            : Colors.blue,),
      ),

    );
  }
}
class  details extends StatelessWidget {
  details(this.data);
  final data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor:  Theme
            .of(context)
            .brightness == Brightness.dark
            ? Colors.lightBlue.shade800
            : Colors.blue,
        title: Text('Details'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
                decoration: BoxDecoration(

                image: DecorationImage(
                  image: AssetImage(data["img"]),
                  fit: BoxFit.cover
                )
                ),
            ),

          SizedBox(height: 20.0,),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height /2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data["detail"],
                style: TextStyle(
                  fontSize: 20.0
                ),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
