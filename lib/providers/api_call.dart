import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:koffie_flutter_bdd/models/login/user_data.dart';
import 'package:koffie_flutter_bdd/utils/session_manager.dart';

enum ContentType { json, formUrlEncoded, formData }

class ApiCall {
  static final ApiCall _instance = ApiCall._internal();

  factory ApiCall() {
    return _instance;
  }

  ApiCall._internal();

  UserData? userData;

/*  static const RESPONSE_SUCCESS = 0,
      RESPONSE_FAILED = 2,
      RESPONSE_VALID = 3,
      RESPONSE_INVALID = 4,
      RESPONSE_INVALID_GRANT = 5;*/

  static const RESPONSE_SUCCESS = "Success",
      RESPONSE_FAILED = "Failed",
      contentType = {
        ContentType.json: "application/json",
        ContentType.formUrlEncoded: "application/x-www-form-urlencoded",
        ContentType.formData: "multipart/form-data"
      };

  Future postRequest(url,
      {param,
      queryParam,
      contentType,
      useToken,
      accessControlAllowOrigin,
      showResponse}) async {
    Dio dio = new Dio();

    /*timeouts*/
    int defaultTimeout = 30 * 1000;
    dio.options.connectTimeout = defaultTimeout;
    dio.options.receiveTimeout = defaultTimeout;
    dio.options.sendTimeout = defaultTimeout;

    if (contentType != null) {
      dio.options.contentType = contentType;
    }

    if (useToken != null) {
      userData = await SessionManager().getUser();
      dio.options.headers["Authorization"] = "Bearer ${userData?.accessToken}";
    }

    if (accessControlAllowOrigin != null) {
      dio.options.headers['Access-Control-Allow-Origin'] = true;
    }

    log("url : $url", name: "NetworkRequest");

    if (param != null) if (param is FormData) {
      log("param : ${param.fields.toString()}", name: "NetworkRequest");
    } else {
      log("param : ${param.toString()}", name: "NetworkRequest");
    }

    if (queryParam != null) if (queryParam is Map) {
      log("param : ${param.fields.toString()}", name: "NetworkRequest");
    } else {
      log("param : ${param.toString()}", name: "NetworkRequest");
    }

    Response response;
    Response errorResponse;
    /*query param disabled for now */
    try {
      response = await dio.post(url, data: param,
          onSendProgress: (int sent, int total) {
        int percentage = ((sent / total) * 100).floor();
        log("progress : ${percentage.toString()}", name: "NetworkRequest");
      });

      if (showResponse != null)
        log("response : ${response.toString()}", name: "NetworkRequest");

      return response;
    } on DioError catch (networkError) {
      Map errorContainer = {
        "message": networkError.toString(),
        "url": url,
        "request":
            param is FormData ? param.fields.toString() : param.toString()
      };

      if (networkError.response != null) {
        if (networkError.response?.data != null) {
          log(networkError.response.toString());
          errorResponse = networkError.response!;
        }
      }
      // else {
      //   errorResponse = Response();
      //   errorResponse.data = {
      //     "status": ApiCall.RESPONSE_FAILED,
      //     "message": networkError.toString
      //   };
      // }
    } catch (otherError, stackTrace) {
      // errorResponse = new Response();
      // errorResponse.data = {
      //   "status": ApiCall.RESPONSE_FAILED,
      //   "message": otherError.toString()
      // };
    }

    // return errorResponse;
  }

