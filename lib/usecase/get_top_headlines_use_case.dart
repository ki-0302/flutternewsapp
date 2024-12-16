import '../data/model/top_headlines.dart';
import '../data/repository/top_headlines_repository.dart';
import '../data/result/result.dart';

class GetTopHeadlinesUseCase {
  TopHeadlinesRepository topHeadlinesRepository;

  GetTopHeadlinesUseCase(this.topHeadlinesRepository);

  Future<Result<TopHeadlines>> getTopHeadlines() async {

    try {
      final result = await topHeadlinesRepository.getTopHeadlines();
      return Success(result);
    } catch (e) {
      // エラー処理
      return Error(e as Exception);
    }
  }
}
