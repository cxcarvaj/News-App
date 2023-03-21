import 'package:flutter/material.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/widgets/list_news.dart';
import 'package:provider/provider.dart';

class TabOnePage extends StatelessWidget {
  const TabOnePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: ListNews(articles: newsService.headlines),
    );
  }
}
