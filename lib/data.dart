import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:confetti/confetti.dart';
import 'components/scramble_generator.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Data extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late ConfettiController controller =
      ConfettiController(duration: const Duration(seconds: 5));

  StopWatchTimer countDownTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromSecond(16),
  );

  StopWatchTimer stopWatchTimer = StopWatchTimer();

  String scrambleValue = ' \n  \n  \n ';
  String? solveTime;
  bool countDownVisible = false;
  bool stopWatchVisible = true;
  Future<bool>? rawData;
  String warningText = '';
  Future<String>? ao5;
  String ao50 = '    ';

  void pressAction() {
    if (!stopWatchTimer.isRunning && !countDownTimer.isRunning) {
      stopWatchVisible = false;
      countDownVisible = true;
      countDownTimer.onExecute.add(StopWatchExecute.start);
      stopWatchTimer.onExecute.add(StopWatchExecute.reset);
      Future.delayed(Duration.zero, () async {
        warningText = '';
      });
      notifyListeners();
    } else if (!stopWatchTimer.isRunning && countDownTimer.isRunning) {
      stopWatchVisible = true;
      countDownVisible = false;
      stopWatchTimer.onExecute.add(StopWatchExecute.start);
      countDownTimer.onExecute.add(StopWatchExecute.stop);
      countDownTimer.onExecute.add(StopWatchExecute.reset);
      Future.delayed(Duration.zero, () async {
        warningText = '';
      });
      notifyListeners();
    } else if (stopWatchTimer.isRunning && !countDownTimer.isRunning) {
      stopWatchTimer.onExecute.add(StopWatchExecute.stop);
      saveSolveData(solveTime.toString(), scrambleValue);
      getScrambleData();
      notifyListeners();
    }
  }

  void changeWarnText(int value) {
    if (value == 5) {
      warningText = 'Hurry Up!';
      notifyListeners();
    }
    if (value == 0) {
      warningText = 'DNF';
      countDownVisible = false;
      stopWatchVisible = true;
      countDownTimer.onExecute.add(StopWatchExecute.reset);
      solveTime = 'DNF';
      saveSolveData(solveTime.toString(), scrambleValue);
      getScrambleData();
      notifyListeners();
    }
  }

  Future<void> saveSolveData(String solveTime, String scramble) async {
    SharedPreferences prefs = await _prefs;
    {
      List<String> oldSolvesTime = prefs.getStringList("solvesTime") ?? [];
      List<String> oldSolvesScramble =
          prefs.getStringList("solvesScramble") ?? [];
      String newSolveTime = solveTime.toString();
      String newSolveScramble = scramble;
      oldSolvesTime.add(newSolveTime);
      prefs.setStringList('solvesTime', oldSolvesTime);
      oldSolvesScramble.add(newSolveScramble);
      prefs.setStringList('solvesScramble', oldSolvesScramble);
      double pb = prefs.getDouble("pb") ?? 0;

      if (pb == 0 && solveTime != 'DNF') {
        prefs.setDouble('pb', double.parse(solveTime));
      } else if (solveTime != 'DNF') {
        if (double.parse(solveTime) < pb) {
          prefs.setDouble('pb', double.parse(solveTime));
          controller.play();
          warningText = 'PB!';
          notifyListeners();
        }
      }
    }
  }

  Future<List<Widget>> getSolvesListWidget() async {
    SharedPreferences prefs = await _prefs;
    List<String> solvesTime = prefs.getStringList("solvesTime") ?? [];
    List<String> solvesScramble = prefs.getStringList("solvesScramble") ?? [];

    return [
      for (int t = 0; t < solvesTime.length; t++)
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
                '${solvesScramble[t]}\n\n${solvesTime[t]}',
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

  Future<double> getPb() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getDouble("pb") ?? 0;
  }

  Future<int> getCount() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getStringList('solvesTime')?.length ?? 0;
  }

  Future<String> averageof(int number) async {
    SharedPreferences prefs = await _prefs;
    List<String>? solves = prefs.getStringList("solvesTime");
    List<double> solvesList = [];
    int dnfTimes = 0;
    double total = 0;
    for (int i = 1; i <= number; i++) {
      if (solves![solves.length - i] == 'DNF') {
        dnfTimes++;
        notifyListeners();
        continue;
      }
      ;
      solvesList.add(double.parse(solves![solves.length - i]));
    }
    if (dnfTimes > number / 5) return 'DNF';
    solvesList.sort();
    for (int i = 1; i <= number / 5; i++) {
      solvesList.removeLast();
    }
    for (int i = 1; i <= (number / 5) - dnfTimes; i++) {
      solvesList.removeAt(0);
    }

    for (double solve in solvesList) {
      total += solve;
    }
    double average = total / (number - (number / 2.5));

    return average.toStringAsFixed(2);
  }

  Future<String> initScrambleData() async {
    String scrambleData = await ScrambleGenerator.getScramble();
    return scrambleData;
  }

  Future<void> getScrambleData() async {
    String scrambleData = await ScrambleGenerator.getScramble();
    scrambleValue = scrambleData;
    notifyListeners();
  }
}
