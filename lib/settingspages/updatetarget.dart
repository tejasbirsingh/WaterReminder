import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterreminder/CustomPaint.dart';
import 'package:waterreminder/Pages/Setting.dart';
import 'package:waterreminder/Pages/TimerPage.dart';
import 'package:waterreminder/Routes.dart';

class updateGoal extends StatefulWidget {
  @override
  _updateGoalState createState() => _updateGoalState();
}

class _updateGoalState extends State<updateGoal> {
  int goal = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        body: Stack(
          children: <Widget>[
            CustomPaint(
              size: MediaQuery.of(context).orientation == Orientation.portrait ? Size(500, 174) : Size(2000,150),
              painter: MyPainter(),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left:18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      SizedBox(height: 40.0,),
                     IconButton(
                       onPressed: (){Navigator.push(context, routeanimation(page: Setting()));} ,
    icon: Icon(Icons.arrow_back,
    color: Colors.white,
    size: 30.0,),
    ),
                    MediaQuery.of(context).orientation == Orientation.portrait ?   SizedBox(height: 110.0,) : SizedBox(height: 70.0,),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 80.0,),
                          Text(
                            '$goal ',
                            style: TextStyle(
                                fontSize: 60.0,
                                color: Theme
                                    .of(context)
                                    .brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            'Litres Per Day',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Theme
                                  .of(context)
                                  .brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20.0,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Glasses(),
                          SizedBox(width: 9.0,),
                          Text('No. of Glasses',
                            style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,

                            ),)
                        ],
                      ),
                      MediaQuery.of(context).orientation == Orientation.portrait ?    SizedBox(height: 35.0,) : SizedBox(height: 5.0,),
                      MediaQuery.of(context).orientation == Orientation.portrait ?  Container(
                          padding: EdgeInsets.only(left: 60, right: 80),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _minusButton(),
                              SizedBox(width: 90.0,),
                              _addButton(),
                            ],
                          )) :  Container(
                          padding: EdgeInsets.only(left: 60, right: 80),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _minusButton(),
                              SizedBox(width: 90.0,),
                              _addButton(),
                              SizedBox(width: 100.0,),
                              MediaQuery.of(context).orientation == Orientation.portrait ? Container() :
                              Padding(
                                  padding: EdgeInsets.only(left: 0.0, top: 0.0),
                                  child: goal != 0 ? _doneButton() : Container())
                            ],
                          )),

                      MediaQuery.of(context).orientation == Orientation.portrait ?       Padding(
                          padding: EdgeInsets.only(left: 270.0, top: 90.0),
                          child: goal != 0 ? _doneButton() : Container()) :
                      Container()
                    ],
                  ),
                ),
              ),
            ),
          ],
        )

    );
  }
  Widget _addButton() {
    return FloatingActionButton(
      onPressed: (){
        setState(() {
          goal +=1;
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
      constraints: BoxConstraints(maxWidth: 60.0,maxHeight: 60.0),
      fillColor:Theme
          .of(context)
          .brightness == Brightness.dark
          ? Colors.blueGrey
          : Colors.white,
      onPressed: goal == 0
          ? null
          : () {
        setState(() {
          goal -= 1;
        });
      },
      child: Icon(
        Icons.remove,
        color: goal == 0 ? Colors.grey : Colors.redAccent,
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
        size: 40.0,
      ),
      shape: CircleBorder(),
      elevation: 2.0,
      fillColor:Theme
        .of(context)
        .brightness == Brightness.dark
        ? Colors.blueGrey
        : Colors.white,
      padding: EdgeInsets.all(15.0),
    );
  }

  _setSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('Goal', goal);
  }

  Widget Glasses(){
    int glass = goal * 1000 ~/ 250;
    return Text(
      "$glass",
      style: TextStyle(
        fontSize: 26.0,
        color: Theme
            .of(context)
            .brightness == Brightness.dark
            ? Colors.white
            : Colors.black,

      ),);
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

