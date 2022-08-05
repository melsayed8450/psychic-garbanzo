import 'dart:core';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:cube_timer/solvesPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data.dart';
import 'components/statful_wrapper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';

class TimerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(builder: (context, data, child) {
      return WillPopScope(
        onWillPop: () {
          if (data.stopWatchTimer.isRunning || data.countDownTimer.isRunning) {
            data.onBackButtonPressed();
            return false as Future<bool>;
          } else
            return true as Future<bool>;
        },
        child: Center(
          child: ConfettiWidget(
            blastDirectionality: BlastDirectionality.explosive,
            confettiController: data.controller,
            blastDirection: -pi / 2,
            colors: const [Colors.deepPurple, Colors.white, Colors.yellow],
            gravity: 0.2,
            emissionFrequency: 0.2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                actions: [
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem<int>(
                          value: 0,
                          child: Text("My Solves"),
                        ),
                        PopupMenuItem<int>(
                          value: 1,
                          child: Text("Cubing News"),
                        ),
                      ];
                    },
                    onSelected: (value) async {
                      if (value == 0) {
                        await data.getSolvesListWidget().then(
                          (solves) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SolvesPage(
                                  solveData: solves,
                                ),
                              ),
                            );
                          },
                        );
                      }
                      if (value == 1) {}
                    },
                  ),
                ],
              ),
              body: Container(
                color: Colors.black,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                              right: 8,
                              left: 8,
                            ),
                            child: StatefulWrapper(
                              onInit: () {
                                data.scramblingCube();
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Visibility(
                                    visible: data.scrambleVisible,
                                    child: Text(
                                      data.scrambleValue,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        letterSpacing: 3,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 60),
                                    child: Visibility(
                                      visible: data.countDownVisible,
                                      child: Text(
                                        'INSPECTION',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: StreamBuilder<int>(
                            stream: data.countDownTimer.secondTime,
                            initialData: data.countDownTimer.secondTime.value,
                            builder: (context, snap) {
                              final countDownValue = snap.data;
                              data.changeWarnText(countDownValue!);
                              return StreamBuilder<int>(
                                stream: data.stopWatchTimer.rawTime,
                                initialData: 0,
                                builder: (context, snap) {
                                  final stopWatchValue = snap.data;
                                  data.solveTime = (stopWatchValue! / 1000)
                                      .toStringAsFixed(2);
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Visibility(
                                        child: AnimatedDefaultTextStyle(
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: data.timerSize,
                                            decoration: TextDecoration.none,
                                          ),
                                          textAlign: TextAlign.center,
                                          duration: Duration(milliseconds: 500),
                                          child: Stack(
                                            children: [
                                              Visibility(
                                                visible: data.stopWatchVisible,
                                                child: Text(
                                                  (stopWatchValue / 1000)
                                                      .toStringAsFixed(2),
                                                ),
                                              ),
                                              Visibility(
                                                visible: data.countDownVisible,
                                                child: Text(
                                                  countDownValue.toString(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Expanded(
                            flex: 6,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    data.warningText,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 60,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Visibility(
                                    visible: data.averagesVisible,
                                    child: Container(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FutureBuilder<int>(
                                                  future: data.getCount(),
                                                  builder: (context,
                                                      AsyncSnapshot<int>
                                                          snapshot) {
                                                    if (snapshot.data != 0) {
                                                      return Text(
                                                        'Count : ${snapshot.data} ',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25,
                                                        ),
                                                      );
                                                    } else {
                                                      return Text(
                                                        'Count : - ',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25,
                                                        ),
                                                      );
                                                    }
                                                  }),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              FutureBuilder<double>(
                                                  future: data.getPb(),
                                                  builder: (context,
                                                      AsyncSnapshot<double>
                                                          snapshot) {
                                                    if (snapshot.data != 0) {
                                                      return Text(
                                                        'Best : ${snapshot.data} ',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25,
                                                        ),
                                                      );
                                                    } else {
                                                      return Text(
                                                        'Best : - ',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25,
                                                        ),
                                                      );
                                                    }
                                                  }),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              FutureBuilder(
                                                  future: data.averageof(5),
                                                  builder: (context,
                                                      AsyncSnapshot snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                        'ao5 : ${snapshot.data} ',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25,
                                                        ),
                                                      );
                                                    } else {
                                                      return Text(
                                                        'ao5 : - ',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25,
                                                        ),
                                                      );
                                                    }
                                                  }),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              FutureBuilder(
                                                  future: data.averageof(50),
                                                  builder: (context,
                                                      AsyncSnapshot snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                        'ao50 : ${snapshot.data} ',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25,
                                                        ),
                                                      );
                                                    } else {
                                                      return Text(
                                                        'ao50 : - ',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25,
                                                        ),
                                                      );
                                                    }
                                                  }),
                                            ],
                                          ),
                                          SvgPicture.string(
                                            data.svg,
                                            height: 200,
                                            width: 200,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        data.pressAction();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
