import 'dart:convert';

import 'package:hekayaty/data/network/api.dart';

import '../../model/history_model/history_model.dart';

class HistoryRepository{
  Api api;
  HistoryRepository(this.api);
  Future<List<HistoryModel>> get() async {
    try {
      final res = await api.callApi(null, '/api/orders/cashier/{cashierId}');
      if (res.isNotEmpty) {
        print(json.decode(res));
        Iterable l = json.decode(res);
        List<HistoryModel> models = List<HistoryModel>.from(
          l.map((model) => HistoryModel.fromJson(model)),
        );

        return models;
      } else {
        throw 'null';
      }
    } catch (ex) {
      print(ex.toString());
      rethrow;
    }
  }

}