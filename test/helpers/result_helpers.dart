import 'package:bankx/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

/// Typed [Either] helpers for strict analyzer compatibility in tests.
Right<Failure, T> testRight<T>(T value) => Right<Failure, T>(value);

const Right<Failure, void> testRightVoid = Right<Failure, void>(null);

Left<Failure, T> testLeft<T>(Failure failure) => Left<Failure, T>(failure);

Left<Failure, void> testLeftVoid(Failure failure) => Left<Failure, void>(failure);

Future<Either<Failure, T>> futureRight<T>(T value) async =>
    Right<Failure, T>(value);

Future<Either<Failure, void>> futureRightVoid() async =>
    const Right<Failure, void>(null);

Future<Either<Failure, T>> futureLeft<T>(Failure failure) async =>
    Left<Failure, T>(failure);
