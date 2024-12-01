import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import '../model/top_headlines.dart';

part 'news_api_client.g.dart';

@RestApi(baseUrl: 'https://newsapi.org/v2/')
abstract class NewsApiClient {
  factory NewsApiClient(
    Dio dio, {
    String? baseUrl,
  }) = _NewsApiClient;

  @GET('/v2/top-headlines')
  Future<TopHeadlines> getTopHeadlines({
    @Query("country") required String country,
    @Query("apiKey") required double lon,
  });
}
