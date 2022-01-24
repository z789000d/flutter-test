import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';

class ApiPost {
  String apiAdress = "https://34.80.190.22/app/";

  String getTokon() {
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    print(formattedDate);
    return formattedDate;
  }

  Future<Response> post() async {

    var url = 'https://www.funbid.com.hk/app/index.php';
    var body = {'tokon': '24/01/2022', 'id': '', 'domain': 'yahoojp'};

    FormData formData = FormData.fromMap(body);

    return Dio().post(url, data: formData);
  }
}
