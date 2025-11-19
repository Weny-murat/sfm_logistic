sealed class DataResult<T> {
  const DataResult();
}

class Success<T> extends DataResult<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends DataResult<T> {
  final String message;
  const Failure(this.message);
}
