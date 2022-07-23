import 'package:dio/dio.dart';

class ScrambleGenerator {
  static Future<String> getScramble() async {
    Response response = await Dio().get(
      'https://scrambler-api.herokuapp.com/3x3x3'
    );
    return response.data[0];
  }
}
