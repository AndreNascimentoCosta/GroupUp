class UserDataModel {
  String id, name, email, phoneNumber, profilePicture;

  UserDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      profilePicture: map['profilePicture'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
    };
  }
}
