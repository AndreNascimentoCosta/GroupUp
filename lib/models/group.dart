import 'package:groupup/models/create_group_model.dart';
import 'package:groupup/models/participant.dart';
import 'package:groupup/models/user_information.dart';
import 'package:groupup/models/general_group_info.dart';

class GroupModel {
  final String projectName,
      image,
      rank,
      daysGone,
      daysLeft;

  final GeneralGroupInfoModel generalGroupInfoModel;
  final List<UserInformation> userInformation;
  final List<Participant> participant;
  final Participant meParticipant;
  final CreateGroupModel createGroupModel;

  GroupModel({
    required this.createGroupModel,
    required this.generalGroupInfoModel,
    required this.userInformation,
    required this.participant,
    required this.meParticipant,
    required this.projectName,
    required this.image,
    required this.rank,
    required this.daysGone,
    required this.daysLeft,
  });
}

