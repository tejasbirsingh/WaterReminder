import 'package:flutter/material.dart';
import 'package:waterreminder/Pages/HomeScreen.dart';
import 'package:waterreminder/Pages/SelectGoal.dart';
import 'package:waterreminder/Pages/Setting.dart';
import 'package:waterreminder/Pages/StartPage.dart';
import 'package:waterreminder/Pages/TimerPage.dart';
import 'package:waterreminder/splashScreen.dart';
import 'package:waterreminder/themechanger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<changeTheme>(
        builder: (_) => changeTheme(ThemeData.light()),
        child: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    super.initState();
    _goalGet();
  }

  bool startpage = false;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<changeTheme>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startpage ? SplashScreen() : StartPage(),
        theme: theme.getTheme(),
        routes: <String, WidgetBuilder>{
          '/homescreen': (BuildContext context) => HomeScreen(),
          '/setting': (BuildContext context) => Setting(),
          '/selecthegoal': (BuildContext context) => selectTheGoal(),
          '/selecthetimer': (BuildContext context) => selectTheTimer(),
        }
    );
  }

  _goalGet() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int target = preferences.getInt('Goal');
    setState(() {
      startpage = target != null;
    });
  }


}
