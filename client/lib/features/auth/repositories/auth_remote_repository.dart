import 'dart:convert';

import 'package:client/core/constants/server_constants.dart';
import 'package:client/core/failure/failure.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
class AuthRemoteRepository {
  final _baseUrl = '${ServerConstants.baseUrl}/auth/';
  Future<Either<AppFailure,UserModel>> login({
    required String email,
    required String password,
  })async {
    try {
      final response = await http.post(
      Uri.parse('${_baseUrl}login'),
      headers: {
        'Content-Type': 'application/json', // JSON formatı belirtiyoruz
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }), // JSON formatına çeviriyoruz
    );
     final responseMap = jsonDecode(response.body)as Map<String,dynamic>; ;
    if (response.statusCode != 200) {
      return left(AppFailure(responseMap['detail']));
    }
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
   
    return right(UserModel.fromMap(responseMap));
    
    } catch (e) {
      return left(AppFailure(e.toString()) );
      
    }
  }
  Future<Either<AppFailure,UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
      Uri.parse('${_baseUrl}signup'),
      headers: {
        'Content-Type': 'application/json', // JSON formatı olduğunu belirtiyoruz
      },
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }), // JSON formatına çeviriyoruz
    );
    final responseBodyMap = jsonDecode(response.body);
    if (response.statusCode != 201) {
      return left(AppFailure(responseBodyMap['detail']));
    }

    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    
    
    return right(UserModel.fromMap(responseBodyMap));
    } catch (e) {
      return left(AppFailure(e.toString()) );
      
    }
  }
}
