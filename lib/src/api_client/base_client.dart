// library src.app.api_client.base;
//
// import 'package:dio/dio.dart';
//
// part 'response_code.dart';
//
// abstract class ApiClient {
//   final Map<String, dynamic> headers;
//   final List<Interceptor> interceptors;
//   final String baseUrl;
//
//   const ApiClient({
//     this.headers = const {},
//     this.interceptors = const [],
//     this.baseUrl = '',
//   });
//
//   Dio get apiClient => Dio(
//         BaseOptions(
//           baseUrl: baseUrl,
//           headers: {
//             ...headers,
//           },
//           contentType: Headers.jsonContentType,
//           connectTimeout: const Duration(
//             milliseconds: 1000,
//           ),
//           receiveTimeout: const Duration(
//             milliseconds: 1000,
//           ),
//         ),
//       )..interceptors.addAll(
//           interceptors,
//         );
// }
//
