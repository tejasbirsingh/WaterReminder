
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fcharts/fcharts.dart' ;

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterreminder/CustomPaint.dart';
import 'package:waterreminder/Pages/HomeScreen.dart';
import 'package:waterreminder/Pages/Setting.dart';
import 'package:waterreminder/Pages/Tips.dart';
import 'package:waterreminder/Routes.dart';
import 'package:waterreminder/Store.dart';


class history extends StatefulWidget {
  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {
List<double> data = [];
  int _page = 0;
  var recordTillNow;
  List<stats> record = List<stats>();

  @override
  void initState() {

    super.initState();

    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
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
        color: Theme
            .of(context)
            .brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        buttonBackgroundColor: Colors.blueAccent.withOpacity(0.7),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
            if (_page == 0) {
              Navigator.push(context, routeanimation(page: HomeScreen()));
            }
            if (_page == 3) {
              Navigator.push(context, routeanimation(page: Setting()));
            }
            if (_page == 1) {
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
Padding(
  padding: MediaQuery.of(context).orientation ==Orientation.portrait ? EdgeInsets.only(top: 60.0, left: 40.0) : EdgeInsets.only(top: 40.0,left: 270.0),
            child: Text('History',
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),),
    ),
//          Padding(
//            padding: const EdgeInsets.only(top:200.0, left: 50.0),
//            child: Container(
//              decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(20.0),
//                color: Colors.grey
//
//              ),
//              height: 100.0,
//              width: MediaQuery.of(context).size.width - 100.0,
//              child: graph(),
//            ),
//          ),
          Padding(
            padding: MediaQuery.of(context).orientation == Orientation.portrait ? const EdgeInsets.only(top: 190.0, left: 10.0) : EdgeInsets.only(top: 110.0),
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 30, 10, 30),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 420.0,
              child: Card(
                color: Theme
                    .of(context)
                    .brightness == Brightness.dark
                    ? Colors.grey.shade900
                    : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 19.0,),
                        Text('Previous Record',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20.0
                          ),),
                        SizedBox(height: 20.0,),
                        ...history(),



                      ],
                    )),
              ),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  blurRadius: 16.0,
                ),
              ]),
            ),
          ),

        ],
      ),
    );
  }

  List<Widget> history() {
    List<Widget> Stats = [];

    record.forEach((record1) {

      Stats.add(Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '${record1.date.day <= 9
                    ? '0' + record1.date.day.toString()
                    : record1
                    .date.day}/${record1.date.month <= 9 ? '0' +
                    record1.date.month.toString() : record1.date.month}/${record1
                    .date
                    .year} ',

                style: TextStyle(
                  fontSize: 18.0,
                  color: Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Spacer(),

              Text(
                '${record1.intake / 1000} litres ',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Theme
                        .of(context)
                        .brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black

                ),
              ),

            ],
          ),


        ],
      ));
    });
    return Stats.reversed.toList();
  }
//Widget graph(){
//  List<double> a=values();
//  var b = values1();
//  var x = values2();
//  var y = values3();
//    return Container(
//      height: 150.0,
//      width: MediaQuery.of(context).size.width - 100.0,
//child: BarChart(
//  data: b,
//  xAxis:x ,
//  yAxis: y,
//)
////      child:LineChart(
////        lines:[
////          Sparkline(
////            data:a
////          )
////        ]
////      )
//    );
//}



//List<double> values(){
//    List<double> a=[];
//    record.forEach((x){
//      a.add(x.intake.toDouble());
//    });
//    return a;
//}
//values1(){
//  var a =[];
//  record.forEach((x){
//    a.add([x.intake,x.date]);
//  });
//}
//values2(){
//  var a =[];
//  record.forEach((x){
//    a.add(x.intake);
//  });
//}
//values3(){
//  var a =[];
//  record.forEach((x){
//    a.add(x.date);
//  });
//}



  _retrieveData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String dataRecord = pref.getString('Records');

    setState(() {
      if (dataRecord != null) {
        record = recordListparse(dataRecord);
        recordTillNow = dataRecord.split('\n');
        recordTillNow.removeLast();
        record.forEach((_record) {

        });
      }
      else {
        record.add(stats(DateTime.now(), 0));
      }
    });

    history();
   // values();


  }

}

