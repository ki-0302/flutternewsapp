
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Error extends Result<Never> {
  final Exception exception;
  const Error(this.exception);
}

class Loading extends Result<Never> {
  const Loading();
}
