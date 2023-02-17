class UserDataModel {
  String id, name, email, phoneNumber, profilePicture, stripeAccountId;
  double balance;
  List<String> paymentIntentIds;

  UserDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.balance,
    required this.stripeAccountId,
    required this.paymentIntentIds,
  });

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      profilePicture: map['profilePicture'],
      balance: double.parse(map['balance'].toString()),
      stripeAccountId: map['stripeAccountId'],
      paymentIntentIds: List<String>.from(map['paymentIntentIds'] ?? []),
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
      'stripeAccountId': stripeAccountId,
      'paymentIntentIds': paymentIntentIds,
    };
  }
}
