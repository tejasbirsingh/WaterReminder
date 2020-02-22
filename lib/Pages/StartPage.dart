import 'dart:async';
import 'dart:math';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/animation_progress.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';
import 'package:simple_animations/simple_animations/rendering.dart';
import 'package:waterreminder/Pages/SelectGoal.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin {

  @override
  void initState() {

    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ParticleBackgroundApp(),
            Container(
              decoration: BoxDecoration(
                  color: Colors.purple,
                  gradient: LinearGradient(
                      colors: [Colors.blue.withOpacity(0.8),Colors.blue.withOpacity(0.4)],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft
                  )

              ),
            ),
            Column(
        mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:80.0, left:0.0),
                  child: Text(
                    'Water Reminder'
                        ,style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
                SizedBox(height: 10.0,),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 47.0,
                  child: Container(
                    height: 90.0,
                    width: 90.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      image: DecorationImage(
                        image: AssetImage('images/Icon.png')
                      )
                    ),
                  ),
                ),

              ],
            ),
            Padding(
              padding: EdgeInsets.only(top:250.0),
              child: FlareActor(
                'images/load1.flr',
                animation: "Loading",
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            )
          ],
            ),



    );


  }
  Future<Timer> loadData() async {
    return new Timer(Duration(milliseconds:2000), onDoneLoading);
  }
  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => selectTheGoal()));
  }
}
class ParticleBackgroundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Positioned.fill(child: AnimatedBackground()),
      Positioned.fill(child: Particles(30)),

    ]);
  }

}

class Particles extends StatefulWidget {
  final int numberOfParticles;

  Particles(this.numberOfParticles);

  @override
  _ParticlesState createState() => _ParticlesState();
}

class _ParticlesState extends State<Particles> {
  final Random random = Random();

  final List<ParticleModel> particles = [];

  @override
  void initState() {
    List.generate(widget.numberOfParticles, (index) {
      particles.add(ParticleModel(random));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Rendering(
      startTime: Duration(seconds: 30),
      onTick: _simulateParticles,
      builder: (context, time) {
        return CustomPaint(
          painter: ParticlePainter(particles, time),
        );
      },
    );
  }

  _simulateParticles(Duration time) {
    particles.forEach((particle) => particle.maintainRestart(time));
  }
}

class ParticleModel {
  Animatable tween;
  double size;
  AnimationProgress animationProgress;
  Random random;

  ParticleModel(this.random) {
    restart();
  }

  restart({Duration time = Duration.zero}) {
    final startPosition = Offset(-0.2 + 1.4 * random.nextDouble(), 1.2);
    final endPosition = Offset(-0.2 + 1.4 * random.nextDouble(), -0.2);
    final duration = Duration(milliseconds: 3000 + random.nextInt(6000));

    tween = MultiTrackTween([
      Track("x").add(
          duration, Tween(begin: startPosition.dx, end: endPosition.dx),
          curve: Curves.easeInOutSine),
      Track("y").add(
          duration, Tween(begin: startPosition.dy, end: endPosition.dy),
          curve: Curves.easeIn),
    ]);
    animationProgress = AnimationProgress(duration: duration, startTime: time);
    size = 0.2 + random.nextDouble() * 0.4;
  }

  maintainRestart(Duration time) {
    if (animationProgress.progress(time) == 1.0) {
      restart(time: time);
    }
  }
}

class ParticlePainter extends CustomPainter {
  List<ParticleModel> particles;
  Duration time;

  ParticlePainter(this.particles, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withAlpha(50);

    particles.forEach((particle) {
      var progress = particle.animationProgress.progress(time);
      final animation = particle.tween.transform(progress);
      final position =
      Offset(animation["x"] * size.width, animation["y"] * size.height);
      canvas.drawCircle(position, size.width * 0.2 * particle.size, paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 3),
          ColorTween(begin: Colors.blue.shade700, end: Colors.blue.shade200)),
      Track("color2").add(Duration(seconds: 3),
          ColorTween(begin:Colors.blue.shade700, end: Colors.blue.shade200))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [animation["color1"], animation["color2"]])),
        );
      },
    );
  }
}


