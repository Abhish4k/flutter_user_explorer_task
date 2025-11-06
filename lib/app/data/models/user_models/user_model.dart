import 'package:user_explorer/app/data/models/user_models/user_address_model.dart';
import 'package:user_explorer/app/data/models/user_models/user_company_model.dart';

class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final UserAddressModel address;
  final String phone;
  final String website;
  final UserCompanyModel company;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      address: UserAddressModel.fromJson(json['address'] ?? {}),
      phone: json['phone'] ?? '',
      website: json['website'] ?? '',
      company: UserCompanyModel.fromJson(json['company'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'address': address.toJson(),
      'phone': phone,
      'website': website,
      'company': company.toJson(),
    };
  }
}
