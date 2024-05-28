
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_calling_flutter_app/utils/constants.dart';

class UserServices {

  static final dio = Dio();

  static dynamic creatUserAccount(Map<String, dynamic> accInformation) async {

    try {

      final response = await dio.post('${Constants.baseUrl}/users/register',
        data: accInformation,
      );

      if(response.statusCode == 201) {
        return response.data;
      }
      
    } on DioException catch (dioError) {
      throw dioError.response!.data['message'];
    } 

  }

  static dynamic loginUser(Map<String, dynamic> loginInformation) async {
    try {

      final response = await dio.post('${Constants.baseUrl}/users/login',
        data: loginInformation,
      );

      if(response.statusCode == 200) {
        return response.data;
      }
      
    } on DioException catch (dioError) {
      throw dioError.response!.data['message'];
    } 
  }

  static dynamic logoutUser() async {
    try {

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString(Constants.USER_ACCESS_TOKEN);

      final response = await dio.post('${Constants.baseUrl}/users/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken'
          }
        )
      );

      if(response.statusCode == 200) {
        return response.data;
      }
      
    } on DioException catch (dioError) {
      throw dioError.response!.data['message'];
    } 
  }

  static dynamic getCurrentLoggedInUser() async {
    try {

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString(Constants.USER_ACCESS_TOKEN);

      if(accessToken == null) {
        throw DioException(
          requestOptions: RequestOptions(), 
          response: Response(
            requestOptions: RequestOptions(), 
            data: {'message': 'Session Ended'},
        ),);
      }

      final response = await dio.get('${Constants.baseUrl}/users/current-user',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken'
          }
        )
      );

      if(response.statusCode == 200) {
        return response.data;
      }
      
    } on DioException catch (dioError) {
      throw dioError.response!.data['message'];
    } 
  }

  static dynamic updateUserAccount(Map<String, dynamic> accInformation) async {
    try {

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString(Constants.USER_ACCESS_TOKEN);

      final response = await dio.patch('${Constants.baseUrl}/users/update-user-account-details',
        data: accInformation,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken'
          }
        )
      );

      if(response.statusCode == 200) {
        return response.data;
      }
      
    } on DioException catch (dioError) {
      throw dioError.response!.data['message'];
    } 
  }

  static dynamic updateUserProfileImage(File pickedImage) async {
    try {

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString(Constants.USER_ACCESS_TOKEN);

      final formData = FormData.fromMap({
        'user-profile': await MultipartFile.fromFile(pickedImage.path),
      });

      final response = await dio.patch(
        '${Constants.baseUrl}/users/update-profile-image',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'multipart/form-data'
          }
        ),
      );

      if(response.statusCode == 200) {
        return response.data;
      }
      
    } on DioException catch (dioError) {
      throw dioError.response!.data['message'];
    } 
  }

  static dynamic getUserCallLogs() async {
    try {

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString(Constants.USER_ACCESS_TOKEN);

      final response = await dio.get(
        '${Constants.baseUrl}/users/user-call-logs',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          }
        ),
      );

      if(response.statusCode == 200) {
        return response.data;
      }
      
    } on DioException catch (dioError) {
      throw dioError.response!.data['message'];
    } 
  }

  static dynamic deleteUserAccount() async {
    try {

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString(Constants.USER_ACCESS_TOKEN);

      final response = await dio.delete(
        '${Constants.baseUrl}/users/delete-my-account',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          }
        ),
      );

      if(response.statusCode == 200) {
        return response.data;
      }

    } on DioException catch (dioError) {
      throw dioError.response!.data['message'];
    } 
  }

  static dynamic requestPasswordChangeForNotLoggedInUser({required Map<String, String> details}) async {
    try {

      final response = await dio.patch(
        '${Constants.baseUrl}/users/change-user-password',
        data: details,
      );

      if(response.statusCode == 200) {
        return response.data;
      }
      
    } on DioException catch (dioError) {
      throw dioError.response!.data['message'];
    } 
  }

  static dynamic requestPasswordChangeForLoggedInUser({required Map<String, String> details}) async {
    try {

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString(Constants.USER_ACCESS_TOKEN);

      final response = await dio.patch(
        '${Constants.baseUrl}/users/change-password',
        data: details,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          }
        ),
      );

      if(response.statusCode == 200) {
        return response.data;
      }
      
    } on DioException catch (dioError) {
      throw dioError.response!.data['message'];
    } 
  }

  static dynamic requestUserOTP(String email) async {
    try {

      final response = await dio.post(
        '${Constants.baseUrl}/users/send-otp',
        data: {
          "email" : email,
        }
      );

      if(response.statusCode == 200) {
        return response.data;
      }
      
    } on DioException catch (dioError) {
      throw dioError.response!.data['message'];
    } 
  }

  static dynamic makeACall(String userPhoneNumber) async {
    try {

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString(Constants.USER_ACCESS_TOKEN);

      final response = await dio.post(
        '${Constants.baseUrl}/calls/create-incoming-call',
        data: {
          "userPhoneNumber" : userPhoneNumber,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          }
        )
      );

      if(response.statusCode == 200) {
        return response.data;
      }
      
    } on DioException catch (dioError) {
      throw dioError.response!.data['message'];
    } 
  }

  static dynamic changeCallStatusToReject(String callId) async {
    try {

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString(Constants.USER_ACCESS_TOKEN);

      final response = await dio.patch(
        '${Constants.baseUrl}/calls/change-call-status',
        data: {
          "callId" : callId,
          "newCallStatus" : "REJECTED"
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          }
        )
      );

      if(response.statusCode == 200) {
        return response.data;
      }
      
    } on DioException catch (dioError) {
      throw dioError.response!.data['message'];
    } 
  }


}