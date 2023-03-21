import 'package:flutter/material.dart';
import 'package:news_app/theme/theme.dart';

import '../models/news_models.dart';

class ListNews extends StatelessWidget {
  final List<Article> articles;
  const ListNews({
    super.key,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (BuildContext context, int index) {
        return _News(news: articles[index], index: index);
      },
    );
  }
}

class _News extends StatelessWidget {
  final Article news;
  final int index;

  const _News({
    super.key,
    required this.news,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBarCard(
          news: news,
          index: index,
        ),
        _CardTitle(news: news),
        _CardImage(news: news),
      ],
    );
  }
}

class _TopBarCard extends StatelessWidget {
  final Article news;
  final int index;

  const _TopBarCard({
    super.key,
    required this.news,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${index + 1}. ',
            style: TextStyle(color: myTheme.colorScheme.secondary),
          ),
          Text('${news.source.name}. '),
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final Article news;

  const _CardTitle({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        news.title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  final Article news;

  const _CardImage({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: const Text(
        'Image here',
      ),
    );
  }
}
