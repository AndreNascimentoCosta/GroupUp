import 'package:groupup/models/user_data.dart';

class IndividualGroup {
  final String name, image, rank, value, expand;

  final List<UserData> userData;

  IndividualGroup({
    required this.name,
    required this.image,
    required this.rank,
    required this.value,
    required this.expand,
    required this.userData,
  });
}