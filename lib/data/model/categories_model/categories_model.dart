import '../../../presentation/app_resources/enum_manager.dart';

class CategoriesModel {
  int? id;
  String? name;
  String? description;
  bool? discountPercentage;
  String? color;
  CategoryType? categoryType;
  bool? haveCompanion;
  String? image;
  bool? active;

  CategoriesModel(
      {this.id,
        this.name,
        this.description,
        this.discountPercentage,
        this.color,
        this.categoryType,
        this.haveCompanion,
        this.image,
        this.active});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    discountPercentage = json['discountPercentage'];
    color = json['color'];
    categoryType = CategoryType.values[json['categoryType']];
    haveCompanion = json['haveCompanion'];
    image = json['image'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['discountPercentage'] = this.discountPercentage;
    data['color'] = this.color;
    data['categoryType'] = this.categoryType;
    data['haveCompanion'] = this.haveCompanion;
    data['image'] = this.image;
    data['active'] = this.active;
    return data;
  }
}

class SubCategories {
  int? id;
  String? name;
  String? description;
  int? price;
  bool? haveCompanion;
  int? wholesalePrice;
  String? image;
  int? mainCategoryId;
  String? mainCategoryName;
  bool? active;

  SubCategories(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.haveCompanion,
        this.wholesalePrice,
        this.image,
        this.mainCategoryId,
        this.mainCategoryName,
        this.active});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    haveCompanion = json['haveCompanion'];
    wholesalePrice = json['wholesalePrice'];
    image = json['image'];
    mainCategoryId = json['mainCategoryId'];
    mainCategoryName = json['mainCategoryName'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['haveCompanion'] = this.haveCompanion;
    data['wholesalePrice'] = this.wholesalePrice;
    data['image'] = this.image;
    data['mainCategoryId'] = this.mainCategoryId;
    data['mainCategoryName'] = this.mainCategoryName;
    data['active'] = this.active;
    return data;
  }
}
