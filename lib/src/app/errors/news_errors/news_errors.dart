part of 'news_errors_handler.dart';


class NewsErrorHandler extends ErrorHandler {
  const NewsErrorHandler();

  @protected
  @override
  Map<String, Failure Function(ApiError)> get errorCodeToFailure => {
    "other_error": (ApiError apiError) => OtherFailure(
      message: apiError.message,
      stackTrace: apiError.stackTrace,
      response: apiError.rawBody,
      dioException: apiError.dioException,
    ),
  };

  @override
  List<String> get connectionTimeoutExcludeUris => [];
}
