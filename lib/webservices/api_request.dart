import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as multi;
import 'package:dio/io.dart';
import 'package:news/util/_string.dart';
import 'package:news/util/constants.dart';
import 'package:news/webservices/base_response.dart';
import 'package:news/webservices/response_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ApiRequest {

  String url;
  dynamic data;
  Map<String, dynamic>? queryParameters;
  late Response response;
  multi.FormData? formData;
  bool isFormData = false;
  late Dio dio;
  GetStorage getStorage = GetStorage();
  String? savePath;
  
  ApiRequest(
      {required this.url,
      this.data,
      this.formData,
      this.queryParameters,
      this.savePath,
      this.isFormData = false});

  Future<bool> interNetCheck() async {
    try {
      dio = Dio();
      dio.options.followRedirects = false;
      dio.options.connectTimeout = const Duration(minutes: 3);
      dio.options.receiveTimeout = const Duration(minutes: 3);

      /* dio.httpClientAdapter = (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      } as HttpClientAdapter;*/

      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on Exception {
      return false;
    }
  }

  Future<void> getRequest({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    try {
      bool isInternet = await interNetCheck();
      if (isInternet) {
        /* String token = "";
        if (getStorage.hasData(Constant.USER_TOKEN)) {
          token = await getStorage.read(Constant.USER_TOKEN);
        }*/
        String url = this.url; //BASE_URL +
        print("URL ==> $url");
        response = await dio.get(
          url,
          queryParameters: queryParameters,
          options: Options(
            headers: {
              "x-access-token": "",
            }, //"Authorization": '$token'
          ),
        );
        print("Response Data ==> ${response.data}");
        ResponseModel responseModel;
        if (response.statusCode == 200 && response.data != null) {
          responseModel = ResponseModel(
              result: response.data,
              statusCode: response.statusCode,
              message: response.statusMessage);
        } else {
          responseModel = ResponseModel(
              result: null,
              statusCode: response.statusCode,
              message: response.statusMessage);
        }
        if (onSuccess != null) onSuccess(responseModel);
      } else {
        var responseModel = ResponseModel(
            result: null,
            statusCode: Constant.CODE_NO_INTERNET_CONNECTION,
            message: Strings.tryAgain);
        if (onError != null) onError(responseModel);
      }
    } catch (e) {
      String? msg = Strings.somethingWrong;
      int? statusCode = Constant.CODE_NO_TRY_CATCH;
      if (e is DioError) {
        if (e.response?.statusCode == 401 && e.response?.data != null) {
          BaseResponse errorRes =
              BaseResponse.fromJson(jsonDecode(e.response?.data));
          if (errorRes.errorMessage!.isNotEmpty) {
            msg = errorRes.errorMessage;
          }
          statusCode = 401;
          /* if (errorRes.status != null) {

          }*/
        } else {
          dynamic data = _decodeErrorResponse(e);
          msg = data["message"];
          statusCode = data["statusCode"];
        }
      }
      var responseModel =
          ResponseModel(result: null, statusCode: statusCode, message: msg);
      if (onError != null) onError(responseModel);
    }
  }

  Future<void> postRequest({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    try {
      bool isInternet = await interNetCheck();
      if (isInternet) {
        String url = "";
        url = this.url; //BASE_URL +
        // String token = "";
        /*if (getStorage.hasData(Constant.USER_TOKEN)) {
          token = await getStorage.read(Constant.USER_TOKEN);
        }*/
        print("URL ==> $url");
        if (!isFormData) {
          debugPrint("Request Data ==> ${jsonEncode(data)}", wrapWidth: 2048);
          // print("Request Data ==> ${jsonEncode(this.data)}");
          response = await dio.post(
            url,
            data: data,
            options: Options(
              headers: {
                "x-access-token": "",
                "Content-Type": "application/json",
                "accept": "*/*",
                "X-CSRF-TOKEN": '',
                "Authorization": ''
              },
            ),
          );
        } else {
          multi.Dio dio = multi.Dio();
          dio.options.connectTimeout = const Duration(minutes: 3);
          dio.options.receiveTimeout = const Duration(minutes: 3);
          response = await dio.post(
            url,
            data: formData,
            options: Options(
              headers: {
                "x-access-token": "",
                "Content-Type": "multipart/form-data",
                // "Authorization": '$token'
              },
            ),
          );
        }
        print("Post Response Data1 ==> ${response.statusCode}");
        print("Post Response Data2 ==> ${response.headers}");
        print("Post Response Data3 ==> ${response.data}");
        ResponseModel responseModel;
        // ignore: unnecessary_null_comparison
        if (response != null &&
            response.statusCode == 200 &&
            response.data != null) {
          responseModel = ResponseModel(
              result: response.data,
              statusCode: response.statusCode,
              message: response.statusMessage);
          print('data here');
          print(responseModel.statusCode);
        } else {
          responseModel = ResponseModel(
              result: null,
              statusCode: response.statusCode,
              message: response.statusMessage);
        }
        if (onSuccess != null) {
          onSuccess(responseModel);
        }
      } else {
        var responseModel = ResponseModel(
            result: null,
            statusCode: Constant.CODE_NO_INTERNET_CONNECTION,
            message: Strings.tryAgain);
        if (onError != null) onError(responseModel);
      }
    } catch (e) {
      String? msg = Strings.somethingWrong;
      int? statusCode = Constant.CODE_NO_TRY_CATCH;
      if (e is DioError) {
        if (e.response?.statusCode == 401 && e.response?.data != null) {
          BaseResponse errorRes =
              BaseResponse.fromJson(jsonDecode(e.response?.data));
          if (errorRes.errorMessage!.isNotEmpty) {
            msg = errorRes.errorMessage;
          }
          statusCode = 401;
          /*  if (errorRes.status != null) {
            statusCode = errorRes.status;
          }*/
        } else {
          dynamic data = _decodeErrorResponse(e);
          msg = data["message"];
          statusCode = data["statusCode"];
        }
      }
      var responseModel =
          ResponseModel(result: null, statusCode: statusCode, message: msg);
      if (onError != null) onError(responseModel);
    }
  }

  Future<void> deleteRequest({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    try {
      bool isInternet = await interNetCheck();
      if (isInternet) {
        /*  String token = "";
        if (getStorage.hasData(Constant.USER_TOKEN)) {
          token = await getStorage.read(Constant.USER_TOKEN);
        }*/
        String url = this.url; //BASE_URL +
        print("URL ==> $url");
        response = await dio.delete(
          url,
          queryParameters: queryParameters,
          options: Options(
            headers: {
              "x-access-token": "",
            }, //"Authorization": '$token'
          ),
        );
        print("Response Data ==> ${response.data}");
        ResponseModel responseModel;
        // ignore: unnecessary_null_comparison
        if (response != null &&
            response.statusCode == 200 &&
            response.data != null) {
          responseModel = ResponseModel(
              result: response.data,
              statusCode: response.statusCode,
              message: response.statusMessage);
        } else {
          responseModel = ResponseModel(
              result: null,
              statusCode: response.statusCode,
              message: response.statusMessage);
        }
        if (onSuccess != null) onSuccess(responseModel);
      } else {
        var responseModel = ResponseModel(
            result: null,
            statusCode: Constant.CODE_NO_INTERNET_CONNECTION,
            message: Strings.tryAgain);
        if (onError != null) onError(responseModel);
      }
    } catch (e) {
      String? msg = Strings.somethingWrong;
      int? statusCode = Constant.CODE_NO_TRY_CATCH;
      if (e is DioError) {
        if (e.response?.statusCode == 401 && e.response?.data != null) {
          BaseResponse errorRes =
              BaseResponse.fromJson(jsonDecode(e.response?.data));
          if (errorRes.errorMessage!.isNotEmpty) {
            msg = errorRes.errorMessage;
          }
          statusCode = 401;
          /* if (errorRes.status != null) {
            statusCode = errorRes.status;
          }*/
        } else {
          dynamic data = _decodeErrorResponse(e);
          msg = data["message"];
          statusCode = data["statusCode"];
        }
      }
      var responseModel =
          ResponseModel(result: null, statusCode: statusCode, message: msg);
      if (onError != null) onError(responseModel);
    }
  }

  Future<void> downloadRequest({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    try {
      bool isInternet = await interNetCheck();
      if (isInternet) {
        print("URL ==> $url");
        response = await dio.download(
          url,
          savePath,
        );
        print("Response Data ==> ${response.data}");
        ResponseModel responseModel;
        // ignore: unnecessary_null_comparison
        if (response != null &&
            response.statusCode == 200 &&
            response.data != null) {
          responseModel = ResponseModel(
              result: response.data,
              statusCode: response.statusCode,
              message: response.statusMessage);
        } else {
          responseModel = ResponseModel(
              result: null,
              statusCode: response.statusCode,
              message: response.statusMessage);
        }
        if (onSuccess != null) onSuccess(responseModel);
      } else {
        var responseModel = ResponseModel(
            result: null,
            statusCode: Constant.CODE_NO_INTERNET_CONNECTION,
            message: Strings.tryAgain);
        if (onError != null) onError(responseModel);
      }
    } catch (e) {
      String? msg = Strings.somethingWrong;
      int? statusCode = Constant.CODE_NO_TRY_CATCH;
      if (e is DioError) {
        if (e.response?.statusCode == 401 && e.response?.data != null) {
          BaseResponse errorRes =
              BaseResponse.fromJson(jsonDecode(e.response?.data));
          if (errorRes.errorMessage!.isNotEmpty) {
            msg = errorRes.errorMessage;
          }
          statusCode = 401;
          /*if (errorRes.status != null) {
            statusCode = errorRes.status;
          }*/
        } else {
          dynamic data = _decodeErrorResponse(e);
          msg = data["message"];
          statusCode = data["statusCode"];
        }
      }
      var responseModel =
          ResponseModel(result: null, statusCode: statusCode, message: msg);
      if (onError != null) onError(responseModel);
    }
  }

  dynamic _decodeErrorResponse(dynamic e) {
    dynamic data = {
      "statusCode": Constant.CODE_NO_TRY_CATCH,
      "message": Strings.somethingWrong
    };
    if (e is DioError) {
      if (e.type == DioErrorType.badResponse) {
        // need to check this code
        print(e.response);
        final response = e.response;
        try {
          if (response != null && response.data != null) {
            final Map responseData =
                json.decode(response.data as String) as Map;
            data["message"] =
                "${response.statusCode} : ${responseData['message']}";
            data["statusCode"] = response.statusCode;
          }
        } catch (e) {
          data["message"] =
              "${Strings.serverCommunicationMsg} :${response?.statusCode}";
        }
      } else if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        data["message"] = Strings.requestTimeout;
        data["statusCode"] = 408;
      } else if (e.error is SocketException) {
        data["message"] = Strings.noInternet;
      }
    }
    return data;
  }


}
