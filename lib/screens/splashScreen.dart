import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puttur_vegetables/screens/vegetableTypes_overviewscreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return VegetableTypesOverViewScreen(
        load: true,
      );
    }));
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // new Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[
          //     Padding(
          //         padding: EdgeInsets.only(bottom: 30.0),
          //         child: new Image.network(
          //           'https://github.com/flutter-devs/flutter_profileview_demo/blob/master/assets/images/powered_by.png?raw=true',
          //           height: 25.0,
          //           fit: BoxFit.scaleDown,
          //         ))
          //   ],
          // ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                'assets/images/cover-removebg.png',
                width: animation.value * 250,
                height: animation.value * 250,
              ),
              Text(
                'PUTTUR\tVEGETABLES',
                style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
