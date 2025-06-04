import 'dart:convert';

import 'package:hekayaty/data/model/categories_model/categories_model.dart';

import '../../network/api.dart';

class HomeRepository {
  Api api;

  HomeRepository(this.api);

  Future<bool> checkIsActive() async {
    try {
      final res = await api.callApi(null, '/V1/api/auth/CheckIsActive');
      print(res);
      return jsonDecode(res);
    } catch (ex) {
      print(ex.toString());
      rethrow;
    }
  }

  Future<bool> getCate() async {
    try {
      final res = await api.callApi(null, '/V1/api/auth/CheckIsActive');
      print(res);
      return jsonDecode(res);
    } catch (ex) {
      print(ex.toString());
      rethrow;
    }
  }

  Future<List<CategoriesModel>> getCategories() async {
    try {
      final res = await api.callApi(null, '/api/categories/main');
      if (res.isNotEmpty) {
        print(json.decode(res));
        Iterable l = json.decode(res);
        List<CategoriesModel> models = List<CategoriesModel>.from(
          l.map((model) => CategoriesModel.fromJson(model)),
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
