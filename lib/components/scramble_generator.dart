import 'package:http/http.dart' as http;
import 'dart:convert';

class ScrambleGenerator {
  Future getScramble() async {
    http.Response response =
        await http.get(Uri.parse('https://scrambler-api.herokuapp.com/3x3x3'));

    return await jsonDecode(response.body)[0];
  }
}
