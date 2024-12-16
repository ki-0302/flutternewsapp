import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutternewsapp/data/model/top_headlines.dart';
import 'package:flutternewsapp/data/result/result.dart';
import 'package:flutternewsapp/usecase/get_top_headlines_use_case.dart';
import 'package:intl/intl.dart';

import 'constants_text_style.dart';
import 'detail_screen.dart';
import 'main.dart';

class NewsListStatefulWidget extends StatefulWidget {
  final GetTopHeadlinesUseCase getTopHeadlinesUseCase;
  final String title;

  const NewsListStatefulWidget(
      {super.key, required this.title, required this.getTopHeadlinesUseCase});

  @override
  NewsListState createState() => NewsListState();
}

class NewsListState extends State<NewsListStatefulWidget> {
  Result<TopHeadlines> _topHeadlines = Loading();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final result = await widget.getTopHeadlinesUseCase.getTopHeadlines();
    setState(() {
      _topHeadlines = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _buildStatus(),
    );
  }

  Widget _buildStatus() {
    switch (_topHeadlines) {
      case Success(data: final data):
        return _buildListView(data.articles);
      case Error(exception: final exception):
        return Text('Error: $exception');
      case Loading():
        return const Text('Loading...');
    }
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(article: article,)),
        );
      },
      child: Row(
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
      ),
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
