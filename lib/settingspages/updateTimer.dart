import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterreminder/CustomPaint.dart';
import 'package:waterreminder/Pages/HomeScreen.dart';
import 'package:waterreminder/Pages/Setting.dart';
import 'package:waterreminder/Routes.dart';

class updateTimer extends StatefulWidget {
  @override
  _updateTimerState createState() => _updateTimerState();
}

class _updateTimerState extends State<updateTimer> {
  int timer =0;
  int min = 0;


  @override
  void initState() {
    super.initState();
    _getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      body:Stack(
        children: <Widget>[
          CustomPaint(
            size: MediaQuery.of(context).orientation == Orientation.portrait ? Size(500, 174) : Size(2000,150),
            painter: MyPainter(),
          ),

          Padding(
            padding: const EdgeInsets.only(top:38.0,left: 20.0),
            child: IconButton(
              onPressed: (){Navigator.push(context, routeanimation(page: Setting()));} ,
              icon: Icon(Icons.arrow_back,
                color: Colors.white,
                size: 30.0,),
            ),
          ),
          Padding(
            padding:MediaQuery.of(context).orientation == Orientation.portrait ?  const EdgeInsets.only(top:90.0,left: 5.0): EdgeInsets.only(top: 40.0,left: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                MediaQuery.of(context).orientation == Orientation.portrait ? SizedBox(height: 100.0,) : SizedBox(height: 60.0,),
                Text(
                  '$timer Hr',style: TextStyle(
                  fontSize: 30.0,
                  color: Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _minusButton(),
                    SizedBox(width: 75.0,),
                    _addButton(),
                  ],
                ),
                SizedBox(height: 20.0,),
                MediaQuery.of(context).orientation == Orientation.portrait ? Text(
                  '$min Minutes',style: TextStyle(
                  fontSize: 30.0,
                  color: Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
                ) :
                Row(
                    children: <Widget>[
                      SizedBox(width: 280.0,),
                      Text(
                        '$min Minutes',style: TextStyle(
                        fontSize: 30.0,
                        color: Theme
                            .of(context)
                            .brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                      ),
                      SizedBox(width: 90.0,),

                      min == 0 && timer == 0 ? Container(height: 65) : _doneButton()
                    ]),

SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
                    _minusButtonmin(),
    SizedBox(width: 75.0,),

              _addButtonmin(),
    ],
    ),

                SizedBox(height: 5.0,),
                Padding(
                  padding: const EdgeInsets.only(left:28.0,top: 10.0),
                  child: Text(
                    'Will Notify You After Every $timer Hr and $min Minutes',
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: 20.0
                    ),
                  ),
                ),

              MediaQuery.of(context).orientation == Orientation.portrait ?   Padding(
                  padding:EdgeInsets.only(left: 260.0,top: 80.0),
                  child: min == 0 && timer == 0 ? Container(height: 65) : _doneButton()) :
          Container(),

              ],
            ),
          )
        ],
      ) ,
    );
  }
  _getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int time = prefs.getInt('Delay');
    int minutes = prefs.getInt('Min');
    time = time;
    minutes = minutes;
  }
  Widget _addButton() {
    return FloatingActionButton(heroTag: null,
      onPressed: () {
        setState(() {
          timer += 1;
        });
      },
      child: CustomPaint(
        child: Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200.0),
            color: Theme
                .of(context)
                .brightness == Brightness.dark
                ? Colors.blueGrey
                : Colors.white,
          ),
        ),
        foregroundPainter: FloatingPainter(),
      ),
    );
  }

  Widget _minusButton() {
    return RawMaterialButton(
      constraints:BoxConstraints(maxWidth: 60.0, maxHeight: 60.0) ,
      fillColor:Theme
          .of(context)
          .brightness == Brightness.dark
          ? Colors.blueGrey
          : Colors.white,
      onPressed: timer== 0
          ? null
          : () {
        setState(() {
          timer -= 1;
        });
      },
      child: Icon(
        Icons.remove,
        color: timer == 0 ? Colors.grey : Colors.redAccent,
        size: 30.0,
      ),
      shape: CircleBorder(),
      padding: EdgeInsets.all(15.0),
    );
  }
  Widget _doneButton() {
    return RawMaterialButton(
      onPressed: () async {
        await _setSharedPref();
        Navigator.push(context, routeanimation(page: Setting()));
      },
      child: Icon(
        Icons.check,
        color: Colors.blue,
        size: 35.0,
      ),
      shape: CircleBorder(),
      elevation: 3.0,
      fillColor: Theme
          .of(context)
          .brightness == Brightness.dark
          ? Colors.blueGrey
          : Colors.white,
      padding: EdgeInsets.all(15.0),
    );
  }

  _setSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('Delay', timer);
    await prefs.setInt('Min', min);
  }
  Widget _addButtonmin() {
    return FloatingActionButton(heroTag: null,
      onPressed: () {
        setState(() {
          min += 10;
        });
      },
      child: CustomPaint(
        child: Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200.0),
            color: Theme
                .of(context)
                .brightness == Brightness.dark
                ? Colors.blueGrey
                : Colors.white,
          ),
        ),
        foregroundPainter: FloatingPainter(),
      ),
    );

  }

  Widget _minusButtonmin() {
    return RawMaterialButton(
      constraints: BoxConstraints(maxWidth: 60.0,maxHeight: 60.0),
      fillColor:Theme
          .of(context)
          .brightness == Brightness.dark
          ? Colors.blueGrey
          : Colors.white,
      onPressed: min== 0
          ? null
          : () {
        setState(() {
          min -= 10;
        });
      },
      child: Icon(
        Icons.remove,
        color: min == 0 ? Colors.grey : Colors.redAccent,
        size: 30.0,
      ),
      shape: CircleBorder(),
      padding: EdgeInsets.all(15.0),
    );
  }
}
class FloatingPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint yellow = Paint()..color=Colors.amberAccent..strokeWidth=5;
    Paint greenPaint = Paint()..color=Colors.green..strokeWidth=5;
    Paint bluePaint = Paint()..color=Colors.blue..strokeWidth=5;
    Paint redPaint = Paint()..color=Colors.red..strokeWidth=5;

    canvas.drawLine(Offset(size.width * 0.27, size.height * 0.5),
        Offset(size.width * 0.5 , size.height * 0.5),yellow);

    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.5),
        Offset(size.width * 0.5 , size.height-(size.height * 0.27)), greenPaint);

    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.5),
        Offset(size.width -(size.width * 0.27) , size.height * 0.5), bluePaint);

    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.5),
        Offset(size.width * 0.5 , size.height * 0.27), redPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
  @override
  bool shouldRebuildSemantics(FloatingPainter oldDelegate) => false;

}
