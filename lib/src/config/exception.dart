import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

class FCException implements Exception {
  FCException(this.message, {this.code});

  final String message;
  final int? code;

  static FCException getException(dynamic err) {
    if (err is SocketException) {
      return InternetConnectException(kInternetConnectionError, 0);
    } 

    else if(err is TimeoutException){
      return OtherExceptions(err.message, 0);
    }
    
    else if (err is DioException) {
      switch (err.type) {
        case DioExceptionType.cancel:
          return OtherExceptions(
            err.message ?? kRequestCancelledError,
            err.response?.statusCode,
          );
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.connectionError:
          return InternetConnectException(
              kTimeOutError, err.response?.statusCode ?? 0);

        case DioExceptionType.badResponse:
        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
          switch (err.response?.statusCode) {
            case 500:
              return InternalServerException(
                msg: err.response?.data?['message'], 
                statusCode: err.response?.statusCode);
            case 502:
              return InternalServerException(
                  statusCode: err.response?.statusCode);
            case 400:
              return OtherExceptions(
                err.response?.data['message'], err.response?.statusCode);
            case 403:
            case 401:
              return OtherExceptions(
                err.response?.data['message'], err.response?.statusCode);
            case 404:
              return OtherExceptions(kUserNotFound, err.response?.statusCode);
            case 413:
              return OtherExceptions(kFileTooLarge, err.response?.statusCode);
            case 409:
              return OtherExceptions(
                err.response?.data['message'], err.response?.statusCode);
            default:
              return OtherExceptions(
                err.response?.data['message'] ?? kServerError, err.response?.statusCode);
          }
      }
    } 
    else {
      return OtherExceptions(kDefaultError, 0);
    }
  }
}

class OtherExceptions implements FCException {
  OtherExceptions(dynamic newMessage, this.statusCode) 
    : _message = newMessage?.toString() ?? kDefaultError;

  final String _message;
  final int? statusCode;

  @override String get message => _message;

  @override int? get code => statusCode;
  
  @override String toString() => _message;
}


class FormatException implements FCException {
  @override
  String toString() => message;

  @override
  int? get code => null;

  @override
  String get message => kFormatError;
}

class InternetConnectException implements FCException {
  InternetConnectException(this.newMessage, this.statusCode);

  final String newMessage;
  final int statusCode;

  @override
  String toString() => message;

  @override
  String get message => newMessage;

  @override
  int? get code => statusCode;
}

class InternalServerException implements FCException {

  InternalServerException({
    required this.statusCode, this.msg
  });

  final int? statusCode;
  final String? msg;

  @override
  String get message => msg ?? kServerError;

  @override
  int? get code => statusCode;
}

class UnAuthorizedException implements FCException {
  UnAuthorizedException({required this.statusCode});

  final int? statusCode;

  @override
  String toString() => message;

  @override
  String get message => kInvalidCredential;

  @override
  int? get code => statusCode;
}

class CacheException implements Exception {
  CacheException(this.message, this.statusCode) : super();

  String message;
  final int? statusCode;
}


const String kInternetConnectionError = 'No internet connection, try again.';
const String kTimeOutError = 'Connection timeout. Please check your internet connection.';
const String kServerError = 'Something went wrong, try again.';
const String kFormatError = 'Unable to process data at this time.';
const String kInvalidCredential = 'Invalid Authentication Credential(s)!';
const String kDefaultError = 'Oops something went wrong!';
const String kBadRequestError = 'Invalid Credential(s)!';
const String kFileTooLarge = 'File too large.';
const String kUserNotFound = 'User does not exist!';
const String kNotFoundError = 'An error occured, please try again.';
const String kRequestCancelledError = 'Request to server was cancelled.';