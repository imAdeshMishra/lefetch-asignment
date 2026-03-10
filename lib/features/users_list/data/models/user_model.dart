import 'package:lafetch/features/users_list/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required int id,
    required String name,
    required String username,
    required String email,
    required Address address,
    required String phone,
    required String website,
    required Company company,
  }) : super(
          id: id,
          name: name,
          username: username,
          email: email,
          address: address,
          phone: phone,
          website: website,
          company: company,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      username: json['username'] ?? "",
      email: json['email'] ?? "",
      address: Address(
        street: json['address']?['street'] ?? "",
        suite: json['address']?['suite'] ?? "",
        city: json['address']?['city'] ?? "",
        zipcode: json['address']?['zipcode'] ?? "",
        geo: Geo(
          lat: json['address']?['geo']?['lat'] ?? "",
          lng: json['address']?['geo']?['lng'] ?? "",
        ),
      ),
      phone: json['phone'] ?? "",
      website: json['website'] ?? "",
      company: Company(
        name: json['company']?['name'] ?? "",
        catchPhrase: json['company']?['catchPhrase'] ?? "",
        bs: json['company']?['bs'] ?? "",
      ),
    );
  }
}