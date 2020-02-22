import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterreminder/CustomPaint.dart';
import 'package:waterreminder/Pages/HomeScreen.dart';
import 'package:waterreminder/Pages/SelectGoal.dart';
import 'package:waterreminder/Pages/Tips.dart';

import 'package:waterreminder/Pages/history.dart';
import 'package:waterreminder/Routes.dart';
import 'package:waterreminder/settingspages/updateTimer.dart';
import 'package:waterreminder/settingspages/updatetarget.dart';
import 'package:waterreminder/themechanger.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> with SingleTickerProviderStateMixin{
  int _page = 0;
int theme = 0;
bool toggleValue = false;
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(duration: Duration(milliseconds: 900),
        vsync: this);

    animation = Tween(begin: -1.0,end:0.0).animate(CurvedAnimation(curve: Curves.fastOutSlowIn,parent: animationController),);
    delayedanimation= Tween(begin: -1.0, end:0.0).animate(CurvedAnimation(curve: Interval(0.2,1.0,curve: Curves.fastOutSlowIn,),parent: animationController));
    muchDelayedAnimation =Tween(begin: -1.0, end:0.0).animate(CurvedAnimation(curve: Interval(0.4,1.0,curve: Curves.fastOutSlowIn),parent: animationController));
    muchMoreDelayedAnimation = Tween(begin: -1.0, end:0.0).animate(CurvedAnimation(curve: Interval(0.7  ,0.9,curve: Curves.fastOutSlowIn),parent: animationController));


  }
  Animation animation , delayedanimation , muchDelayedAnimation, muchMoreDelayedAnimation;
  AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child){
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        index: 3,
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
        animationDuration: Duration(milliseconds: 1000),
        onTap: (index) {
          setState(() {
            _page = index;
            if (_page == 0) {
              Navigator.push(context, routeanimation(page: HomeScreen()));
            }
            if (_page == 2) {
              Navigator.push(context, routeanimation(page: history()));
            }
            if (_page == 1) {
              Navigator.push(context, routeanimation(page:tipsFile()));
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
         MediaQuery.of(context).orientation == Orientation.portrait ?  Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Padding(
               padding:MediaQuery.of(context).orientation == Orientation.portrait ? const EdgeInsets.only(top: 70.0, left: 30.0): EdgeInsets.only(top: 20.0,left:260.0),
               child: Text(
                 'Settings ',
                 style: TextStyle(
                     color: Colors.white,
                     fontSize: 40.0,
                     fontWeight: FontWeight.bold
                 ),
               ),
             ),
             SizedBox(height: 100.0,),
             Transform(
               transform: Matrix4.translationValues(animation.value * width, 0.0,0.0),
               child: Padding(
                 padding: const EdgeInsets.only(left: 12.0),
                 child: GestureDetector(
                   onTap: () {
                     Navigator.push(context, routeanimation(page: updateGoal()));
                   },
                   child: Container(
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20.0),
                         color: Theme
                             .of(context)
                             .brightness == Brightness.dark
                             ? Colors.black
                             : Colors.white,
                         boxShadow: [BoxShadow(
                           color: Theme
                               .of(context)
                               .brightness == Brightness.dark
                               ? Colors.white
                               : Colors.grey.withOpacity(0.4),
                           spreadRadius: 2.0,
                           blurRadius: 4.0,
                         )
                         ]
                     ),

                     height: 50.0,
                     width: 390,
                     child: Row(
                       children: <Widget>[
                         SizedBox(width: 10.0,),
                         Icon(Icons.update,
                           size: 30.0,),
                         SizedBox(width: 80.0,),
                         Text('Update Your Target',
                           style: TextStyle(
                             fontSize: 20.0,
                             color: Theme
                                 .of(context)
                                 .brightness == Brightness.dark
                                 ? Colors.white
                                 : Colors.black,
                           ),),
                       ],
                     ),
                   ),
                 ),
               ),
             ),
             SizedBox(height: 3.0,),
             Transform(
               transform: Matrix4.translationValues(delayedanimation.value * width, 0.0,0.0),
               child: Padding(
                 padding: const EdgeInsets.only(left: 12.0),
                 child: GestureDetector(
                   onTap: () {
                     Navigator.push(
                         context, routeanimation(page: updateTimer()));
                   },
                   child: Container(
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20.0),
                         color: Theme
                             .of(context)
                             .brightness == Brightness.dark
                             ? Colors.black
                             : Colors.white,
                         boxShadow: [BoxShadow(
                           color: Theme
                               .of(context)
                               .brightness == Brightness.dark
                               ? Colors.white
                               : Colors.grey.withOpacity(0.4),
                           spreadRadius: 2.0,
                           blurRadius: 4.0,
                         )
                         ]
                     ),

                     height: 50.0,
                     width: 390,
                     child: Row(
                       children: <Widget>[
                         SizedBox(width: 10.0,),
                         Icon(Icons.notifications_active,
                           size: 30.0,),
                         SizedBox(width: 80.0,),
                         Text('Change Notification Timer',
                           style: TextStyle(
                             fontSize: 20.0,
                             color: Theme
                                 .of(context)
                                 .brightness == Brightness.dark
                                 ? Colors.white
                                 : Colors.black,
                           ),),
                       ],
                     ),
                   ),
                 ),
               ),
             ),
             SizedBox(height: 3.0,),
             Transform(
               transform: Matrix4.translationValues(muchDelayedAnimation.value * width, 0.0,0.0),
               child: Padding(
                 padding: const EdgeInsets.only(left: 12.0),
                 child: GestureDetector(
                   onTap: () {
                     showDialog(
                       context: context,
                       child: AlertDialog(
                         title: Text(
                           'Are Your Sure to reset ?',
                           style: TextStyle(fontSize: 20.0),
                         ),
                         actions: <Widget>[

                           FlatButton(
                             onPressed: () {
                               _resetData();

                             },
                             child: Text(
                               'Yes',
                               style: TextStyle(fontFamily: 'Muli-Bold'),
                             ),
                           ),
                           FlatButton(
                             onPressed: () => Navigator.of(context).pop(false),
                             child: Text(
                               'No',
                               style: TextStyle(fontFamily: 'Muli-Bold'),
                             ),
                           ),
                         ],
                       ),
                     );
                   },
                   child: Container(
                     decoration: BoxDecoration(
                         color: Theme
                             .of(context)
                             .brightness == Brightness.dark
                             ? Colors.black
                             : Colors.white,
                         borderRadius: BorderRadius.circular(20.0),
                         boxShadow: [BoxShadow(
                           color: Theme
                               .of(context)
                               .brightness == Brightness.dark
                               ? Colors.white
                               : Colors.grey.withOpacity(0.4),
                           spreadRadius: 2.0,
                           blurRadius: 4.0,
                         )
                         ]
                     ),

                     height: 50.0,
                     width: 390.0,
                     child: Row(
                       children: <Widget>[
                         SizedBox(width: 10.0,),
                         Icon(Icons.clear_all,
                           size: 30.0,),
                         SizedBox(width: 80.0,),
                         Text('Reset your progress',
                           style: TextStyle(
                             fontSize: 20.0,
                             color: Theme
                                 .of(context)
                                 .brightness == Brightness.dark
                                 ? Colors.white
                                 : Colors.black,
                           ),),
                       ],
                     ),
                   ),
                 ),
               ),
             ),
             SizedBox(height: 3.0,),
             Transform(
               transform: Matrix4.translationValues(muchDelayedAnimation.value * width, 0.0,0.0),
               child: Padding(
                 padding: const EdgeInsets.only(left: 12.0),
                 child: GestureDetector(
                   onTap: () {
                     changeTheme _themeChanger = Provider.of<changeTheme>(
                         context);

                     _themeChanger.setTheme(
                         _themeChanger.getTheme() == ThemeData.dark()
                             ? ThemeData.light()
                             : ThemeData.dark());
                     _themeChanger.getTheme() == ThemeData.dark() ?
                     theme =1 : theme = 0 ;
                     _setSharedPref();
                   },
                   child: Container(
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20.0),
                         color: Theme
                             .of(context)
                             .brightness == Brightness.dark
                             ? Colors.black
                             : Colors.white,
                         boxShadow: [BoxShadow(
                           color: Theme
                               .of(context)
                               .brightness == Brightness.dark
                               ? Colors.white
                               : Colors.grey.withOpacity(0.4),

                           spreadRadius: 2.0,
                           blurRadius: 4.0,
                         )
                         ]
                     ),

                     height: 50.0,
                     width: 390,
                     child: Row(
                       children: <Widget>[
                         SizedBox(width: 10.0,),
                         Icon(Icons.invert_colors,
                           size: 30.0,),
                         SizedBox(width: 80.0,),
                         Padding(
                           padding: const EdgeInsets.only(top: 12.0),
                           child: _theme(context),
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
             ),
             SizedBox(height: 3.0,),

           ],
         ) : Column(

           children: <Widget>[
             Padding(
               padding: EdgeInsets.only(top: 40.0,left:20.0),
               child: Text(
                 'Settings ',
                 style: TextStyle(
                     color: Colors.white,
                     fontSize: 40.0,
                     fontWeight: FontWeight.bold
                 ),
               ),
             ),
             SizedBox(height: 60.0,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[

               Transform(
                 transform: Matrix4.translationValues(animation.value * width, 0.0,0.0),
                 child: Padding(
                   padding: const EdgeInsets.only(left: 12.0),
                   child: GestureDetector(
                     onTap: () {
                       Navigator.push(context, routeanimation(page: updateGoal()));
                     },
                     child: Container(
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20.0),
                           color: Theme
                               .of(context)
                               .brightness == Brightness.dark
                               ? Colors.black
                               : Colors.white,
                           boxShadow: [BoxShadow(
                             color: Theme
                                 .of(context)
                                 .brightness == Brightness.dark
                                 ? Colors.white
                                 : Colors.grey.withOpacity(0.4),
                             spreadRadius: 2.0,
                             blurRadius: 4.0,
                           )
                           ]
                       ),

                       height: 50.0,
                       width: 300,
                       child: Row(

                         children: <Widget>[
                           SizedBox(width: 10.0,),
                           Icon(Icons.update,
                             size: 20.0,),
                           SizedBox(width: 30.0,),
                           Text('Update Your Target',
                             style: TextStyle(
                               fontSize: 18.0,
                               color: Theme
                                   .of(context)
                                   .brightness == Brightness.dark
                                   ? Colors.white
                                   : Colors.black,
                             ),),
                         ],
                       ),
                     ),
                   ),
                 ),
               ),
               Transform(
                 transform: Matrix4.translationValues(delayedanimation.value * width, 0.0,0.0),
                 child: Padding(
                   padding: const EdgeInsets.only(left: 12.0),
                   child: GestureDetector(
                     onTap: () {
                       Navigator.push(
                           context, routeanimation(page: updateTimer()));
                     },
                     child: Container(
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20.0),
                           color: Theme
                               .of(context)
                               .brightness == Brightness.dark
                               ? Colors.black
                               : Colors.white,
                           boxShadow: [BoxShadow(
                             color: Theme
                                 .of(context)
                                 .brightness == Brightness.dark
                                 ? Colors.white
                                 : Colors.grey.withOpacity(0.4),
                             spreadRadius: 2.0,
                             blurRadius: 4.0,
                           )
                           ]
                       ),

                       height: 50.0,
                       width: 300,
                       child: Row(
                         children: <Widget>[
                           SizedBox(width: 10.0,),
                           Icon(Icons.notifications_active,
                             size: 20.0,),
                           SizedBox(width: 30.0,),
                           Text('Change Notification Timer',
                             style: TextStyle(
                               fontSize: 18.0,
                               color: Theme
                                   .of(context)
                                   .brightness == Brightness.dark
                                   ? Colors.white
                                   : Colors.black,
                             ),),
                         ],
                       ),
                     ),
                   ),
                 ),
               ),
             ],

             ),
             SizedBox(height: 20.0,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Transform(
                   transform: Matrix4.translationValues(muchDelayedAnimation.value * width, 0.0,0.0),
                   child: Padding(
                     padding: const EdgeInsets.only(left: 12.0),
                     child: GestureDetector(
                       onTap: () {
                         showDialog(
                           context: context,
                           builder: (BuildContext context){
                            return  AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)
                              ),
                              elevation: 4.0,

                               title: Text(
                                 'Are Your Sure to reset ?',
                                 style: TextStyle(fontSize: 20.0),
                               ),
                               actions: <Widget>[

                                 FlatButton(
                                   onPressed: () {
                                     _resetData();

                                   },
                                   child: Text(
                                     'Yes',
                                     style: TextStyle(fontFamily: 'Muli-Bold'),
                                   ),
                                 ),
                                 FlatButton(
                                   onPressed: () => Navigator.of(context).pop(false),
                                   child: Text(
                                     'No',
                                     style: TextStyle(fontFamily: 'Muli-Bold'),
                                   ),
                                 ),
                               ],
                             );
                           }
                         );
                       },
                       child: Container(
                         decoration: BoxDecoration(
                             color: Theme
                                 .of(context)
                                 .brightness == Brightness.dark
                                 ? Colors.black
                                 : Colors.white,
                             borderRadius: BorderRadius.circular(20.0),
                             boxShadow: [BoxShadow(
                               color: Theme
                                   .of(context)
                                   .brightness == Brightness.dark
                                   ? Colors.white
                                   : Colors.grey.withOpacity(0.4),
                               spreadRadius: 2.0,
                               blurRadius: 4.0,
                             )
                             ]
                         ),

                         height: 50.0,
                         width: 300.0,
                         child: Row(
                           children: <Widget>[
                             SizedBox(width: 10.0,),
                             Icon(Icons.clear_all,
                               size: 20.0,),
                             SizedBox(width: 30.0,),
                             Text('Reset your progress',
                               style: TextStyle(
                                 fontSize: 18.0,
                                 color: Theme
                                     .of(context)
                                     .brightness == Brightness.dark
                                     ? Colors.white
                                     : Colors.black,
                               ),),
                           ],
                         ),
                       ),
                     ),
                   ),
                 ),

                 Transform(
                   transform: Matrix4.translationValues(muchDelayedAnimation.value * width, 0.0,0.0),
                   child: Padding(
                     padding: const EdgeInsets.only(left: 12.0),
                     child: GestureDetector(
                       onTap: () {
                         changeTheme _themeChanger = Provider.of<changeTheme>(
                             context);

                         _themeChanger.setTheme(
                             _themeChanger.getTheme() == ThemeData.dark()
                                 ? ThemeData.light()
                                 : ThemeData.dark());
                         _themeChanger.getTheme() == ThemeData.dark() ?
                         theme =1 : theme = 0 ;
                         _setSharedPref();
                       },
                       child: Container(
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20.0),
                             color: Theme
                                 .of(context)
                                 .brightness == Brightness.dark
                                 ? Colors.black
                                 : Colors.white,
                             boxShadow: [BoxShadow(
                               color: Theme
                                   .of(context)
                                   .brightness == Brightness.dark
                                   ? Colors.white
                                   : Colors.grey.withOpacity(0.4),

                               spreadRadius: 2.0,
                               blurRadius: 4.0,
                             )
                             ]
                         ),

                         height: 50.0,
                         width: 300,
                         child: Row(
                           children: <Widget>[
                             SizedBox(width: 10.0,),
                             Icon(Icons.invert_colors,
                               size: 20.0,),
                             SizedBox(width: 30.0,),
                             Padding(
                               padding: const EdgeInsets.only(top: 12.0),
                               child: _theme(context),
                             ),
                           AnimatedContainer(
                              duration:Duration(milliseconds: 1000),
                              height: 30.0,
                              width: 70.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: toggleValue ? Colors.greenAccent[100] : Colors.redAccent[100].withOpacity(0.5)
                              ),
                              child: Stack(
                                children: <Widget>[
                                  AnimatedPositioned(
                                    duration: Duration(milliseconds: 1000),
                                    curve: Curves.easeIn,
                                    top: 3.0,
                                    left: toggleValue ? 60.0 : 0.0,
                                    right: toggleValue ? 0.0 : 60.0,
                                    child: InkWell(
                                      onTap: toggleButton,
                                      child: AnimatedSwitcher(
                                        duration: Duration(
                                          milliseconds: 1000
                                        ),
                                        transitionBuilder: (Widget child , Animation<double> animation){
                                          return RotationTransition(
                                            child: child,
                                            turns: animation,
                                          );
                                        },
                                        child: toggleValue ? Icon(Icons.check_circle , color: Colors.green,size: 35.0, key: UniqueKey()
                                        ) : Icon(Icons.remove_circle_outline , color: Colors.red,size: 35.0,key: UniqueKey(),),

                                      ) ,
                                    ),
                                  )
                                ],
                              ),
                            )
                           ],
                         ),
                       ),
                     ),
                   ),
                 ),
               ],
             )
           ],
         )
        ],
      ),
    );});
  }

  _resetData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Navigator.push(context, routeanimation(page: selectTheGoal()));
  }

  _setSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('Theme', theme);
  }

  Widget _theme(BuildContext context) {
    changeTheme _themeChanger = Provider.of<changeTheme>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _themeChanger.getTheme() == ThemeData.dark()
              ? modeText('Light Mode')
              : modeText('Dark Mode'),

        ],
      ),
    );

  }

  Widget modeText(String t) {
    return Text(
      "$t",
      style: TextStyle(
        color: Theme
            .of(context)
            .brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        fontSize: 20.0,
      ),
    );
  }



  void toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }
}
