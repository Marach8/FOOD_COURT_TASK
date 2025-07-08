import 'package:food_court/src/config/exception.dart';

abstract class ApiResponse<T> {
  const ApiResponse();

  R when<R>({
    required R Function(Successful<T> _) successful,
    required R Function(Unsuccessful<T> _) unSuccessful,
  });
}

class Successful<T> extends ApiResponse<T> {
  
  Successful({this.data});
  final T? data;

  @override
  R when<R>({
    required R Function(Successful<T> _) successful,
    required R Function(Unsuccessful<T> _) unSuccessful
  }) => successful(this);
}

class Unsuccessful<T> extends ApiResponse<T> {
  Unsuccessful({required this.error});
  final FCException error;

  @override
  R when<R>({
    required R Function(Successful<T> _) successful,
    required R Function(Unsuccessful<T> _) unSuccessful
  }) => unSuccessful(this);
}
