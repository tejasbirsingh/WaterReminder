import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterreminder/CustomPaint.dart';
import 'package:waterreminder/Pages/Tips.dart';
import 'package:waterreminder/Pages/history.dart';
import 'package:waterreminder/Routes.dart';
import 'package:waterreminder/Store.dart';
import 'package:waterreminder/themechanger.dart';
import 'Setting.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  ConfettiController _confettiController;
Animation animation ,statusanim,lanim,ranim;
AnimationController animationController;
  int target = 0,
      targetStreak = 0;
  double waterConsumed = 0.0;
     double progressPercent = 0.0;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  List<stats> record = List<stats>();
  var recordTillNow;
  Timer _timer;
  int notifytime = 1;
  int min = 10;

  int currentAmount = 0;
int _page = 0;
  @override
  void initState() {
    super.initState();
    starttheme();
    _confettiController=ConfettiController(duration: Duration(seconds: 1));

    _retrieveData();
    animationController = AnimationController(duration: Duration(milliseconds: 900),vsync: this);
    animation = Tween(begin: 10.0,end:200.0).animate(CurvedAnimation(parent: animationController, curve: Curves.ease));
statusanim = Tween(begin: 1.0,end:0.0).animate(CurvedAnimation(parent: animationController,curve: Curves.ease));
lanim = Tween(begin: -1.0,end:0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.bounceIn)) ;
ranim = Tween(begin: 1.0,end:0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.bounceIn)) ;

animationController.forward();
  }


  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _confettiController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child){

    return WillPopScope(
      onWillPop: () => _appExit(context),
      child: Scaffold(
        backgroundColor: Theme
            .of(context)
            .brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
bottomNavigationBar: CurvedNavigationBar(
  index: 0,
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
      if(_page == 1){
        Navigator.push(context, routeanimation(page: tipsFile()));
      }
    });
  },

),
        body: Stack(
          children: <Widget>[
            CustomPaint(
              size: MediaQuery.of(context).orientation == Orientation.portrait ? Size(500, 174) : Size(2000,150),
              painter: MyPainter(),
            ),
           MediaQuery.of(context).orientation==Orientation.portrait ?
           ListView(
             physics: BouncingScrollPhysics(),
             children: <Widget>[

               Padding(
                 padding: const EdgeInsets.only(left: 14.0,top: 42.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                     waterConsumedText(),
                     SizedBox(height: 45.0,),
                     circularIndicator(),

                     _addingItems(),
                     SizedBox(height: 27.0,),
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Transform(
                           transform: Matrix4.translationValues(0.0, statusanim.value * height, 0.0),
                           child: Column(
                             children: <Widget>[
                               Container(
                                 height: 100.0,
                                 width: 100.0,

                                 decoration: BoxDecoration(
                                     gradient: LinearGradient(
                                         colors: [
                                           Colors.blue.shade500,
                                           Colors.blue.shade200
                                         ]
                                     ),

                                     borderRadius: BorderRadius.circular(200.0),
                                     boxShadow: [BoxShadow(
                                         blurRadius: 3.0,
                                         spreadRadius: 3.0,
                                         color: Colors.blue.withOpacity(0.5)
                                     )
                                     ]
                                 ),
                                 child: Padding(
                                   padding: const EdgeInsets.only(left:18.0,top: 29.0),
                                   child: Text(
                                     "${(waterConsumed).toStringAsFixed(1)}L",
                                     style: TextStyle(
                                         color: Colors.black45,
                                         fontSize: 37.0
                                     ),
                                   ),
                                 ),

                               ),
                               SizedBox(height: 10.0,),
                               Text('Total Water \n Consumed',
                                 style: TextStyle(
                                     fontSize: 20.0
                                 ),),
                             ],
                           ),
                         ),
                         SizedBox(width: 64.0,),
                         Transform(
                           transform: Matrix4.translationValues(0.0,statusanim.value * height, 0.0),
                           child: Column(
                             children: <Widget>[
                               Container(
                                 height: 100.0,
                                 width: 100.0,
                                 child:  Padding(
                                   padding: const EdgeInsets.only(top:28.0,left: 35.0),
                                   child: Text('$targetStreak',
                                     style: TextStyle(
                                         fontSize: 40.0,
                                         color: Colors.black45
                                     ),),
                                 ),


                                 decoration: BoxDecoration(
                                     gradient: LinearGradient(
                                         colors: [
                                           Colors.blue.shade200,
                                           Colors.blue.shade500
                                         ]
                                     ),

                                     borderRadius: BorderRadius.circular(200.0),
                                     boxShadow: [BoxShadow(
                                         blurRadius: 3.0,
                                         spreadRadius: 3.0,
                                         color: Colors.blue.withOpacity(0.5)
                                     )
                                     ]
                                 ),
                               ),
                               SizedBox(height: 10.0,),
                               Text(
                                 '    Streak \n Continued',
                                 style: TextStyle(
                                     fontSize: 20.0

                                 ),
                               ),

                             ],
                           ),
                         ),

                       ],
                     ),

                   ],
                 ),
               ),

             ],
           )
