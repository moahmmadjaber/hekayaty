class ConfirmationModel {
  int? id;
  String? orderNumber;
  int? totalAmount;
  String? status;
  String? paymentMethod;
  DateTime? orderDate;
  String? cashierName;
  List<Items>? items;
  int? amountBeforeDiscount;

  ConfirmationModel(
      {this.id,
        this.orderNumber,
        this.totalAmount,
        this.status,
        this.paymentMethod,
        this.orderDate,
        this.cashierName,
        this.items,
        this.amountBeforeDiscount});

  ConfirmationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['orderNumber'];
    totalAmount = json['totalAmount'];
    status = json['status'];
    paymentMethod = json['paymentMethod'];
    orderDate = DateTime.tryParse(json['orderDate']);
    cashierName = json['cashierName'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    amountBeforeDiscount = json['amountBeforeDiscount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderNumber'] = this.orderNumber;
    data['totalAmount'] = this.totalAmount;
    data['status'] = this.status;
    data['paymentMethod'] = this.paymentMethod;
    data['orderDate'] = this.orderDate;
    data['cashierName'] = this.cashierName;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['amountBeforeDiscount'] = this.amountBeforeDiscount;
    return data;
  }
}

class Items {
  int? id;
  String? subCategoryName;
  int? quantity;
  int? unitPrice;
  int? totalPrice;

  Items(
      {this.id,
        this.subCategoryName,
        this.quantity,
        this.unitPrice,
        this.totalPrice});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subCategoryName = json['subCategoryName'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subCategoryName'] = this.subCategoryName;
    data['quantity'] = this.quantity;
    data['unitPrice'] = this.unitPrice;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}
