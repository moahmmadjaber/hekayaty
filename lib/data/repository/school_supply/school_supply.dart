import 'dart:convert';

import '../../model/categories_model/categories_model.dart';
import '../../model/confirmation_model/confirmation_model.dart';
import '../../network/api.dart';

class SchoolSupplyRepository{
  Api api;
  SchoolSupplyRepository(this.api);
  Future<ConfirmationModel> order(List<SubCategories> order,) async {
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
  Future<SubCategories> getSubCategory(String barcode) async {
    try {

      final res = await api.callApi(
        null,
        '/api/categories/getSubById/$barcode',
      );

        return SubCategories.fromJson(json.decode(res));

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