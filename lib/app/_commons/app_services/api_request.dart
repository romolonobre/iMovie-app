import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imovie_app/app/_commons/app_services/env.dart';

import 'utils.dart';

class APIRequest {
  final String baseUrl = Env.apiBaseUrl;

  final Map<String, String> requestHeaders = {
    'Authorization': "Bearer ${Env.token}",
    'accept': 'application/json',
  };

  @protected
  Future<http.Response?> get(
    String endpoint, {
    Map<String, String>? headers,
  }) {
    debugPrint('''  --------- API REQUEST ---------
  Request Fingerprint: ${fingerPrint.millisecondsSinceEpoch}
  Method: get
  URL: $endpoint
  --------------------------------''');

    return http.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: requestHeaders,
    );
  }

  @protected
  Future<http.Response?> post(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) {
    debugPrint('''  --------- API REQUEST ---------
  Request Fingerprint: ${fingerPrint.millisecondsSinceEpoch}
  Method: post
  URL: $endpoint
  Body: $body
  --------------------------------''');

    return http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: requestHeaders,
      body: json.encode(body),
    );
  }
}
