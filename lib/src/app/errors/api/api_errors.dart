library src.app.errors.api_errors;

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:emehanika_tech/core/constants/failure_constants.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/failure/failure.dart';
import '../../logger/app_logger.dart';

part 'error_handler.dart';

class ApiError extends Equatable {
  final String code;
  final String message;
  final Map<String, dynamic> rawBody;
  final StackTrace? stackTrace;
  final DioException? dioException;

  const ApiError({
    required this.code,
    required this.message,
    this.rawBody = const <String, dynamic>{},
    this.stackTrace,
    this.dioException,
  });

  @override
  List<Object?> get props => [
        code,
        message,
        rawBody,
        stackTrace,
        dioException,
      ];

  ApiError copyWith({
    String? code,
    String? message,
    Map<String, dynamic>? rawBody,
    StackTrace? stackTrace,
    DioException? dioException,
  }) =>
      ApiError(
        code: code ?? this.code,
        message: message ?? this.message,
        rawBody: rawBody ?? this.rawBody,
        stackTrace: stackTrace ?? this.stackTrace,
        dioException: dioException ?? this.dioException,
      );
}
