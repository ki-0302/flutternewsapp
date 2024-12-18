import 'package:dio/dio.dart';
import 'package:flutternewsapp/data/model/everything.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import '../../env/env.dart';
import '../model/top_headlines.dart';

part 'news_api_client.g.dart';

@RestApi(baseUrl: 'https://newsapi.org/')
abstract class NewsApiClient {
  factory NewsApiClient(
    Dio dio, {
    String? baseUrl,
  }) = _NewsApiClient;

  @GET('/v2/everything')
  Future<Everything> getEverything({
    @Query("q") required String q,
    @Query("apiKey") String apiKey = Env.NEWS_API_KEY,
  });

  @GET('/v2/top-headlines')
  Future<TopHeadlines> getTopHeadlines({
    @Query("country") required String country,
    @Query("apiKey") String apiKey = Env.NEWS_API_KEY,
  });
}
