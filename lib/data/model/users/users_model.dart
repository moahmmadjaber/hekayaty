class UsersModel {
  String? name;
  String? token;



  UsersModel({   this.name,  this.token,});
  UsersModel.fromJson(Map<String, dynamic> json) {

    name = json['name'];
    token = json['token'];


  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['token'] = token;
    return data;
  }
}