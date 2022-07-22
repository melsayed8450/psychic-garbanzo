import 'package:cube_timer/solvesPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'components/scramble_generator.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  StopWatchTimer stopWatchTimer = StopWatchTimer();
  String scrambleValue = ' \n  \n  \n ';
  String? solveTime;
  bool countDownVisible = false;
  bool stopWatchVisible = true;
  Future<bool>? rawData;

  StopWatchTimer countDownTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromSecond(16),
  );

  Future<void> saveSolveData(String solveTime, String scramble) async {
    SharedPreferences prefs = await _prefs;
    setState(
      () {
        List<String> oldSolves = prefs.getStringList("solvesData") ?? [];
        String newSolve = '$scramble/$solveTime';
        oldSolves.add(newSolve);
        prefs.setStringList('solvesData', oldSolves);
      },
    );
  }

  Future<List<Widget>> getSolvesListWidget() async {
    SharedPreferences prefs = await _prefs;
    return [
      for (String solve in prefs.getStringList("solvesData") ?? [])
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '${solve.split('/')[0]}\n\n${solve.split('/')[1]}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        )
    ];
  }

  Future<void> getScrambleData() async {
    String scrambleData = await ScrambleGenerator.getScramble();
    setState(() {
      scrambleValue = scrambleData;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getScrambleData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: GestureDetector(
          onTap: () async {
            setState(
              () {
                if (!stopWatchTimer.isRunning && !countDownTimer.isRunning) {
                  stopWatchVisible = false;
                  countDownVisible = true;
                  countDownTimer.onExecute.add(StopWatchExecute.start);
                  stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                } else if (!stopWatchTimer.isRunning &&
                    countDownTimer.isRunning) {
                  stopWatchVisible = true;
                  countDownVisible = false;
                  stopWatchTimer.onExecute.add(StopWatchExecute.start);
                  countDownTimer.onExecute.add(StopWatchExecute.stop);
                  countDownTimer.onExecute.add(StopWatchExecute.reset);
                } else if (stopWatchTimer.isRunning &&
                    !countDownTimer.isRunning) {
                  stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                  saveSolveData(solveTime.toString(), scrambleValue);
                  getScrambleData();
                }
              },
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                    right: 8,
                    left: 8,
                  ),
                  child: Text(
                    scrambleValue.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      letterSpacing: 3,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  fit: StackFit.expand,
                  children: [
                    Visibility(
                      visible: countDownVisible,
                      child: StreamBuilder<int>(
                        stream: countDownTimer.secondTime,
                        initialData: countDownTimer.secondTime.value,
                        builder: (context, snap) {
                          final value = snap.data;
                          return Text(
                            value.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              decoration: TextDecoration.none,
                            ),
                          );
                        },
                      ),
                    ),
                    Visibility(
                      visible: stopWatchVisible,
                      child: StreamBuilder<int>(
                        stream: stopWatchTimer.rawTime,
                        initialData: 0,
                        builder: (context, snap) {
                          final value = snap.data;
                          solveTime = (value! / 1000).toStringAsFixed(2);
                          return Text(
                            (value / 1000).toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              decoration: TextDecoration.none,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(10),
                width: 100,
                height: 100,
                child: RawMaterialButton(
                  elevation: 5,
                  shape: const CircleBorder(),
                  fillColor: Colors.grey,
                  constraints: const BoxConstraints.tightFor(
                    width: 100.0,
                    height: 100.0,
                  ),
                  onPressed: () async {
                    await getSolvesListWidget().then(
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
                  },
                  child: const Icon(
                    Icons.api_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
