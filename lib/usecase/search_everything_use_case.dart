

import 'package:flutternewsapp/data/model/everything.dart';
import 'package:flutternewsapp/data/repository/everything_repository.dart';

import '../data/result/result.dart';

class SearchEverythingUseCase {
  EverythingRepository everythingRepository;

  SearchEverythingUseCase(this.everythingRepository);

  Future<Result<Everything>> searchEverything(String query) async {

    try {
      final result = await everythingRepository.getEverything(query);
      return Success(result);
    } catch (e) {
      // エラー処理
      return Error(e as Exception);
    }
  }
}
