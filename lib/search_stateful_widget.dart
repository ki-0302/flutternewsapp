import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternewsapp/data/model/everything.dart';
import 'package:flutternewsapp/usecase/search_everything_use_case.dart';
import 'package:intl/intl.dart';

import 'constants_app.dart';
import 'constants_text_style.dart';
import 'data/model/article.dart';
import 'data/result/result.dart';
import 'detail_screen.dart';

class SearchStatefulWidget extends StatefulWidget {
  final SearchEverythingUseCase searchEverythingUseCase;

  const SearchStatefulWidget(
      {super.key, required this.searchEverythingUseCase});

  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<SearchStatefulWidget> {
  Future<Result<Everything>>? _result;

  void _onSearch(String keyword) {
    setState(() {
      _result = widget.searchEverythingUseCase.searchEverything(keyword);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Input search keyword',
            ),
            onSubmitted: _onSearch,
          ),
        ),
        Expanded(
          child: FutureBuilder<Result<Everything>>(
            future: _result,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _loading();
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return _empty();
              } else {
                return _buildStatus(snapshot.data!);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _empty() {
    return const Center(child: Text('No results found.'));
  }

  Widget _buildStatus(Result<Everything> result) {
    switch (result) {
      case Success(data: final data):
        return data.articles.isEmpty ? _empty() : _buildListView(data.articles);
      case Error(exception: final exception):
        return Text('Error: $exception');
      default:
        return _loading();
    }
  }

  Widget _buildListView(List<Article> articles) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 0, top: 8, right: 0, bottom: 8),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ListTile(title: _newsSmallItem(articles[index], index));
      },
    );
  }

  Widget _newsSmallItem(Article article, int index) {
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
        index > 0
            ? const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),
              )
            : const SizedBox.shrink(),
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

  Widget _newsImage(String? url, double width) {
    return url == null
        ? const SizedBox.shrink()
        : ClipRRect(
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
