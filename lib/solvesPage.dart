import 'package:flutter/material.dart';

class SolvesPage extends StatefulWidget {
  final List<Widget> solveData;
  const SolvesPage({Key? key, required this.solveData}) : super(key: key);

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
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(15),
          reverse: false,
          children: widget.solveData.reversed.toList(),
        ),
      ),
    );
  }
}
