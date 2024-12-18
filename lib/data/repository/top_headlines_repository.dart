import 'package:dio/dio.dart';
import 'package:flutternewsapp/data/model/top_headlines.dart';
import '../network/news_api_client.dart';

class TopHeadlinesRepository {
  Future<TopHeadlines> getTopHeadlines() async {
    final dio = Dio();
    final client = NewsApiClient(dio);
    return await client.getTopHeadlines(country: "us");
  }
}
