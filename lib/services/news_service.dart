import 'package:flutter/material.dart';
import 'package:news_app/models/news_models.dart';
import 'package:http/http.dart' as http;

const _URL_NEWS = 'newsapi.org';
const _API_KEY = 'efb2c26a44be461d96ee2e3ad904b89f';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  NewsService() {
    getTopHeadlines();
  }

  getTopHeadlines() async {
    final url = Uri.https(_URL_NEWS, '/v2/top-headlines', {
      'apiKey': _API_KEY,
      'country': 'ca',
    });

    final resp = await http.get(url);

    final newsResponse = NewsResponse.fromJson(resp.body);

    headlines.addAll(newsResponse.articles);

    notifyListeners();
  }
}
