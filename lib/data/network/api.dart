import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import '../../app/constants.dart';
import '../../app/di.dart';
import '../../app/shared_pref.dart';
import '../model/utils/error_model.dart';

class Api {
  SharedPref pref;

  Api(this.pref,);

  Future<String> callApi(dynamic  body, String router,
      {sendToken = true, timeout = 60, bool noBase=false})
  async {
    try {
      if(kDebugMode)
      print(router);
      HttpClient client = HttpClient();
      client.connectionTimeout = Duration(seconds: timeout);
      client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
      HttpClientRequest request;
      if (body == null) {
        request = await client.getUrl(Uri.parse(noBase?router:(baseUrl + router)));
      } else {
        request = await client.postUrl(Uri.parse(noBase?router:(baseUrl + router)));
      }
      request.headers.set('Content-Type', 'application/json; charset=utf-8');
      if (sendToken) {
        // request.headers.set('Authorization', 'Bearer ${await pref.getSharedItem(SharedEnum.token)}');
      }else{
        String username = 'mustafa';
        String password = 'password';
        String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
        request.headers.set('Authorization', basicAuth);
      }
      if (body != null) {
        request.add(utf8.encode(jsonEncode(body)));
      }
      HttpClientResponse result = await request.close().timeout(Duration(seconds: timeout));
      if (result.statusCode == 200) {
        return await result.transform(utf8.decoder).join();
      } else {

          // FirebaseCrashlytics.instance.recordFlutterFatalError(FlutterErrorDetails(exception: await result.transform(utf8.decoder).join()));
        throw await result.transform(utf8.decoder).join();

      }
    } catch (ex) {
      if(kDebugMode)
      print(ex.toString());
      var error = json.decode(ex.toString());
      throw ErrorModel(
          status: error['statusCode'],
          message: error['message']
      );
    }
  }
  Future<String> callNoTokenApi(dynamic body, String router,
      {sendToken = true, timeout = 60})
  async {
    try {
      HttpClient client = HttpClient();
      client.connectionTimeout = Duration(seconds: timeout);
      client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
      HttpClientRequest request;
      if (body == null) {
        request = await client.getUrl(Uri.parse(baseUrl + router));
      } else {
        request = await client.postUrl(Uri.parse(baseUrl + router));
      }

      request.headers.set('Content-Type', 'application/json; charset=utf-8');

        String username = 'mustafa';
        String password = 'password';
        String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
        request.headers.set('Authorization', basicAuth);

      if (body != null) {
        request.add(utf8.encode(jsonEncode(body)));
      }
      HttpClientResponse result = await request.close().timeout(Duration(seconds: timeout));
      if (result.statusCode == 200) {
        return await result.transform(utf8.decoder).join();
      } else {
        throw await result.transform(utf8.decoder).join();
      }
    } catch (ex) {
      // FirebaseCrashlytics.instance.recordFlutterFatalError(FlutterErrorDetails(exception: ex.toString()));
      var error = json.decode(ex.toString());
      throw ErrorModel(
          status: error['statusCode'],
          message: error['message']
      );
    }
  }
  Future<dynamic> callFormData(Map<String, String> body,
      Iterable<http.MultipartFile> files,router,{ timeout = 60,bool getWithData=false,bool haveToken=true,bool put=false,int type=0,Map<String, dynamic>? querey})
  async {
    try {
      SharedPref _pref = instance<SharedPref>();
      if (kDebugMode) print(baseUrl + router);

      http.MultipartRequest request;

      if (type == 0) {
          request = http.MultipartRequest(
            'POST',
            Uri.parse(baseUrl +
                router)
                .replace(queryParameters: querey),
          );

      } else if (type == 1) {
        request = http.MultipartRequest(
            'DELETE',
            Uri.parse(baseUrl +
                router));
      } else {
        request = http.MultipartRequest(
            'PUT',
            Uri.parse(baseUrl +
                router));
      }
      // request.fields;

      if (haveToken) {
        //
        // request.headers.addAll({
        //   'Authorization':
        //   'Bearer ${await _pref.getSharedItem(SharedEnum.token)}',
        // });
      } else {
        String username = 'mustafa';
        String password = 'password';
        String basicAuth =
            'Basic ${base64Encode(utf8.encode('$username:$password'))}';
        request.headers.addAll({'Authorization': basicAuth});
      }
      request.fields.addAll(body);
      if (files.isNotEmpty) {
        request.files.addAll(files);
      }

      var result = await request.send().timeout(Duration(seconds: timeout));
      if (result.statusCode == 200) {
        return await result.stream.bytesToString();
      } else {
        print(await result.stream.bytesToString());

      }
    } catch (ex) {
      print(ex.toString());
      var error = json.decode(ex.toString());
      throw ErrorModel(status: error['statusCode'], message: error['message']);
    }
  }


  Future<String> callApiFile(Map<String, String>? body,String? pathImage,String router,
      {timeout = 60}) async {
    try{
      var request = http.MultipartRequest("POST",Uri.parse(baseUrl + router));


      Map<String, String> header = {
        'content-type': 'application/json; charset=UTF-8;',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer ${await pref.getSharedItem(SharedEnum.token)}'
      };

      request.headers.addAll(header);

      if(pathImage != null) {
        request.files.add(await http.MultipartFile.fromPath("image", pathImage));
      }

      // if(body != null) {
      //   header.addAll(body);
      // }
      if(body != null){
        body!.forEach((k, v) {
          request.fields[k] = v;
        });
      }

      HttpClient client = HttpClient();
      client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      http.StreamedResponse streamedResponse = await IOClient(client)
          .send(request).timeout(Duration(seconds: timeout));

      // var result = await request.send().timeout(Duration(seconds: timeout));

      if (streamedResponse.statusCode == 200) {
        return streamedResponse.stream.bytesToString();
      } else {
        throw (await http.Response.fromStream(streamedResponse)).body;
      }
    } catch (ex) {

      if(kDebugMode) {
        print(ex.toString());
      }else{
        // FirebaseCrashlytics.instance.recordFlutterFatalError(FlutterErrorDetails(exception: ex.toString()));
      }
      var error = json.decode(ex.toString());
      throw ErrorModel(
          status: error['statusCode'],
          message: error['message']
      );
    }
  }


}