  deleteRequest(url,
      {param,
      queryParam,
      contentType,
      useToken,
      accessControlAllowOrigin,
      showResponse}) async {
    Dio dio = new Dio();

    /*timeouts*/
    int defaultTimeout = 30 * 1000;
    dio.options.connectTimeout = defaultTimeout;
    dio.options.receiveTimeout = defaultTimeout;
    dio.options.sendTimeout = defaultTimeout;

    if (contentType != null) {
      dio.options.contentType = contentType;
    }

    if (useToken != null) {
      userData = await SessionManager().getUser();
      dio.options.headers["Authorization"] = "Bearer ${userData?.accessToken}";
    }

    if (accessControlAllowOrigin != null) {
      dio.options.headers['Access-Control-Allow-Origin'] = true;
    }

    log("url : $url", name: "NetworkRequest");

    if (param != null) if (param is FormData) {
      log("param : ${param.fields.toString()}", name: "NetworkRequest");
    } else {
      log("param : ${param.toString()}", name: "NetworkRequest");
    }

    if (queryParam != null) if (queryParam is Map) {
      log("param : ${param.fields.toString()}", name: "NetworkRequest");
    } else {
      log("param : ${param.toString()}", name: "NetworkRequest");
    }

    Response response;
    Response errorResponse;
    /*query param disabled for now */
    try {
      response = await dio.delete(url, data: param);

      if (showResponse != null)
        log("response : ${response.toString()}", name: "NetworkRequest");
      return response;
    } on DioError catch (networkError) {
      Map errorContainer = {
        "message": networkError.toString(),
        "url": url,
        "request":
            param is FormData ? param.fields.toString() : param.toString()
      };

      if (networkError.response != null) {
        if (networkError.response?.data != null) {
          log(networkError.response.toString());
          errorResponse = networkError.response!;
        }
      }
      // else {
      //   errorResponse = new Response();
      //   errorResponse.data = {
      //     "status": ApiCall.RESPONSE_FAILED,
      //     "message": networkError.toString()
      //   };
      // }
    } catch (otherError, stackTrace) {
      // errorResponse = new Response();
      // errorResponse.data = {
      //   "status": ApiCall.RESPONSE_FAILED,
      //   "message": otherError.toString()
      // };
    }

    // return errorResponse;
  }

  getRequest(url, {queryParam, useToken, showResponse}) async {
    Dio dio = new Dio();
    String errorMessage = "";
    Response errorResponse;

    if (useToken != null) {
      userData = await SessionManager().getUser();
      dio.options.headers["Authorization"] = "Bearer ${userData?.accessToken}";
    }

    log("url : $url", name: "NetworkRequest");

    if (queryParam != null) if (queryParam is FormData) {
      log("param : ${queryParam.fields.toString()}", name: "NetworkRequest");
    } else {
      log("param : ${queryParam.toString()}", name: "NetworkRequest");
    }

    try {
      Response response = await dio.get(url,
          queryParameters: queryParam,
          options: Options(contentType: Headers.jsonContentType));

      if (showResponse != null)
        log("response : ${response.toString()}", name: "NetworkRequest");

      return response;
    } on DioError catch (networkError) {
      Map errorContainer = {
        "message": networkError.toString(),
        "url": url,
        "request": queryParam is FormData
            ? queryParam.fields.toString()
            : queryParam.toString()
      };

      if (networkError.response != null) {
        if (networkError.response?.data != null) {
          log(networkError.response.toString());
          errorResponse = networkError.response!;
        }
      } else {
        // errorResponse = new Response();
        // errorResponse.data = {
        //   "status": ApiCall.RESPONSE_FAILED,
        //   "message": networkError.toString()
        // };
      }
    } catch (otherError, stackTrace) {
      // errorResponse = new Response();
      // errorResponse.data = {
      //   "status": ApiCall.RESPONSE_FAILED,
      //   "message": otherError.toString()
      // };
    }
    return errorMessage;
  }

