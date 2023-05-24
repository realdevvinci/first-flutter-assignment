import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_assignment/provider/currencieData.dart';
import 'package:provider/provider.dart';

class Fetching {
  Future<dynamic> fetchingData() async {
    try {
      final url =
          Uri.parse('https://exchangerate-api.p.rapidapi.com/rapid/latest/USD');
      final response = await http.get(
        url,
        headers: {
          'x-rapidapi-key':
              '33e7c31846msh7230bbe9fd64f0dp1bad35jsn0d74c2899475',
          'x-rapidapi-host': 'exchangerate-api.p.rapidapi.com',
        },
      );

      if (response.statusCode == 200) {
        Data().setResposeCode(response.statusCode);
        var decoder = JsonDecoder();
        var data = decoder.convert(response.body);
        return data;
      } else {
        Data().setResposeCode(response.statusCode);

        return response.statusCode;
      }
    } catch (e) {
      Data().setResposeCode(503);
    }
  }

  Future<List<dynamic>> getCurrencies() async {
    var data = await Fetching().fetchingData();

    if (Data.resposeCode == 200) {
      return data["rates"].keys.toList();
    } else {
      List error = [Data.resposeCode];
      return error;
    }
  }
}
