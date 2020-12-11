import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//for me    needed thing: 1. Difference between Animation from scratch that you don't need use setState to do animation and no longer need listener.
// Also flutter rebuild only widget(that you animate), but not whole app
//You need to move part of your code, that used animation and animationcontroller(Transform.rotate in this case), to separate widget
// All mess staff like init state, dispose method remain

//Because you move the AnimationUI to separate widget and extend it from AnimationWidget, you need to put animation to super constructor

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  AnimationPage createState() => AnimationPage();
}

class AnimationPage extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  double _size = 150;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    final curveAnimation = CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceInOut,
        reverseCurve: Curves.easeOut);
    animation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(curveAnimation)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });
    animationController.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FlutterImage(
        animation: animation,
        logoSize: _size,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _setSizeLover,
            tooltip: 'Increment',
            child: Icon(Icons.remove),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: _setSizeBigger,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  _setSizeBigger() {
    setState(() {
      _size = _size + 50;
    });
  }

  _setSizeLover() {
    setState(() {
      if (_size > 0) _size = _size - 50;
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class FlutterImage extends AnimatedWidget {
  final double logoSize;

  FlutterImage({@required Animation<double> animation, @required this.logoSize})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = super.listenable as Animation<double>;

    return Transform.rotate(
      angle: animation.value,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: FlutterLogo(
          size: logoSize,
        ),
      ),
    );
  }
}