: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Padding(
                 padding: const EdgeInsets.only(top:48.0,left:250.0),
                 child: waterConsumedText(),
               ),
               SizedBox(height: 50.0,),
             Row(
               children: <Widget>[

                 Padding(
                   padding: const EdgeInsets.only(left:18.0,top:5.0),
                   child: circularIndicator(),
                 ),
                 SizedBox(width: 20.0,),

                     Transform(
                       transform: Matrix4.translationValues(0.0, statusanim.value * height, 0.0),
                       child: Column(
                         children: <Widget>[
                           Container(
                             height: 80.0,
                             width: 80.0,

                             decoration: BoxDecoration(
                                 gradient: LinearGradient(
                                     colors: [
                                       Colors.blue.shade500,
                                       Colors.blue.shade200
                                     ]
                                 ),

                                 borderRadius: BorderRadius.circular(200.0),
                                 boxShadow: [BoxShadow(
                                     blurRadius: 3.0,
                                     spreadRadius: 3.0,
                                     color: Colors.blue.withOpacity(0.5)
                                 )
                                 ]
                             ),
                             child: Padding(
                               padding: const EdgeInsets.only(left:18.0,top: 25.0),
                               child: Text(
                                 "${(waterConsumed).toStringAsFixed(1)}L",
                                 style: TextStyle(
                                     color: Colors.black45,
                                     fontSize: 25.0
                                 ),
                               ),
                             ),

                           ),
                           SizedBox(height: 10.0,),
                           Text('Total Water \n Consumed',
                             style: TextStyle(
                                 fontSize: 18.0
                             ),),
                         ],
                       ),
                     ),
                     SizedBox(width: 40.0,),
                     Transform(
                       transform: Matrix4.translationValues(0.0,statusanim.value * height, 0.0),
                       child: Column(
                         children: <Widget>[
                           Container(
                             height: 80.0,
                             width: 80.0,
                             child:  Padding(
                               padding: const EdgeInsets.only(top:28.0,left: 35.0),
                               child: Text('$targetStreak',
                                 style: TextStyle(
                                     fontSize: 25.0,
                                     color: Colors.black45
                                 ),),
                             ),


                             decoration: BoxDecoration(
                                 gradient: LinearGradient(
                                     colors: [
                                       Colors.blue.shade200,
                                       Colors.blue.shade500
                                     ]
                                 ),

                                 borderRadius: BorderRadius.circular(200.0),
                                 boxShadow: [BoxShadow(
                                     blurRadius: 3.0,
                                     spreadRadius: 3.0,
                                     color: Colors.blue.withOpacity(0.5)
                                 )
                                 ]
                             ),
                           ),
                           SizedBox(height: 10.0,),
                           Text(
                             '    Streak \n Continued',
                             style: TextStyle(
                                 fontSize: 18.0

                             ),
                           ),

                         ],
                       ),
                     ),
                 SizedBox(width: 70.0,),
                 Padding(
                   padding: const EdgeInsets.only(right: 40.0),
                   child: _addingItemsLandscape(),
                 ),


               ],
             )
             ],
           ),
      Align(
        alignment: Alignment.center,

      child: ConfettiWidget(
        confettiController: _confettiController,
        blastDirection: pi/2,
        emissionFrequency: 0.05,
        numberOfParticles: 10,
      ),
      ),




          ],


        )
        ,
      )
      ,
    );});
  }

  Widget circularIndicator()
  {
    return   CircularPercentIndicator(
      radius: 220.0,
      animation: true,
      progressColor: Colors.green,
      animationDuration: 1800,
      lineWidth: 10.0,
      percent:progressPercent,
      circularStrokeCap: CircularStrokeCap.butt,
      backgroundColor: Colors.transparent,
      arcBackgroundColor: Theme
          .of(context)
          .brightness == Brightness.dark
          ? Colors.white
          : Colors.grey.withOpacity(0.3),

      arcType: ArcType.FULL,
      center: Column(
        children: <Widget>[
          SizedBox(height: 75.0,),
          Text(
            '  $currentAmount ml',
            style: TextStyle(

              fontWeight: FontWeight.bold,
              fontSize: 30.0,

              color: Theme
                  .of(context)
                  .brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          SizedBox(height: 7.0,),
          Text('/ $target ml',
            style: TextStyle(
                color: Theme
                    .of(context)
                    .brightness == Brightness.dark
                    ? Colors.white
                    : Colors.grey,
                fontSize: 20.0
            ),)
        ],
      ),

    );
  }
  Future<bool> _appExit(BuildContext context) {
    return showDialog(context: context,
        builder:(BuildContext context){
return AlertDialog(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
  ),
  elevation: 4.0,
  title: Text('Want to exit?',style: TextStyle(
    color: Theme
        .of(context)
        .brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
  ),),
  actions: <Widget>[
    RaisedButton(
      onPressed: () => Navigator.of(context).pop(false),
      child: Text('No',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),),
    ),
    RaisedButton(
      onPressed: () => exit(0),
      child: Text('Yes',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),),
    )
  ],
  backgroundColor: Theme
      .of(context)
      .brightness == Brightness.dark
      ? Colors.black.withOpacity(0.5)
      : Colors.white,

);
        }
    ) ??
        false;
  }


  _retrieveData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    int goal = pref.getInt('Goal');
    int streak = pref.getInt('Streak');
    String dataRecord = pref.getString('Records');
    int timer = pref.getInt('Delay');
