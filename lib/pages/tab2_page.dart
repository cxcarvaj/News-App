import 'package:flutter/material.dart';
import 'package:news_app/models/category_models.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/theme/theme.dart';
import 'package:provider/provider.dart';

import '../widgets/list_news.dart';

class TabTwoPage extends StatelessWidget {
  const TabTwoPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _CategoryList(),
            (!newsService.isLoading)
                ? Expanded(
                    child: ListNews(
                      articles: newsService.getArticlesBySelectedCategory,
                    ),
                  )
                : const Expanded(
                    child: Center(
                    child: CircularProgressIndicator(),
                  ))
          ],
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final categoryName = categories[index].name;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(category: categories[index]),
                const SizedBox(height: 5),
                Text(
                  '${categoryName[0].toUpperCase()}${categoryName.substring(1)}',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          category.icon,
          color: (newsService.selectedCategory == category.name)
              ? myTheme.colorScheme.secondary
              : Colors.black54,
        ),
      ),
    );
  }
}
