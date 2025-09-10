import 'dart:convert';

CustomerLoginPostRequest customerLoginPostRequestFromJson(String str) =>
    CustomerLoginPostRequest.fromJson(json.decode(str));

String customerLoginPostRequestToJson(CustomerLoginPostRequest data) =>
    json.encode(data.toJson());

class CustomerLoginPostRequest {
  String phone;
  String password;

  CustomerLoginPostRequest({required this.phone, required this.password});

  factory CustomerLoginPostRequest.fromJson(Map<String, dynamic> json) =>
      CustomerLoginPostRequest(
        phone: json["phone"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {"phone": phone, "password": password};
}

class Customer {
  int idx;
  String fullname;
  String phone;
  String email;
  String image;

  Customer({
    required this.idx,
    required this.fullname,
    required this.phone,
    required this.email,
    required this.image,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    idx: json["idx"],
    fullname: json["fullname"],
    phone: json["phone"],
    email: json["email"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "idx": idx,
    "fullname": fullname,
    "phone": phone,
    "email": email,
    "image": image,
  };
}
