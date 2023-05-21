import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double x = 0;
  double y = 0;
  double scale = 1.0;
  late Offset startingFocalPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned(
                top: y,
                left: x,
                child: Transform.scale(
                  scale: scale,
                  child: GestureDetector(
                    onScaleStart: (detail) {
                      startingFocalPoint = detail.focalPoint;
                    },
                    onScaleUpdate: (detail) {
                      if (detail.pointerCount > 2) {
                        return;
                      }
                      if (detail.pointerCount == 2) {
                        scale = detail.scale;
                        setState(() {});
                        return;
                      }
                      final endingFocalPoint = detail.focalPoint;
                      final distanceTravelled =
                          endingFocalPoint - startingFocalPoint;
                      y = y + distanceTravelled.dy;
                      x = x + distanceTravelled.dx;
                      startingFocalPoint = endingFocalPoint;
                      setState(() {});
                    },
                    child: const FlutterLogo(
                      size: 100,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
