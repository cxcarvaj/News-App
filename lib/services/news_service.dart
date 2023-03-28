import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/models/models.dart';
import 'package:http/http.dart' as http;

const _URL_NEWS = 'newsapi.org';
const _API_KEY = 'efb2c26a44be461d96ee2e3ad904b89f';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  Map<String, List<Article>> categoryArticles = {};

  bool _isLoading = true;

  List<Category> categories = [
    Category(name: 'business', icon: FontAwesomeIcons.building),
    Category(name: 'entertainment', icon: FontAwesomeIcons.tv),
    Category(name: 'general', icon: FontAwesomeIcons.addressCard),
    Category(name: 'health', icon: FontAwesomeIcons.headSideVirus),
    Category(name: 'science', icon: FontAwesomeIcons.vials),
    Category(name: 'sports', icon: FontAwesomeIcons.volleyball),
    Category(name: 'technology', icon: FontAwesomeIcons.memory),
  ];

  String _selectedCategory = 'business';

  NewsService() {
    getTopHeadlines();
    for (var category in categories) {
      categoryArticles[category.name] = [];
    }
    getArticlesByCategory(_selectedCategory);
  }

  bool get isLoading => _isLoading;

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;

    _isLoading = true;
    getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article> get getArticlesBySelectedCategory =>
      categoryArticles[selectedCategory]!;

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

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
      return categoryArticles[category];
    }

    final url = Uri.https(_URL_NEWS, '/v2/top-headlines', {
      'apiKey': _API_KEY,
      'country': 'ca',
      'category': category,
    });

    final resp = await http.get(url);

    final newsResponse = NewsResponse.fromJson(resp.body);

    categoryArticles[category]!.addAll(newsResponse.articles);

    _isLoading = false;
    notifyListeners();
  }
}
