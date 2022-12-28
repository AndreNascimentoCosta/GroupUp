class UserInformation {
  final String name, username, email, phoneNumber, profilePicture;

  final List<String> groups;

  UserInformation({
    required this.name,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.groups,
  });

  factory UserInformation.fromMap(map) {
    return UserInformation(
        name: map['name'],
        username: map['username'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        profilePicture: map['profilePicture'],
        groups: map['groups']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'groups': groups,
    };
  }
}
