import 'package:dio/dio.dart';

class ScrambleGenerator {
  static Future<String> getScramble() async {
    Response response = await Dio().get(
      'https://scrambler-api.herokuapp.com/3x3x3',
      options: Options(
        headers: {
          "Access-Control-Allow-Credentials":
              true, // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
          "Access-Control-Allow-Methods": "GET"
        },
      ),
    );
    return response.data[0];
  }
}
