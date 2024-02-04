import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  final int? code;
  final String message;
  const Failures({this.code, required this.message});
//required
  @override
  // TODO: implement props
  List<Object?> get props => [
        code,
        message,
      ];
}

class ServerFailure extends Failures {
  const ServerFailure({required super.message, super.code});
}

class CacheFailure extends Failures {
  const CacheFailure({required super.message, super.code});
}

class DefaultFailure extends Failures {
  const DefaultFailure({required super.message, super.code});
}

class BadRequestFailure extends Failures {
  const BadRequestFailure({required super.message, super.code});
}

class UnauthorizedFailure extends Failures {
  const UnauthorizedFailure({required super.message, super.code});
}

class ForbiddenFailure extends Failures {
  const ForbiddenFailure({required super.message, super.code});
}

class NotFoundFailure extends Failures {
  const NotFoundFailure({required super.message, super.code});
}
