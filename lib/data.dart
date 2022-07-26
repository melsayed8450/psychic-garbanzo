import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:confetti/confetti.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cuber/cuber.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'components/loading_image.dart';

class Data extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late ConfettiController controller =
      ConfettiController(duration: const Duration(seconds: 5));

  StopWatchTimer countDownTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromSecond(16),
  );

  StopWatchTimer stopWatchTimer = StopWatchTimer();

  String scrambleValue = 'Loading Scramble';
  String? solveTime;
  int? countDown;
  bool countDownVisible = false;
  bool stopWatchVisible = true;
  bool scrambleVisible = true;
  bool averagesVisible = true;
  Future<bool>? rawData;
  String warningText = '';
  Future<String>? ao5;
  String ao50 = '    ';
  double timerSize = 60;
  List<String>? scrambleAlgorithm;

  var scrambleAlgorithmString = StringBuffer();
  String svg = LoadingImage().loadingImage;

  void onBackButtonPressed() async {
    countDownTimer.onExecute.add(StopWatchExecute.stop);
    stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    countDownTimer.onExecute.add(StopWatchExecute.reset);
    stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    stopWatchVisible = true;
    countDownVisible = false;
    scrambleVisible = true;
    averagesVisible = true;
    timerSize -= 50;
    notifyListeners();
  }

  void pressAction() async {
    if (!stopWatchTimer.isRunning && !countDownTimer.isRunning) {
      stopWatchVisible = false;
      countDownVisible = true;
      scrambleVisible = false;
      averagesVisible = false;
      countDownTimer.onExecute.add(StopWatchExecute.start);
      stopWatchTimer.onExecute.add(StopWatchExecute.reset);
      Future.delayed(Duration.zero, () async {
        warningText = '';
      });
      timerSize += 50;
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
      scrambleVisible = true;
      averagesVisible = true;
      await scramblingCube();
      timerSize -= 50;
      notifyListeners();
    }
  }

  void changeWarnText(int value) async {
    if (value == 5) {
      warningText = 'Hurry Up!';
      notifyListeners();
    }
    if (value == 0 && warningText == 'Hurry Up!') {
      warningText = 'DNF';
      timerSize -= 50;
      countDownVisible = false;
      stopWatchVisible = true;
      countDownTimer.onExecute.add(StopWatchExecute.reset);
      solveTime = 'DNF';
      saveSolveData(solveTime.toString(), scrambleValue);
      scrambleVisible = true;
      averagesVisible = true;
      await scramblingCube();
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

  Future<void> getNewScrambleData() async {
    scrambleAlgorithmString.clear();
    Cube scrambledCube = Cube.scrambled();
    scrambleAlgorithm = scrambledCube
        .solve()
        ?.algorithm
        .moves
        .reversed
        .toList()
        .toString()
        .replaceAll('R,', '10,')
        .replaceAll('R\'', '100')
        .replaceAll('L,', '20,')
        .replaceAll('L\'', '200')
        .replaceAll('U,', '30,')
        .replaceAll('U\'', '300')
        .replaceAll('D,', '40,')
        .replaceAll('D\'', '400')
        .replaceAll('B,', '50,')
        .replaceAll('B\'', '500')
        .replaceAll('F,', '60,')
        .replaceAll('F\'', '600')
        .replaceAll('10,', 'R\',')
        .replaceAll('100', 'R')
        .replaceAll('20,', 'L\',')
        .replaceAll('200', 'L')
        .replaceAll('30,', 'U\',')
        .replaceAll('300', 'U')
        .replaceAll('40,', 'D\',')
        .replaceAll('400', 'D')
        .replaceAll('50,', 'B\',')
        .replaceAll('500', 'B')
        .replaceAll('60,', 'F\',')
        .replaceAll('600', 'F')
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(' ', '')
        .split(',');
    scrambleAlgorithm?.forEach((item) {
      scrambleAlgorithmString.write(
        '$item ',
      );
    });
    scrambleValue = scrambleAlgorithmString.toString();
    notifyListeners();
  }

  Future<void> scramblingCube() async {
    await getNewScrambleData();
    Cube cube = Cube.solved;
    for (String move in scrambleAlgorithm!) {
      cube = cube.move(Move.parse(move));
    }

    String credentials = '';
    svg = await cube
        .svg()
        .replaceAll('#FFFF00', '#FFFF01')
        .replaceAll('#FFFFFF', '#FFFF02')
        .replaceAll('#FF9800', '#FFFF03')
        .replaceAll('#F44336', '#FFFF04')
        .replaceAll('#FFFF01', '#FFFFFF')
        .replaceAll('#FFFF02', '#FFFF00')
        .replaceAll('#FFFF03', '#F44336')
        .replaceAll('#FFFF04', '#FF9800');
    credentials = '''${svg}''';
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(credentials);
    String decoded = stringToBase64.decode(encoded);
    svg = decoded;
    notifyListeners();
  }
}
