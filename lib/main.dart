import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_app/pages/tabs_page.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        home: const TabsPage(),
      ),
    );
  }
}
