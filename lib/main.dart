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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Article> artilces = [
      Article(
        source: Source(id: "id", name: "source"),
        author: "author",
        title: "title",
        description: "description",
        url: "url",
        urlToImage:
            "https://cdn.myportfolio.com/0daad40c-45e4-42be-8f1e-cee5198d5269/e5b14357-18b5-4d71-b751-8168f349b3e5_rw_1920.jpg?h=868a6b3743f2e0dfc52e01eac2cf353f",
        publishedAt: DateTime.now(),
        content: "content",
      ),
      Article(
        source: Source(id: "id", name: "source2"),
        author: "author",
        title: "title2",
        description: "description",
        url: "url",
        urlToImage:
            "https://cdn.myportfolio.com/0daad40c-45e4-42be-8f1e-cee5198d5269/109c85d9-d0eb-4bdb-b202-3e8255002a73_rw_1920.jpg?h=a9ddefcfff2cbf0ed03091d3f64e3bc4",
        publishedAt: DateTime.now(),
        content: "content",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _buildListView(artilces),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildListView(List<Article> articles) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 0, top: 8, right: 0, bottom: 8),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: _newsItem(articles[index]),
        );
      },
    );
  }

  Widget _newsItem(Article article) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.source.name,
                  style: ConstantsTextStyle.listSource,
                ),
                Text(
                  article.title,
                  style: ConstantsTextStyle.listTitle,
                ),
                _publishedAt(article.publishedAt),
              ],
            ),
          ),
        ),
        _newsImage(article.urlToImage),
      ],
    );
  }

  Widget _publishedAt(DateTime publishedAt) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        DateFormat('yyyy/MM/dd HH:mm').format(publishedAt),
        textAlign: TextAlign.right,
        style: ConstantsTextStyle.listPublishedAt,
      ),
    );
  }

  Widget _newsImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        url,
        width: 120,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      ),
    );
  }
}
