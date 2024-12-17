import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutternewsapp/data/model/top_headlines.dart';
import 'package:flutternewsapp/data/result/result.dart';
import 'package:flutternewsapp/help_stateful_widget.dart';
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
    return _buildStatus();
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
            title: index == 0
                ? _newsLargeItem(articles[index])
                : _newsSmallItem(articles[index]));
      },
    );
  }

  Widget _newsLargeItem(Article article) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailScreen(
                    article: article,
                  )),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.source.name,
            style: ConstantsTextStyle.source,
          ),
          Text(
            article.title,
            style: ConstantsTextStyle.title,
          ),
          _publishedAt(article.publishedAt, ConstantsTextStyle.publishedAt),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: _newsImage(article.urlToImage, double.infinity),
          ),
        ],
      ),
    );
  }

  Widget _newsSmallItem(Article article) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailScreen(
                    article: article,
                  )),
        );
      },
      child: Column(children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Colors.indigoAccent,
          ),
        ),
        Row(
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
                    _publishedAt(article.publishedAt,
                        ConstantsTextStyle.listPublishedAt),
                  ],
                ),
              ),
            ),
            _newsImage(article.urlToImage, 120.0),
          ],
        ),
      ]),
    );
  }

  Widget _publishedAt(DateTime publishedAt, TextStyle style) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        DateFormat('yyyy/MM/dd HH:mm').format(publishedAt),
        textAlign: TextAlign.right,
        style: style,
      ),
    );
  }

  Widget _newsImage(String url, double width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        url,
        width: width,
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
