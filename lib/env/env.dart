import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'NEWS_API_KEY')
  static const String NEWS_API_KEY = _Env.NEWS_API_KEY;
}
