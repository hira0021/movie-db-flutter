abstract class GeneralState<T> {}

class InitialState<T> extends GeneralState<T> {}

class LoadingState<T> extends GeneralState<T> {
  final bool isPagination;
  LoadingState({this.isPagination = false});
}

class SuccessState<T> extends GeneralState<T> {
  final T data;
  SuccessState(this.data);
}

class ErrorState<T> extends GeneralState<T> {
  final String message;
  final bool isPagination;
  ErrorState(this.message, {this.isPagination = false});
}
