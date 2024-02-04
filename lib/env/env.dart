import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'KEY')
  static const String key = _Env.key;
}
