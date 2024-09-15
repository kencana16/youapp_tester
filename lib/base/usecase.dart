import 'package:equatable/equatable.dart';

// Parameters have to be put into a container object so that they can be
// included in this abstract base class method definition.
abstract class UseCaseAsync<T, Params> {
  Future<T> call(Params params);
}

abstract class UseCase<T, Params> {
  T call(Params params);
}

// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
