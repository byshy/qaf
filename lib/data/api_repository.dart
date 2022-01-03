import 'package:qaf/models/user.dart';
import 'package:dio/dio.dart';

class ApiRepo {
  final Dio client;

  ApiRepo({required this.client});

  //RequestOptions _requestOptions = RequestOptions(path: '${data['is_employee'] ? 'employee' : 'user'}/login');
  //
  //     throw DioError(
  //       type: DioErrorType.response,
  //       requestOptions: _requestOptions,
  //       response: Response(
  //         data: ErrorResponse(
  //           msg: 'Test error',
  //         ).toJson(),
  //         requestOptions: _requestOptions,
  //       ),
  //     );

  Future<User> login({required Map<String, dynamic> data}) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    return User(
      data: Data(
        status: 200,
        message: 'message',
        accessToken: 'token',
        userInfo: UserInfo(
          id: '1',
          name: 'Basel',
          mobileNo: '123456789',
          email: 'email@example.com',
        ),
      ),
    );

    // Response response = await client.post(
    //   'index.php',
    //   queryParameters: {
    //     'r': 'API/site/login',
    //   },
    //   data: FormData.fromMap(data),
    // );
    //
    // if (response.data['status'] == 400) {
    //   throw DioError(
    //     requestOptions: response.requestOptions,
    //     response: response..statusCode = 400,
    //   );
    // }
    //
    // return User.fromJson(response.data);
  }

  Future<String> verifyCode({required Map<String, dynamic> data}) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    return 'Token';
  }

  Future<void> resendCode({Map<String, dynamic>? data}) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
  }
}
