import 'package:dio/dio.dart';

class DioException implements Exception {
  late String errorMessage;

  DioException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorMessage = 'Request to the server was cancelled.';
        break;
      case DioErrorType.connectTimeout:
        errorMessage = 'Connection timed out.';
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = 'The server took too long to respond.';
        break;
      case DioErrorType.sendTimeout:
        errorMessage = 'Unable to send request, check your connection.';
        break;
      case DioErrorType.response:
        errorMessage = _handleStatusCode(dioError.response?.statusCode);
        break;
      case DioErrorType.other:
        if (dioError.message.contains('SocketException')) {
          errorMessage =
              'Sorry, could not complete operation.\nPlease check your internet connection and try again.';
          break;
        }
        errorMessage = 'Unexpected error occurred.';
        break;
      default:
        errorMessage = 'Something went wrong';
        break;
    }
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request.';
      case 401:
        return 'Authentication failed.';
      case 403:
        return 'The authenticated user is not allowed to access the specified API endpoint.';
      case 404:
        return 'The requested resource does not exist.';
      case 405:
        return 'Method not allowed. Please check the Allow header for the allowed HTTP methods.';
      case 415:
        return 'Unsupported media type.';
      case 422:
        return 'Data validation failed.';
      case 429:
        return 'Too many requests.';
      case 500:
        return 'Internal server error.';
      case 204:
        return 'Problem communicating with server';
      default:
        return 'Oops, something went wrong.';
    }
  }

  @override
  String toString() => errorMessage;
}
