class UserCompanyModel {
  final String name;
  final String catchPhrase;
  final String bs;

  UserCompanyModel({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory UserCompanyModel.fromJson(Map<String, dynamic> json) {
    return UserCompanyModel(
      name: json['name'] ?? '',
      catchPhrase: json['catchPhrase'] ?? '',
      bs: json['bs'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'catchPhrase': catchPhrase, 'bs': bs};
  }
}
