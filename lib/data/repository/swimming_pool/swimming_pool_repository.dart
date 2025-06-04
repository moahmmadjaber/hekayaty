import 'dart:convert';

import '../../model/categories_model/categories_model.dart';
import '../../model/confirmation_model/confirmation_model.dart';
import '../../network/api.dart';

class SwimmingPoolRepository{
  Api api;
  SwimmingPoolRepository(this.api);



  Future<ConfirmationModel> order(List<SubCategories> order,discountPercentage,discountNote) async {
    try {
      final Map<int, int> itemCounts = {};
      for (var item in order) {
        itemCounts[item.id!] = (itemCounts[item.id] ?? 0) + 1;
      }
      final body = {
        "items": itemCounts.entries.map((entry) {
          return {
            "subCategoryId": entry.key,
            "quantity": entry.value,
          };
        }).toList(),
        "discountPercentage": discountPercentage,
        "discountNote": discountNote,
        "paymentMethod": "CASH",

      };
      // print(body);
      final res = await api.callApi(
        body,
        '/api/orders',
      );
      print(res);
      return ConfirmationModel.fromJson(jsonDecode(res));
    } catch (ex) {
      print(ex.toString());
      rethrow;
    }
  }
  Future<List<SubCategories>> getSubCategory(int categoryId) async {
    try {

      final res = await api.callApi(
        null,
        '/api/categories/main/$categoryId/subs',
      );
      if (res.isNotEmpty) {
        print(json.decode(res));
        Iterable l = json.decode(res);
        List<SubCategories> models = List<SubCategories>.from(
          l.map((model) => SubCategories.fromJson(model)),
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
  Future<ConfirmationModel> orderComplete(int orderId) async {
    try {

      final res = await api.callApi(null,'/api/orders/$orderId/complete',);
      print(res);
      return ConfirmationModel.fromJson(jsonDecode(res));
    } catch (ex) {
      print(ex.toString());
      rethrow;
    }
  }
}