class SignUpModel {
  int? status;
  dynamic data;

  SignUpModel({this.status, this.data});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = json["data"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["data"] = data;
    return _data;
  }


}

// class SignUpModel {
//   late String accessToken;
//   String? email;
//   String? fullName;
//   String? password;
//
//   SignUpModel.fromJson(Map<String, dynamic> json) {
//     accessToken = json['access_token'];
//     email = json['email'];
//     fullName = json['fullName'];
//     password = json['password'];
//   }
// }
