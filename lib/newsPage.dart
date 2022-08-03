import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

const String apiKey = '59e49604a67c45fbaa897134fa4ad7cb';

class NewsGenerator {
  static Future<String> getNews() async {
    Response response = await Dio().get(
      'https://newsapi.org/v2/everything?q=tesla&from=2022-06-29&sortBy=publishedAt&apiKey=$apiKey',
      // options: Options(
      //   headers: {
      //     "q": "tesla",
      //     "from": "2022-06-29",
      //     "sortBy": "publishedAt",
      //     "apiKey": "$apiKey",
      //   },
      // ),
    );
    return response.data;
  }
}

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        key: key,
        future: NewsGenerator.getNews(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
