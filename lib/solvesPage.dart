import 'package:flutter/material.dart';
import 'package:cube_timer/timerPage.dart';

class SolvesPage extends StatefulWidget {
  List<Widget> solveData;
  SolvesPage(this.solveData);

  @override
  State<SolvesPage> createState() => SolvesPageState();
}

class SolvesPageState extends State<SolvesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: ListView(
        padding: EdgeInsets.all(15),
        reverse: false,
        children: widget.solveData.reversed.toList(),
      )),
    );
  }
}
