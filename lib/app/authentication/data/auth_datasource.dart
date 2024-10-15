// ignore_for_file: control_flow_in_finally

import 'package:app_services/app_services.dart';
import 'package:http/http.dart';

class AuthDatasource extends APIRequest {
  // This endpoint is not working at the moment, all parameters are correct but
  // still returning "Invalid parameters: Your request parameters are incorrect."

  Future<TMDBApiResponse> login(String username, String password, String token) async {
    Response? response;
    try {
      response = await this.post(
        "3/authentication/token/validate_with_login",
        body: {
          "username": username,
          "password": password,
          "request_token": token,
        },
      );
    } catch (error, stackTrace) {
      Errorhandler.report(error, stackTrace, tag: "@LoginDatasource - login");
    } finally {
      return TMDBApiResponse(response);
    }
  }

  Future<TMDBApiResponse> getRequestToken() async {
    Response? response;
    try {
      response = await this.get("3/authentication/token/new");
    } catch (e, s) {
      Errorhandler.report(e, s, tag: '@LoginDatasource - getRequestToken');
    } finally {
      return TMDBApiResponse(response);
    }
  }
}
