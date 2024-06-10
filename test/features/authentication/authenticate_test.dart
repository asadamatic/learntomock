import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:learntomock/features/authentication/authenticate.dart';
import 'package:learntomock/features/authentication/data/sources/remote.dart';
import 'package:learntomock/features/authentication/domain/entities/user.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'authenticate_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final MockDio mockDio = MockDio();
  final AuthRemoteSource remoteSource = AuthRemoteSourceImpl(dio: mockDio);

  group("Test Login", () {
    final successfulResonseJson = {
      "id": 1,
      "username": "emilys",
      "email": "emily.johnson@x.dummyjson.com",
      "firstName": "Emily",
      "lastName": "Johnson",
      "gender": "female",
      "image": "https://dummyjson.com/icon/emilys/128",
      "token":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwidXNlcm5hbWUiOiJtaWNoYWVsdyIsImVtYWlsIjoibWljaGFlbC53aWxsaWFtc0B4LmR1bW15anNvbi5jb20iLCJmaXJzdE5hbWUiOiJNaWNoYWVsIiwibGFzdE5hbWUiOiJXaWxsaWFtcyIsImdlbmRlciI6Im1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL21pY2hhZWx3LzEyOCIsImlhdCI6MTcxNzYxMTc0MCwiZXhwIjoxNzE3NjE1MzQwfQ.eQnhQSnS4o0sXZWARh2HsWrEr6XfDT4ngh0ejiykfH8",
      "refreshToken":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwidXNlcm5hbWUiOiJtaWNoYWVsdyIsImVtYWlsIjoibWljaGFlbC53aWxsaWFtc0B4LmR1bW15anNvbi5jb20iLCJmaXJzdE5hbWUiOiJNaWNoYWVsIiwibGFzdE5hbWUiOiJXaWxsaWFtcyIsImdlbmRlciI6Im1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL21pY2hhZWx3LzEyOCIsImlhdCI6MTcxNzYxMTc0MCwiZXhwIjoxNzIwMjAzNzQwfQ.YsStJdmdUjKOUlbXdqze0nEScCM_RJw9rnuy0RdSn88"
    };

    test("Successful Login", () async {
      const username = "emilys";
      const password = "emilypass";
      final jsonEncodedBody =
          jsonEncode({"username": username, "password": password});
      final mockAction = mockDio.post;
      when(mockAction(authUrl, data: jsonEncodedBody)).thenAnswer((_) async {
        return Response(
            data: successfulResonseJson,
            requestOptions: RequestOptions(),
            statusCode: 200);
      });
      final result = await remoteSource.login(username, password);
      verify(mockAction(authUrl, data: jsonEncodedBody)).called(1);
      expect(result, isA<User>());
    });
    test("Failed Login", () async {
      final invalidCredentialsMessage = "Invalid credentials";
      final invalidCredentialsJson = {"message": invalidCredentialsMessage};
      const username = "";
      const password = "";
      final jsonEncodedBody =
          jsonEncode({"username": username, "password": password});
      when(mockDio.post(authUrl, data: jsonEncodedBody)).thenAnswer((_) async {
        return Response(
            data: invalidCredentialsJson,
            requestOptions: RequestOptions(),
            statusCode: 401);
      });
      expect(() async => remoteSource.login(username, password),
          throwsA(invalidCredentialsMessage));
      verify(mockDio.post(authUrl, data: jsonEncodedBody)).called(1);
    });
  });
}
