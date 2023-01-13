import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:newsapp/src/models/models.dart';

const String _baseUrl = 'newsapi.org';
const String _apiKey = '2674fe016d4140c3acfab0926ffa96b6';
const String _country = 'mx';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();

    for (var element in categories) {
      categoryArticles[element.name] = List.empty(growable: true);
    }
  }

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;

    getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article>? get getArticlesSelectedCategory =>
      categoryArticles[selectedCategory];

  getTopHeadlines() async {
    var url = Uri.https(_baseUrl, 'v2/top-headlines', {
      'apiKey': _apiKey,
      'country': _country,
    });
    final resp = await http.get(url);

    final newsResponse = newsReponseFromMap(resp.body);

    //.addAll no funcionó porque "newsResponse.articles" es de tipo Iterable<Article>
    //Mientras que "headlines" es de tipo List<Article>
    //headlines.addAll(newsResponse.articles);
    if (newsResponse!.articles!.isNotEmpty) {
      for (var element in newsResponse.articles!) {
        headlines.add(element!);
      }

      notifyListeners();
    }
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }

    var url = Uri.https(_baseUrl, 'v2/top-headlines', {
      'apiKey': _apiKey,
      'country': _country,
      'category': category,
    });
    final resp = await http.get(url);

    final newsResponse = newsReponseFromMap(resp.body);

    //.addAll no funcionó porque "newsResponse.articles" es de tipo Iterable<Article>
    //Mientras que "categoryArticles[category]" es de tipo List<Article>
    //categoryArticles[category].addAll(newsResponse.articles);
    if (newsResponse!.articles!.isNotEmpty) {
      for (var element in newsResponse.articles!) {
        categoryArticles[category]!.add(element!);
      }
    }

    notifyListeners();
  }
}
