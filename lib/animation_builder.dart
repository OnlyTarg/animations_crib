import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//for me    1. AnimationBuilder usable that you want to use animation to more one widget.
// You must write animationWidget(RotatingTransition in this case), add parameters like a child(widget that will be animated) and in build method
// write AnimationBuilder.
// Then it's done you cane simple add any widget to the RotatingTransition and it'll be do animation
// The cool thing that you animate only RotatingTransition but not a child, that's good to perfomance
// All mess staff in initial state and dispose state remain
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

  double _size = 50;

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
      ..addListener(() {
        setState(() {});
      })
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
      body: RotatingTransition(
        angle: animation,
       child: FlutterImage(_size),
        //child: Center(child: Text('Avdonin Pavel', style: TextStyle(fontSize: _size),)),
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
      _size = _size + 5;
    });
  }

  _setSizeLover() {
    setState(() {
      if (_size > 0) _size = _size - 5;
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class RotatingTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> angle;

  RotatingTransition({@required this.child, @required this.angle});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: angle,
      child: child,
      builder: (context, child) {
        return Transform.rotate(
          angle: angle.value,
          child: child,
        );
      },
    );
  }
}

class FlutterImage extends StatelessWidget {
  final double logoSize;

  FlutterImage(this.logoSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(30),
      child: FlutterLogo(
        size: logoSize,
      ),
    );
  }
}