  Future putRequest(url,
      {param,
      queryParam,
      contentType,
      useToken,
      accessControlAllowOrigin,
      showResponse}) async {
    Dio dio = new Dio();

    /*timeouts*/
    int defaultTimeout = 30 * 1000;
    dio.options.connectTimeout = defaultTimeout;
    dio.options.receiveTimeout = defaultTimeout;
    dio.options.sendTimeout = defaultTimeout;

    if (contentType != null) {
      dio.options.contentType = contentType;
    }

    if (useToken != null) {
      userData = await SessionManager().getUser();
      dio.options.headers["Authorization"] = "Bearer ${userData?.accessToken}";
    }

    if (accessControlAllowOrigin != null) {
      dio.options.headers['Access-Control-Allow-Origin'] = true;
    }

    log("url : $url", name: "NetworkRequest");

    if (param != null) if (param is FormData || param is FormData) {
      log("param : ${param.fields.toString()}", name: "NetworkRequest");
    } else {
      log("param : ${param.toString()}", name: "NetworkRequest");
    }

    if (queryParam != null) if (queryParam is Map) {
      log("param : ${param.fields.toString()}", name: "NetworkRequest");
    } else {
      log("param : ${param.toString()}", name: "NetworkRequest");
    }

    Response response;
    Response errorResponse;
    /*query param disabled for now */
    try {
      response = await dio.put(url, data: param,
          onSendProgress: (int sent, int total) {
        int percentage = ((sent / total) * 100).floor();
        log("progress : ${percentage.toString()}", name: "NetworkRequest");
      });

      if (showResponse != null)
        log("response : ${response.toString()}", name: "NetworkRequest");

      return response;
    } on DioError catch (networkError) {
      Map errorContainer = {
        "message": networkError.message.toString(),
        "url": url,
        "request":
            param is FormData ? param.fields.toString() : param.toString()
      };

      if (networkError.response != null) {
        if (networkError.response?.data != null) {
          log(networkError.response.toString());
          errorResponse = networkError.response!;
        }
      } else {
        // errorResponse = new Response();
        // errorResponse.data = {
        //   "status": ApiCall.RESPONSE_FAILED,
        //   "message": networkError.toString()
        // };
      }
    } catch (otherError, stackTrace) {
      // errorResponse = new Response();
      // errorResponse.data = {
      //   "status": ApiCall.RESPONSE_FAILED,
      //   "message": otherError.toString()
      // };
    }

    // return errorResponse;
  }

  ///function to download a file from url to targetDirectory
  ///returns a map containing 'status' (bool) and 'message' (string)
  download(url, targetDirectory) async {
    Dio dioInstance = Dio();

    try {
      Response response = await dioInstance.download(url, targetDirectory);

      if (response.statusCode == 200) {
        return {"status": true, "message": ""};
      } else {
        return {"status": false, "message": "Error occurred"};
      }
    } on DioError catch (networkError) {
      return {"status": false, "message": networkError.message};
    } catch (otherError, stackTrace) {
      return {"status": false, "message": otherError.toString()};
    }
  }

/*postRequest(String urlString,
      {param, useToken = false, showResponse = false, contentType}) async {
    var url = Uri.parse(urlString);
    Response response;

    if (useToken) {
      userData = await SessionManager().getUser();
    }

    try {
      response = await post(url, body: param ?? null, headers: {
        HttpHeaders.authorizationHeader: useToken ? "Bearer ${userData.accessToken}" : "",
        HttpHeaders.contentEncodingHeader: contentType
      });
    } on SocketException catch (exception, stackTrace) {
      Logger().log(exception.toString(), stackTrace: stackTrace, sendToServer: true);
    } on HttpException catch (exception, stackTrace) {
      Logger().log(exception.toString(), stackTrace: stackTrace, sendToServer: true);
    }

    return response;
  }*/

/*getRequest(String urlString,
      {param, useToken = false, showResponse = false, contentType}) async {
    var url = Uri.parse(urlString);
    Response response;

    if (useToken) {
      userData = await SessionManager().getUser();
    }

    try {
      response = await get(url, headers: {
        HttpHeaders.authorizationHeader: useToken ? "Bearer ${userData.accessToken}" : "",
        HttpHeaders.contentEncodingHeader: contentType
      });
    } on SocketException catch (exception, stackTrace) {
      Logger().log(exception.toString(), stackTrace: stackTrace, sendToServer: true);
    } on HttpException catch (exception, stackTrace) {
      Logger().log(exception.toString(), stackTrace: stackTrace, sendToServer: true);
    }

    return response;
  }*/
}
