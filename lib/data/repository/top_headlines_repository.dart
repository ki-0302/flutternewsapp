import 'package:flutternewsapp/data/model/top_headlines.dart';

import '../model/article.dart';
import '../model/source.dart';

class TopHeadlinesRepository {
  Future<TopHeadlines> getTopHeadlines() async {
    return TopHeadlines(status: "ok", totalResults: 1, articles: [
      Article(
        source: Source(id: "id1", name: "source"),
        author: "author",
        title: "title1",
        description: "description",
        url: "url",
        urlToImage:
            "https://cdn.myportfolio.com/0daad40c-45e4-42be-8f1e-cee5198d5269/e5b14357-18b5-4d71-b751-8168f349b3e5_rw_1920.jpg?h=868a6b3743f2e0dfc52e01eac2cf353f",
        publishedAt: DateTime.now(),
        content: "content",
      ),
      Article(
        source: Source(id: "id2", name: "source2"),
        author: "author",
        title: "title2",
        description: "description",
        url: "url",
        urlToImage:
            "https://cdn.myportfolio.com/0daad40c-45e4-42be-8f1e-cee5198d5269/109c85d9-d0eb-4bdb-b202-3e8255002a73_rw_1920.jpg?h=a9ddefcfff2cbf0ed03091d3f64e3bc4",
        publishedAt: DateTime.now(),
        content: "content",
      ),
      Article(
        source: Source(id: "id3", name: "source3"),
        author: "author",
        title: "title3",
        description: "description",
        url: "url",
        urlToImage:
        "https://cdn.myportfolio.com/0daad40c-45e4-42be-8f1e-cee5198d5269/109c85d9-d0eb-4bdb-b202-3e8255002a73_rw_1920.jpg?h=a9ddefcfff2cbf0ed03091d3f64e3bc4",
        publishedAt: DateTime.now(),
        content: "content",
      ),
    ]);
  }
}
