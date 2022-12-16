import 'package:groupup/models/user_input_data.dart';

class UserInformation {
  final String name, image, rank, value, expand;

  final List<UserInputData> userInputData;

  UserInformation({
    required this.name,
    required this.image,
    required this.rank,
    required this.value,
    required this.expand,
    required this.userInputData,
  });
}