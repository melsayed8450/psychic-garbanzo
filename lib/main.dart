import 'package:cube_timer/timerPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ChangeNotifierProvider(
        create: (_) => Data(),
        child: Scaffold(
          body: SafeArea(
            child: TimerPage(),
          ),
        ),
      ),
    );
  }
}
