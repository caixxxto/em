library src.app.repositories.base;

import 'package:flutter/foundation.dart';

import '../../api_client/client.dart';

abstract interface class BaseRepositoryInterface {

  @protected
  ConcreteApiClient get apiClient;
}
