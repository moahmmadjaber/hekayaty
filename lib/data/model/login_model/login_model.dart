class LoginModel {
  String? name;
  String? token;

  LoginModel({this.name, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['token'] = this.token;
    return data;
  }
}