import 'package:dartz/dartz.dart';
import 'package:weight_tracker/core/error/failure.dart';

typedef ApiResult<T> = Either<Failure, T>;
