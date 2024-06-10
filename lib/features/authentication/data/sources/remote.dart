import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:learntomock/features/authentication/domain/entities/user.dart';

import '../../authenticate.dart';

abstract class AuthRemoteSource {
  Future<User> login(String email, String password);
}

class AuthRemoteSourceImpl implements AuthRemoteSource {
  final Dio _dio;

  AuthRemoteSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<User> login(String username, String password) async {
    final jsonEncodedBody =
        jsonEncode({"username": username, "password": password});
    final Response response = await _dio.post(authUrl, data: jsonEncodedBody);

    if (response.statusCode != 200) {
      return Future.error(response.data['message']);
    }
    return User.fromJson(response.data);
  }
}
