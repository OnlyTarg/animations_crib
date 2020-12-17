import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// It's very simple to use. You can animate everything you want.
// Animation will be forwarding then properties will change and setState() executes
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

class AnimationPage extends State<MyHomePage> {
  Color color = Colors.yellow;
  //double _size = 150;

  void setInitialColor() {
    setState(() {
      color = Colors.yellow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: AnimatedContainer(
          onEnd: () => setInitialColor(),
          height: 200,
          width: 200,
          duration: Duration(seconds: 5),
          color: color,
          child: Center(
              child: Text(
            'Hello friends!!!',
            style: TextStyle(fontSize: 24),
          )),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'Increment',
            child: Icon(Icons.remove),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                color = Colors.red;
              });
            },
            tooltip: 'Increment',
            child: Icon(Icons.color_lens),
          ),
        ],
      ),
    );
  }

/*_setSizeBigger() {
    setState(() {
      _size = _size + 50;
    });
  }

  _setSizeLover() {
    setState(() {
      if (_size > 0) _size = _size - 50;
    });
  }*/
}
