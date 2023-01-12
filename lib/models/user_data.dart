class UserDataModel {
  String id, name, email, phoneNumber, profilePicture;
  double balance;

  UserDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.balance,
  });

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      profilePicture: map['profilePicture'],
      balance: map['balance'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'balance': balance,
    };
  }
}
