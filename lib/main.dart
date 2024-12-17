import 'package:flutter/material.dart';
import 'package:flutternewsapp/usecase/get_top_headlines_use_case.dart';
import 'package:intl/intl.dart';
import 'data/model/top_headlines.dart';
import 'constants_text_style.dart';
import 'news_list_stateful_widget.dart';
import '../data/repository/top_headlines_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        dividerTheme: const DividerThemeData(
          color: Colors.grey,
        ),
      ),
      home: NewsListStatefulWidget(
        title: 'Flutter News App',
        getTopHeadlinesUseCase: GetTopHeadlinesUseCase(
          TopHeadlinesRepository(),
        ),
      ),
    );
  }
}
