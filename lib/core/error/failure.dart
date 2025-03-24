import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});
  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class NoDataFailure extends Failure {
  const NoDataFailure({required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({required super.message});
}

class NoInternetFailure extends Failure {
  const NoInternetFailure({required super.message});
} // New failure for internet issues
