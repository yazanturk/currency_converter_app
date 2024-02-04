import 'package:dartz/dartz.dart';

import '../error/failures.dart';

abstract class UseCases<Type, Params> {
  Future<Either<Failures, Type?>> call(Params params);
}
