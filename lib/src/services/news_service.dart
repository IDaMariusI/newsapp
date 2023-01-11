import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:newsapp/src/models/models.dart';

//final _urlNews = 'https://newsapi.org/v2';
//final _apiKey = '2674fe016d4140c3acfab0926ffa96b6';

const String _baseUrl = 'newsapi.org';
const String _apiKey = '2674fe016d4140c3acfab0926ffa96b6';
const String _country = 'mx';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  NewsService() {
    getTopHeadlines();
  }

  getTopHeadlines() async {
    //final url = Uri.http(_urlNews, '/top-headlines?apiKey=$_apiKey&country=mx');
    var url = Uri.https(_baseUrl, 'v2/top-headlines', {
      'apiKey': _apiKey,
      'country': _country,
    });

    final resp = await http.get(url);

    final newsResponse = newsReponseFromMap(resp.body);

    //headlines.addAll(newsResponse.articles);
    if (newsResponse!.articles!.isNotEmpty) {
      for (var element in newsResponse.articles!) {
        headlines.add(element!);
      }
    }

    notifyListeners();
  }
}