int minu = pref.getInt('Min');

    setState(() {
      if (dataRecord != null) {
        record = recordListparse(dataRecord);
        recordTillNow = dataRecord.split('\n');
        recordTillNow.removeLast();
        record.forEach((_record) {
          waterConsumed += (_record.intake / 1000);
        });
      }
      else {
        record.add(stats(DateTime.now(), 0));
        updaterecord(record);
      }
    });
    setState(() {
      targetStreak = streak;
      target = goal * 1000;
      notifytime = timer;
      min = minu;
      currentAmount = getTodayFromRecordList(record).intake;
      if (currentAmount > target ) {
        progressPercent = 1.0;
        targetStreak = 1;

      }
      else {
        progressPercent = currentAmount / target;
        targetStreak = 0;
      }
    });
    previousData();

  }

  void updaterecord(List<stats> recordList) async {
    String recordAsString = dataInString(recordList);

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('Streak', targetStreak);
    pref.setString('Records', recordAsString);
    pref.commit();
  }

  void streakinfo() {
    targetStreak = 0;
    record.forEach((record1) {
      setState(() {
        if (record1.intake >= target) {

          targetStreak += 1;


        }
        else {
          targetStreak = 0;
        }
      });
    });
  }

  _notificationTimer() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    var initSetting = InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initSetting);
    var scheduledNotificationDateTime =
    DateTime.now().add(Duration(hours: notifytime, minutes:min ));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description',
    importance: Importance.High,
      priority: Priority.High,


    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0, "It's Too Hot ! Stay Hydrated",
        "Compelete Your Today's Goal", scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  Widget _addingItems() {
    double width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(lanim.value * width, 0.0, 0.0),
            child: _addEntryButton(100, "images/onezerozero.svg")),
    SizedBox(width: 20.0,),
        Transform(
            transform:Matrix4.translationValues(ranim.value * width, 0.0, 0.0),
            child: _addEntryButton(250, "images/twozerozero.svg"),),


      ],
    );
  }
Widget _addingItemsLandscape() {
  double width = MediaQuery.of(context).size.width;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Transform(
          transform: Matrix4.translationValues(ranim.value * width, 0.0, 0.0),
          child: _addEntryButton(100, "images/onezerozero.svg")),
      SizedBox(height: 20.0,),
      Transform(
        transform:Matrix4.translationValues(ranim.value * width, 0.0, 0.0),
        child: _addEntryButton(250, "images/twozerozero.svg"),),


    ],
  );
}

  Widget _addEntryButton(int ml, String svg) {
    return Container(
        height: 70,
        width: 70,
        child: RawMaterialButton(
                    shape: CircleBorder(),
          elevation: 8.0,
          fillColor:  Theme
            .of(context)
            .brightness == Brightness.dark
            ? Colors.blueGrey
            : Colors.white,
          padding: EdgeInsets.all(15.0),
          onPressed: () {
            setState(() {
              waterConsumed += ml / 1000;
              currentAmount += ml;

              if (currentAmount > target) {
                progressPercent = 1.0;
                setState(() {
                  targetStreak = 1;
                });
              } else {
                progressPercent = currentAmount/ target;
              }
              record = addtodayData(currentAmount, record);

              updaterecord(record);
            });

            _notificationTimer();
          },
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                "$svg",
                height: 29,
                width: 27,
                color: Theme
                    .of(context)
                    .brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
SizedBox(height: 2.0,),
              Text(
                "$ml ml",
                style: TextStyle(
                    fontSize: 8, color:  Theme
                    .of(context)
                    .brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,),
              )
            ],
          ),
        ));
  }

  List<Widget> previousData() {
    List<Widget> Stats = [];

    record.forEach((record1) {
      Stats.add(Row(
        children: <Widget>[
          Text(
            '${record1.date.day <= 7
                ? '0' + record1.date.day.toString()
                : record1
                .date.day}/${record1.date.month <= 7 ? '0' +
                record1.date.month.toString() : record1.date.month}/${record1
                .date
                .year} ',
            style: TextStyle(
              fontSize: 13.0,
            ),
          ),
          Spacer(),
          Text(
            '${record1.intake / 1000} litres ',
            style: TextStyle(
              fontSize: 13.0,

            ),
          ),

        ],
      ));
    });
    return Stats.reversed.toList();
  }
starttheme() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  changeTheme _themeChanger1 = Provider.of<changeTheme>(
      context);
  int theme = pref.getInt('Theme');
  if(theme == 1){

    _themeChanger1.setTheme(ThemeData.dark());
  }
  else{
    _themeChanger1.setTheme(ThemeData.light());
  }
}
Widget waterConsumedText(){
    return   Text('Water Consumed',
      style: TextStyle(
          color: Colors.white,
          fontSize: 26.0,
          fontWeight: FontWeight.bold
      ),);

}
}