import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    required this.amount,
    required this.accountName,
    required this.accountNumber,

  });

  int amount;
  String accountName;
  String accountNumber;


  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    amount: json["amount"],
    accountName: json["accountName"],
    accountNumber: json["accountNumber"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "accountName": accountName,
    "accountNumber": accountNumber,
  };
}

