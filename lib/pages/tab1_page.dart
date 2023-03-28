import 'package:flutter/material.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/widgets/list_news.dart';
import 'package:provider/provider.dart';

class TabOnePage extends StatefulWidget {
  const TabOnePage({Key? key}) : super(key: key);

  @override
  State<TabOnePage> createState() => _TabOnePageState();
}

class _TabOnePageState extends State<TabOnePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: (newsService.headlines.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListNews(articles: newsService.headlines),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
