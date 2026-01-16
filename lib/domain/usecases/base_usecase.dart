// Base use case interface/class

abstract class BaseUseCase<Type, Params> {
  Future<Type> call(Params params);
}

class NoParams {
  // Use when use case doesn't need parameters
}
