import 'package:bookly/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class useCase<Type, Param> {
  Future<Either<Failure, Type>> call(Param param);
}
