sealed class FCApiState<T> {
  const FCApiState();

  factory FCApiState.initial() = Initial<T>;
  factory FCApiState.loading() = Loading<T>;
  factory FCApiState.success(T data, {String message}) = Success<T>;
  factory FCApiState.failure(String? message, {T oldData}) = Failure<T>;
}

class Initial<T> extends FCApiState<T> {
  const Initial();
}

class Loading<T> extends FCApiState<T> {
  const Loading();
}

class Success<T> extends FCApiState<T> {
  const Success(this.data, {this.message});
  final T data;
  final String? message;
  
}

class Failure<T> extends FCApiState<T> {
  const Failure(this.message, {this.oldData});
  final String? message;
  final T? oldData;
}
