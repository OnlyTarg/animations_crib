import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


//for me    needed thing: 1. Animation - specify what exactly we want to animate (size,color,scope)
//                        2. AnimationController - specify parameters of animation like duration. Also animController starts and ends we animation.
//                        3. You must initialize animation and animController in initialState. To specify vsync parameters you need add mixin SingleTickerProviderStateMixin
//                        4. Don't forget to dispose controllers

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

    final curveAnimation = CurvedAnimation(parent: animationController,curve: Curves.bounceInOut,reverseCurve: Curves.easeOut);
    animation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(curveAnimation)
      ..addListener(() {
        setState(() {});
      })..addStatusListener((status) {
        if(status == AnimationStatus.completed){
          animationController.reverse();

        } else if(status== AnimationStatus.dismissed){
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
      body: Transform.rotate(
        angle: animation.value,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(30),
          child: FlutterLogo(
            size: _size,
          ),
        ),
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
