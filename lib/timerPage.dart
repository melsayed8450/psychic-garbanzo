import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'components/scramble_generator.dart';
import 'package:cube_timer/solvesPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  StopWatchTimer stopWatchTimer = StopWatchTimer();
  String scrambleValue = ' \n  \n  \n ';
  ScrambleGenerator scrambleGenerator = ScrambleGenerator();
  String? solveTime;
  bool countDownVisible = false;
  bool stopWatchVisible = true;
  List<Widget> solveData = [];
  Future<bool>? rawData;

  StopWatchTimer countDownTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromSecond(16),
  );

  Future<void> saveSolveData(String solveTime, String scramble) async {
    final SharedPreferences prefs = await _prefs;
    this.setState(() {
      rawData =
          prefs.setString('solveData', '${solveTime}\n\n${scrambleValue}\n');
    });
  }

  Future<String?> readSolveData() async {
    final SharedPreferences prefs = await _prefs;
    final contents = prefs.getString('solveData');
    return contents;
  }

  void printReadData() async {
    print(await readSolveData());
    print(solveDataUpdate().length);
    print(await _prefs.toString());
  }

  void getDataForSolvesPage() async {
    solveData.add(
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
              '${await readSolveData()}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> solveDataUpdate() {
    return solveData;
  }

  void getScrambleData() async {
    String scrambleData = await scrambleGenerator.getScramble();
    this.setState(() {
      scrambleValue = scrambleData;
    });
  }

  @override
  void initState() {
    getScrambleData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: GestureDetector(
        onTap: () {
          this.setState(
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
                getScrambleData();
                saveSolveData(solveTime.toString(), scrambleValue);
                getDataForSolvesPage();
                readSolveData();
                printReadData();
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
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      letterSpacing: 3,
                      decoration: TextDecoration.none),
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
                        return Container(
                          child: Text(
                            value.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              decoration: TextDecoration.none,
                            ),
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
                        return Container(
                            child: Text(
                          (value / 1000).toStringAsFixed(2),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 60,
                            decoration: TextDecoration.none,
                          ),
                        ));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(10),
              width: 100,
              height: 100,
              child: RawMaterialButton(
                elevation: 5,
                shape: new CircleBorder(),
                fillColor: Colors.grey,
                constraints: BoxConstraints.tightFor(
                  width: 100.0,
                  height: 100.0,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SolvesPage(solveData)));
                },
                child: Icon(
                  Icons.api_rounded,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
