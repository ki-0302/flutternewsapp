import 'package:flutter/material.dart';
import 'package:flutternewsapp/constants_app.dart';
import 'package:flutternewsapp/search_stateful_widget.dart';
import 'package:flutternewsapp/usecase/get_top_headlines_use_case.dart';
import 'package:flutternewsapp/usecase/search_everything_use_case.dart';
import 'package:intl/intl.dart';
import 'data/model/top_headlines.dart';
import 'constants_text_style.dart';
import 'data/repository/everything_repository.dart';
import 'help_stateful_widget.dart';
import 'news_list_stateful_widget.dart';
import '../data/repository/top_headlines_repository.dart';

void main() {
  runApp(const MyAppStatefulWidget());
}

class MyAppStatefulWidget extends StatefulWidget {
  const MyAppStatefulWidget({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyAppStatefulWidget> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [
      NewsListStatefulWidget(
        title: ConstantsApp.appName,
        getTopHeadlinesUseCase: GetTopHeadlinesUseCase(
          TopHeadlinesRepository(),
        ),
      ),
      SearchStatefulWidget(
          searchEverythingUseCase: SearchEverythingUseCase(
              EverythingRepository(),
          ),
      ),
      const HelpStatefulWidget(),
    ];

    return MaterialApp(
      title: ConstantsApp.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        dividerTheme: const DividerThemeData(
          color: Colors.grey,
        ),
      ),
      home: Scaffold
        (
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: Text(ConstantsApp.appName),
        ),
        body: widgets[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help),
              label: 'Help',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme
              .of(context)
              .colorScheme
              .primary,
          onTap
              :
          _onItemTapped
          ,
        ),
      ),
    );
  }
}
