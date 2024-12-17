import 'package:flutter/material.dart';
import 'package:flutternewsapp/usecase/get_top_headlines_use_case.dart';
import 'package:intl/intl.dart';
import 'data/local/database_helper.dart';
import 'data/model/article.dart';
import 'data/model/top_headlines.dart';
import 'constants_text_style.dart';
import 'news_list_stateful_widget.dart';
import '../data/repository/top_headlines_repository.dart';

class DetailScreen extends StatelessWidget {
  final Article article;

  const DetailScreen({super.key, required this.article});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ArticleWidget(
      article: article,
    );
  }
}

class ArticleWidget extends StatefulWidget {
  final Article article;

  const ArticleWidget({super.key, required this.article});

  @override
  State<ArticleWidget> createState() => _ArticleState();
}

class _ArticleState extends State<ArticleWidget> {
  bool _isFavorite = false;

  void _favorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    DatabaseHelper().updateFavoriteState(widget.article.url, _isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(""),
      ),
      body: FutureBuilder<bool>(
        future: DatabaseHelper().getFavoriteState(widget.article.url),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _isFavorite = snapshot.data!;
              });
            });
          }
          return _detailItem();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _favorite,
        backgroundColor: _isFavorite ? Colors.orange : Colors.grey,
        tooltip: 'favorite',
        child: const Icon(Icons.favorite),
      ),
    );
  }

  Widget _detailItem() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.article.source.name,
            style: ConstantsTextStyle.source,
          ),
          Text(
            widget.article.title,
            style: ConstantsTextStyle.title,
          ),
          _publishedAt(widget.article.publishedAt),
          _newsImage(widget.article.urlToImage),
          Text(
            widget.article.description,
            style: ConstantsTextStyle.body,
          ),
        ],
      ),
    );
  }

  Widget _publishedAt(DateTime publishedAt) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          DateFormat('yyyy/MM/dd HH:mm').format(publishedAt),
          textAlign: TextAlign.right,
          style: ConstantsTextStyle.publishedAt,
        ),
      ),
    );
  }

  Widget _newsImage(String url) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          url,
          width: double.infinity,
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
      ),
    );
  }
}
