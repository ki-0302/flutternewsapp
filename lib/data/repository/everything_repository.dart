import 'package:dio/dio.dart';
import 'package:flutternewsapp/data/model/everything.dart';
import '../network/news_api_client.dart';

class EverythingRepository {
  Future<Everything> getEverything(String query) async {
    final dio = Dio();
    final client = NewsApiClient(dio);
    return await client.getEverything(
      q: query,
    );
  }
}
