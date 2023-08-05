import 'dart:io';

// import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../models/shared_user_data_model.dart';
import '../utils_global.dart';

class AppHelperHttp {
  SharedUserData? user = AppUtilsGlobal().userData.value;

  Dio http() {
    Dio http = Dio();
    (http.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    http.options.headers = {
      // 'token': user?.token,
    };

    // interceptors
    // http.interceptors.add(
    //   InterceptorsWrapper(
    //     onRequest: (options, handler) async {
    //       var headers = {
    //         'token':
    //             '59aaa8a9eb257355c1a8547136a7d188b9cefa865b955ce2c2e639550b5b4cc3b215278e08cb482a',
    //       };
    //       options.headers.addAll(headers);
    //     },
    //   ),
    // );
    return http;
  }
}
