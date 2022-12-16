import 'package:groupup/models/user_information.dart';
import 'package:groupup/models/user_input_data.dart';
import 'package:groupup/models/general_group_info.dart';

class GroupModel {
  final String title,
      image,
      rank,
      daysGone,
      daysLeft,
      rankIcon,
      daysGoneIcon,
      daysLeftIcon;

  final GeneralGroupInfoModel generalGroupInfoModel;
  final List<UserInformation> userInformation;
  final UserInformation meUserInformation;

  GroupModel({
    required this.generalGroupInfoModel,
    required this.userInformation,
    required this.meUserInformation,
    required this.title,
    required this.image,
    required this.rank,
    required this.daysGone,
    required this.daysLeft,
    required this.rankIcon,
    required this.daysGoneIcon,
    required this.daysLeftIcon,
  });
}

List groupsData = [
  GroupModel(
    generalGroupInfoModel: GeneralGroupInfoModel(
      title: "RunForestRun",
      objective: "Run more",
      reward: "100 dollars",
      objectiveIcon: "assets/icons/objective.png",
      rewardIcon: "assets/icons/reward.png",
      startDate: DateTime(2022, 10, 01),
      endDate: DateTime(2022, 12, 31),
      groupCode: '5SYU65',
    ),
    meUserInformation:
      UserInformation(
          name: "Me",
          image: "assets/images/user_individual_group_3.png",
          rank: "3°",
          value: "10.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 6,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 1.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
    userInformation: [
      UserInformation(
          name: "Harmony Cope",
          image: "assets/images/user_individual_group_1.png",
          rank: "1°",
          value: "12.3",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 4,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1.3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 2.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 1,
            ),
          ]),
      UserInformation(
        name: "Sledge Hammer",
        image: "assets/images/user_individual_group_2.png",
        rank: "2°",
        value: "10.5",
        expand: "assets/icons/arrow_down.png",
        userInputData: [
          UserInputData(
            date: DateTime(2022, 11, 5),
            value: 4,
          ),
          UserInputData(
            date: DateTime(2022, 11, 6),
            value: 1.2,
          ),
          UserInputData(
            date: DateTime(2022, 11, 7),
            value: 1.3,
          ),
          UserInputData(
            date: DateTime(2022, 11, 8),
            value: 1,
          ),
          UserInputData(
            date: DateTime(2022, 11, 9),
            value: 2.5,
          ),
          UserInputData(
            date: DateTime(2022, 11, 10),
            value: 0.5,
          ),
          UserInputData(
            date: DateTime(2022, 11, 11),
            value: 0,
          ),
        ],
      ),
      UserInformation(
          name: "Devon Miles",
          image: "assets/images/user_individual_group_4.png",
          rank: "4°",
          value: "9.7",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 1.2,
            ),
          ]),
      UserInformation(
          name: "Kate Tanner",
          image: "assets/images/user_individual_group_5.png",
          rank: "5°",
          value: "9.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Angela Bower",
          image: "assets/images/user_individual_group_6.png",
          rank: "6°",
          value: "8.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Peter Thornton",
          image: "assets/images/user_individual_group_7.png",
          rank: "7°",
          value: "7.3",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.7,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2.6,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Jonathan Higg...",
          image: "assets/images/user_individual_group_8.png",
          rank: "8°",
          value: "6.4",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0.4,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0.5,
            ),
          ]),
      UserInformation(
          name: "Angus MacGyv...",
          image: "assets/images/user_individual_group_9.png",
          rank: "9°",
          value: "5.8",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 2.3,
            ),
          ]),
      UserInformation(
          name: "Alfredo Westerv...",
          image: "assets/images/user_individual_group_10.png",
          rank: "10°",
          value: "5.8",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0.3,
            ),
          ]),
    ],
    title: "#RunForestRun",
    image: "assets/images/runforest.png",
    rank: "3",
    daysGone: "10",
    daysLeft: "20",
    rankIcon: "assets/icons/rank.png",
    daysGoneIcon: "assets/icons/daysgone.png",
    daysLeftIcon: "assets/icons/daysleft.png",
  ),
  GroupModel(
    generalGroupInfoModel: GeneralGroupInfoModel(
      title: "ShitProject",
      objective: "Shit more",
      reward: "50 toilet paper rolls",
      objectiveIcon: "assets/icons/objective.png",
      rewardIcon: "assets/icons/reward.png",
      startDate: DateTime(2022, 10, 01),
      endDate: DateTime(2022, 12, 31),
      groupCode: '5SYU65',
    ),
    meUserInformation:
      UserInformation(
          name: "Me",
          image: "assets/images/user_individual_group_3.png",
          rank: "3°",
          value: "10.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 6,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 1.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
    userInformation: [
      UserInformation(
          name: "Harmony Cope",
          image: "assets/images/user_individual_group_1.png",
          rank: "1°",
          value: "12.3",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 4,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1.3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 2.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 1,
            ),
          ]),
      UserInformation(
        name: "Sledge Hammer",
        image: "assets/images/user_individual_group_2.png",
        rank: "2°",
        value: "10.5",
        expand: "assets/icons/arrow_down.png",
        userInputData: [
          UserInputData(
            date: DateTime(2022, 11, 5),
            value: 4,
          ),
          UserInputData(
            date: DateTime(2022, 11, 6),
            value: 1.2,
          ),
          UserInputData(
            date: DateTime(2022, 11, 7),
            value: 1.3,
          ),
          UserInputData(
            date: DateTime(2022, 11, 8),
            value: 1,
          ),
          UserInputData(
            date: DateTime(2022, 11, 9),
            value: 2.5,
          ),
          UserInputData(
            date: DateTime(2022, 11, 10),
            value: 0.5,
          ),
          UserInputData(
            date: DateTime(2022, 11, 11),
            value: 0,
          ),
        ],
      ),
      UserInformation(
          name: "Devon Miles",
          image: "assets/images/user_individual_group_4.png",
          rank: "4°",
          value: "9.7",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 1.2,
            ),
          ]),
      UserInformation(
          name: "Kate Tanner",
          image: "assets/images/user_individual_group_5.png",
          rank: "5°",
          value: "9.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Angela Bower",
          image: "assets/images/user_individual_group_6.png",
          rank: "6°",
          value: "8.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Peter Thornton",
          image: "assets/images/user_individual_group_7.png",
          rank: "7°",
          value: "7.3",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.7,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2.6,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Jonathan Higg...",
          image: "assets/images/user_individual_group_8.png",
          rank: "8°",
          value: "6.4",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0.4,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0.5,
            ),
          ]),
      UserInformation(
          name: "Angus MacGyv...",
          image: "assets/images/user_individual_group_9.png",
          rank: "9°",
          value: "5.8",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 2.3,
            ),
          ]),
      UserInformation(
          name: "Alfredo Westerv...",
          image: "assets/images/user_individual_group_10.png",
          rank: "10°",
          value: "5.8",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0.3,
            ),
          ]),
    ],
    title: "#ShitProject",
    image: "assets/images/shitproject.jpg",
    rank: "8",
    daysGone: "3",
    daysLeft: "11",
    rankIcon: "assets/icons/rank.png",
    daysGoneIcon: "assets/icons/daysgone.png",
    daysLeftIcon: "assets/icons/daysleft.png",
  ),
  GroupModel(
    generalGroupInfoModel: GeneralGroupInfoModel(
      title: "NoPainNoGain",
      objective: "Climb more stairs",
      reward: "30 dollars",
      objectiveIcon: "assets/icons/objective.png",
      rewardIcon: "assets/icons/reward.png",
      startDate: DateTime(2022, 09, 20),
      endDate: DateTime(2022, 12, 31),
      groupCode: '5SYU65',
    ),
    meUserInformation:
      UserInformation(
          name: "Me",
          image: "assets/images/user_individual_group_3.png",
          rank: "3°",
          value: "10.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 6,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 1.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(date: DateTime(2022, 11, 10), value: 0),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
    userInformation: [
      UserInformation(
          name: "Harmony Cope",
          image: "assets/images/user_individual_group_1.png",
          rank: "1°",
          value: "12.3",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 4,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1.3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 2.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 1,
            ),
          ]),
      UserInformation(
        name: "Sledge Hammer",
        image: "assets/images/user_individual_group_2.png",
        rank: "2°",
        value: "10.5",
        expand: "assets/icons/arrow_down.png",
        userInputData: [
          UserInputData(
            date: DateTime(2022, 11, 5),
            value: 4,
          ),
          UserInputData(
            date: DateTime(2022, 11, 6),
            value: 1.2,
          ),
          UserInputData(
            date: DateTime(2022, 11, 7),
            value: 1.3,
          ),
          UserInputData(
            date: DateTime(2022, 11, 8),
            value: 1,
          ),
          UserInputData(
            date: DateTime(2022, 11, 9),
            value: 2.5,
          ),
          UserInputData(
            date: DateTime(2022, 11, 10),
            value: 0.5,
          ),
          UserInputData(
            date: DateTime(2022, 11, 11),
            value: 0,
          ),
        ],
      ),
      UserInformation(
          name: "Devon Miles",
          image: "assets/images/user_individual_group_4.png",
          rank: "4°",
          value: "9.7",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 1.2,
            ),
          ]),
      UserInformation(
          name: "Kate Tanner",
          image: "assets/images/user_individual_group_5.png",
          rank: "5°",
          value: "9.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Angela Bower",
          image: "assets/images/user_individual_group_6.png",
          rank: "6°",
          value: "8.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Peter Thornton",
          image: "assets/images/user_individual_group_7.png",
          rank: "7°",
          value: "7.3",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.7,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2.6,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Jonathan Higg...",
          image: "assets/images/user_individual_group_8.png",
          rank: "8°",
          value: "6.4",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0.4,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0.5,
            ),
          ]),
      UserInformation(
          name: "Angus MacGyv...",
          image: "assets/images/user_individual_group_9.png",
          rank: "9°",
          value: "5.8",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 2.3,
            ),
          ]),
      UserInformation(
          name: "Alfredo Westerv...",
          image: "assets/images/user_individual_group_10.png",
          rank: "10°",
          value: "5.8",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0.3,
            ),
          ]),
    ],
    title: "#NoPainNoGain",
    image: "assets/images/nopainnogain.png",
    rank: "3",
    daysGone: "22",
    daysLeft: "5",
    rankIcon: "assets/icons/rank.png",
    daysGoneIcon: "assets/icons/daysgone.png",
    daysLeftIcon: "assets/icons/daysleft.png",
  ),
  GroupModel(
    generalGroupInfoModel: GeneralGroupInfoModel(
      title: "FattyBelly",
      objective: "Eat more",
      reward: "10 donuts",
      objectiveIcon: "assets/icons/objective.png",
      rewardIcon: "assets/icons/reward.png",
      startDate: DateTime(2022, 10, 15),
      endDate: DateTime(2022, 12, 31),
      groupCode: '5SYU65',
    ),
    meUserInformation:
      UserInformation(
          name: "Me",
          image: "assets/images/user_individual_group_3.png",
          rank: "3°",
          value: "10.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 6,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 1.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(date: DateTime(2022, 11, 10), value: 0),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
    userInformation: [
      UserInformation(
          name: "Harmony Cope",
          image: "assets/images/user_individual_group_1.png",
          rank: "1°",
          value: "12.3",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 4,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1.3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 2.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 1,
            ),
          ]),
      UserInformation(
        name: "Sledge Hammer",
        image: "assets/images/user_individual_group_2.png",
        rank: "2°",
        value: "10.5",
        expand: "assets/icons/arrow_down.png",
        userInputData: [
          UserInputData(
            date: DateTime(2022, 11, 5),
            value: 4,
          ),
          UserInputData(
            date: DateTime(2022, 11, 6),
            value: 1.2,
          ),
          UserInputData(
            date: DateTime(2022, 11, 7),
            value: 1.3,
          ),
          UserInputData(
            date: DateTime(2022, 11, 8),
            value: 1,
          ),
          UserInputData(
            date: DateTime(2022, 11, 9),
            value: 2.5,
          ),
          UserInputData(
            date: DateTime(2022, 11, 10),
            value: 0.5,
          ),
          UserInputData(
            date: DateTime(2022, 11, 11),
            value: 0,
          ),
        ],
      ),
      UserInformation(
          name: "Devon Miles",
          image: "assets/images/user_individual_group_4.png",
          rank: "4°",
          value: "9.7",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 1.2,
            ),
          ]),
      UserInformation(
          name: "Kate Tanner",
          image: "assets/images/user_individual_group_5.png",
          rank: "5°",
          value: "9.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Angela Bower",
          image: "assets/images/user_individual_group_6.png",
          rank: "6°",
          value: "8.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Peter Thornton",
          image: "assets/images/user_individual_group_7.png",
          rank: "7°",
          value: "7.3",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.7,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2.6,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Jonathan Higg...",
          image: "assets/images/user_individual_group_8.png",
          rank: "8°",
          value: "6.4",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0.4,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0.5,
            ),
          ]),
      UserInformation(
          name: "Angus MacGyv...",
          image: "assets/images/user_individual_group_9.png",
          rank: "9°",
          value: "5.8",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 2.3,
            ),
          ]),
      UserInformation(
          name: "Alfredo Westerv...",
          image: "assets/images/user_individual_group_10.png",
          rank: "10°",
          value: "5.8",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0.3,
            ),
          ]),
    ],
    title: "#FattyBelly",
    image: "assets/images/fattybelly.png",
    rank: "5",
    daysGone: "38",
    daysLeft: "42",
    rankIcon: "assets/icons/rank.png",
    daysGoneIcon: "assets/icons/daysgone.png",
    daysLeftIcon: "assets/icons/daysleft.png",
  ),
  GroupModel(
    generalGroupInfoModel: GeneralGroupInfoModel(
      title: "RunForestRun",
      objective: "Run more",
      reward: "100 dollars",
      objectiveIcon: "assets/icons/objective.png",
      rewardIcon: "assets/icons/reward.png",
      startDate: DateTime(2022, 10, 01),
      endDate: DateTime(2022, 12, 31),
      groupCode: '5SYU65',
    ),
    meUserInformation: 
      UserInformation(
          name: "Me",
          image: "assets/images/user_individual_group_3.png",
          rank: "3°",
          value: "10.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 6,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 1.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(date: DateTime(2022, 11, 10), value: 0),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
    userInformation: [
      UserInformation(
          name: "Harmony Cope",
          image: "assets/images/user_individual_group_1.png",
          rank: "1°",
          value: "12.3",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 4,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1.3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 2.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 1,
            ),
          ]),
      UserInformation(
        name: "Sledge Hammer",
        image: "assets/images/user_individual_group_2.png",
        rank: "2°",
        value: "10.5",
        expand: "assets/icons/arrow_down.png",
        userInputData: [
          UserInputData(
            date: DateTime(2022, 11, 5),
            value: 4,
          ),
          UserInputData(
            date: DateTime(2022, 11, 6),
            value: 1.2,
          ),
          UserInputData(
            date: DateTime(2022, 11, 7),
            value: 1.3,
          ),
          UserInputData(
            date: DateTime(2022, 11, 8),
            value: 1,
          ),
          UserInputData(
            date: DateTime(2022, 11, 9),
            value: 2.5,
          ),
          UserInputData(
            date: DateTime(2022, 11, 10),
            value: 0.5,
          ),
          UserInputData(
            date: DateTime(2022, 11, 11),
            value: 0,
          ),
        ],
      ),
      UserInformation(
          name: "Devon Miles",
          image: "assets/images/user_individual_group_4.png",
          rank: "4°",
          value: "9.7",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 1.2,
            ),
          ]),
      UserInformation(
          name: "Kate Tanner",
          image: "assets/images/user_individual_group_5.png",
          rank: "5°",
          value: "9.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Angela Bower",
          image: "assets/images/user_individual_group_6.png",
          rank: "6°",
          value: "8.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Peter Thornton",
          image: "assets/images/user_individual_group_7.png",
          rank: "7°",
          value: "7.3",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.7,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2.6,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Jonathan Higg...",
          image: "assets/images/user_individual_group_8.png",
          rank: "8°",
          value: "6.4",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0.4,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0.5,
            ),
          ]),
      UserInformation(
          name: "Angus MacGyv...",
          image: "assets/images/user_individual_group_9.png",
          rank: "9°",
          value: "5.8",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 2.3,
            ),
          ]),
      UserInformation(
          name: "Alfredo Westerv...",
          image: "assets/images/user_individual_group_10.png",
          rank: "10°",
          value: "5.8",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0.3,
            ),
          ]),
    ],
    title: "#RunForestRun",
    image: "assets/images/runforest.png",
    rank: "3",
    daysGone: "10",
    daysLeft: "20",
    rankIcon: "assets/icons/rank.png",
    daysGoneIcon: "assets/icons/daysgone.png",
    daysLeftIcon: "assets/icons/daysleft.png",
  ),
  GroupModel(
    generalGroupInfoModel: GeneralGroupInfoModel(
      title: "ShitProject",
      objective: "Shit more",
      reward: "50 toilet paper roll",
      objectiveIcon: "assets/icons/objective.png",
      rewardIcon: "assets/icons/reward.png",
      startDate: DateTime(2022, 09, 15),
      endDate: DateTime(2022, 12, 31),
      groupCode: '5SYU65',
    ),
    meUserInformation: 
      UserInformation(
          name: "Me",
          image: "assets/images/user_individual_group_3.png",
          rank: "3°",
          value: "10.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 6,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 1.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(date: DateTime(2022, 11, 10), value: 0),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
    userInformation: [
      UserInformation(
          name: "Harmony Cope",
          image: "assets/images/user_individual_group_1.png",
          rank: "1°",
          value: "12.3",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 4,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1.3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 2.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 1,
            ),
          ]),
      UserInformation(
        name: "Sledge Hammer",
        image: "assets/images/user_individual_group_2.png",
        rank: "2°",
        value: "10.5",
        expand: "assets/icons/arrow_down.png",
        userInputData: [
          UserInputData(
            date: DateTime(2022, 11, 5),
            value: 4,
          ),
          UserInputData(
            date: DateTime(2022, 11, 6),
            value: 1.2,
          ),
          UserInputData(
            date: DateTime(2022, 11, 7),
            value: 1.3,
          ),
          UserInputData(
            date: DateTime(2022, 11, 8),
            value: 1,
          ),
          UserInputData(
            date: DateTime(2022, 11, 9),
            value: 2.5,
          ),
          UserInputData(
            date: DateTime(2022, 11, 10),
            value: 0.5,
          ),
          UserInputData(
            date: DateTime(2022, 11, 11),
            value: 0,
          ),
        ],
      ),
      UserInformation(
          name: "Devon Miles",
          image: "assets/images/user_individual_group_4.png",
          rank: "4°",
          value: "9.7",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 1.2,
            ),
          ]),
      UserInformation(
          name: "Kate Tanner",
          image: "assets/images/user_individual_group_5.png",
          rank: "5°",
          value: "9.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Angela Bower",
          image: "assets/images/user_individual_group_6.png",
          rank: "6°",
          value: "8.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Peter Thornton",
          image: "assets/images/user_individual_group_7.png",
          rank: "7°",
          value: "7.3",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.7,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2.6,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Jonathan Higg...",
          image: "assets/images/user_individual_group_8.png",
          rank: "8°",
          value: "6.4",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0.4,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0.5,
            ),
          ]),
      UserInformation(
          name: "Angus MacGyv...",
          image: "assets/images/user_individual_group_9.png",
          rank: "9°",
          value: "5.8",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 2.3,
            ),
          ]),
      UserInformation(
          name: "Alfredo Westerv...",
          image: "assets/images/user_individual_group_10.png",
          rank: "10°",
          value: "5.8",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0.3,
            ),
          ]),
    ],
    title: "#ShitProject",
    image: "assets/images/shitproject.jpg",
    rank: "8",
    daysGone: "3",
    daysLeft: "11",
    rankIcon: "assets/icons/rank.png",
    daysGoneIcon: "assets/icons/daysgone.png",
    daysLeftIcon: "assets/icons/daysleft.png",
  ),
  GroupModel(
    generalGroupInfoModel: GeneralGroupInfoModel(
      title: "NoPainNoGain",
      objective: "Climb more stairs",
      reward: "30 dollars",
      objectiveIcon: "assets/icons/objective.png",
      rewardIcon: "assets/icons/reward.png",
      startDate: DateTime(2022, 09, 20),
      endDate: DateTime(2022, 12, 31),
      groupCode: '5SYU65',
    ),
    meUserInformation: 
      UserInformation(
          name: "Me",
          image: "assets/images/user_individual_group_3.png",
          rank: "3°",
          value: "10.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 6,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 1.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(date: DateTime(2022, 11, 10), value: 0),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
    userInformation: [
      UserInformation(
          name: "Harmony Cope",
          image: "assets/images/user_individual_group_1.png",
          rank: "1°",
          value: "12.3",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 4,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1.3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 2.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 1,
            ),
          ]),
      UserInformation(
        name: "Sledge Hammer",
        image: "assets/images/user_individual_group_2.png",
        rank: "2°",
        value: "10.5",
        expand: "assets/icons/arrow_down.png",
        userInputData: [
          UserInputData(
            date: DateTime(2022, 11, 5),
            value: 4,
          ),
          UserInputData(
            date: DateTime(2022, 11, 6),
            value: 1.2,
          ),
          UserInputData(
            date: DateTime(2022, 11, 7),
            value: 1.3,
          ),
          UserInputData(
            date: DateTime(2022, 11, 8),
            value: 1,
          ),
          UserInputData(
            date: DateTime(2022, 11, 9),
            value: 2.5,
          ),
          UserInputData(
            date: DateTime(2022, 11, 10),
            value: 0.5,
          ),
          UserInputData(
            date: DateTime(2022, 11, 11),
            value: 0,
          ),
        ],
      ),
      UserInformation(
          name: "Devon Miles",
          image: "assets/images/user_individual_group_4.png",
          rank: "4°",
          value: "9.7",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 1.2,
            ),
          ]),
      UserInformation(
          name: "Kate Tanner",
          image: "assets/images/user_individual_group_5.png",
          rank: "5°",
          value: "9.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Angela Bower",
          image: "assets/images/user_individual_group_6.png",
          rank: "6°",
          value: "8.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Peter Thornton",
          image: "assets/images/user_individual_group_7.png",
          rank: "7°",
          value: "7.3",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.7,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2.6,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Jonathan Higg...",
          image: "assets/images/user_individual_group_8.png",
          rank: "8°",
          value: "6.4",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0.4,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0.5,
            ),
          ]),
      UserInformation(
          name: "Angus MacGyv...",
          image: "assets/images/user_individual_group_9.png",
          rank: "9°",
          value: "5.8",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 2.3,
            ),
          ]),
      UserInformation(
          name: "Alfredo Westerv...",
          image: "assets/images/user_individual_group_10.png",
          rank: "10°",
          value: "5.8",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0.3,
            ),
          ]),
    ],
    title: "#NoPainNoGain",
    image: "assets/images/nopainnogain.png",
    rank: "3",
    daysGone: "22",
    daysLeft: "5",
    rankIcon: "assets/icons/rank.png",
    daysGoneIcon: "assets/icons/daysgone.png",
    daysLeftIcon: "assets/icons/daysleft.png",
  ),
  GroupModel(
    generalGroupInfoModel: GeneralGroupInfoModel(
      title: "FattyBelly",
      objective: "Eat more",
      reward: "10 donuts",
      objectiveIcon: "assets/icons/objective.png",
      rewardIcon: "assets/icons/reward.png",
      startDate: DateTime(2022, 10, 15),
      endDate: DateTime(2022, 12, 31),
      groupCode: '5SYU65',
    ),
    meUserInformation: 
      UserInformation(
          name: "Me",
          image: "assets/images/user_individual_group_3.png",
          rank: "3°",
          value: "10.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 6,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 1.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(date: DateTime(2022, 11, 10), value: 0),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
    userInformation: [
      UserInformation(
          name: "Harmony Cope",
          image: "assets/images/user_individual_group_1.png",
          rank: "1°",
          value: "12.3",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 4,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1.3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 2.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 1,
            ),
          ]),
      UserInformation(
        name: "Sledge Hammer",
        image: "assets/images/user_individual_group_2.png",
        rank: "2°",
        value: "10.5",
        expand: "assets/icons/arrow_down.png",
        userInputData: [
          UserInputData(
            date: DateTime(2022, 11, 5),
            value: 4,
          ),
          UserInputData(
            date: DateTime(2022, 11, 6),
            value: 1.2,
          ),
          UserInputData(
            date: DateTime(2022, 11, 7),
            value: 1.3,
          ),
          UserInputData(
            date: DateTime(2022, 11, 8),
            value: 1,
          ),
          UserInputData(
            date: DateTime(2022, 11, 9),
            value: 2.5,
          ),
          UserInputData(
            date: DateTime(2022, 11, 10),
            value: 0.5,
          ),
          UserInputData(
            date: DateTime(2022, 11, 11),
            value: 0,
          ),
        ],
      ),
      UserInformation(
          name: "Devon Miles",
          image: "assets/images/user_individual_group_4.png",
          rank: "4°",
          value: "9.7",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 1.2,
            ),
          ]),
      UserInformation(
          name: "Kate Tanner",
          image: "assets/images/user_individual_group_5.png",
          rank: "5°",
          value: "9.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Angela Bower",
          image: "assets/images/user_individual_group_6.png",
          rank: "6°",
          value: "8.2",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1.2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Peter Thornton",
          image: "assets/images/user_individual_group_7.png",
          rank: "7°",
          value: "7.3",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.7,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 2.6,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0,
            ),
          ]),
      UserInformation(
          name: "Jonathan Higg...",
          image: "assets/images/user_individual_group_8.png",
          rank: "8°",
          value: "6.4",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 3,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0.4,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0.5,
            ),
          ]),
      UserInformation(
          name: "Angus MacGyv...",
          image: "assets/images/user_individual_group_9.png",
          rank: "9°",
          value: "5.8",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 2.3,
            ),
          ]),
      UserInformation(
          name: "Alfredo Westerv...",
          image: "assets/images/user_individual_group_10.png",
          rank: "10°",
          value: "5.8",
          expand: "assets/icons/arrow_down.png",
          userInputData: [
            UserInputData(
              date: DateTime(2022, 11, 5),
              value: 0.5,
            ),
            UserInputData(
              date: DateTime(2022, 11, 6),
              value: 2,
            ),
            UserInputData(
              date: DateTime(2022, 11, 7),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 8),
              value: 0,
            ),
            UserInputData(
              date: DateTime(2022, 11, 9),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 10),
              value: 1,
            ),
            UserInputData(
              date: DateTime(2022, 11, 11),
              value: 0.3,
            ),
          ]),
    ],
    title: "#FattyBelly",
    image: "assets/images/fattybelly.png",
    rank: "5",
    daysGone: "38",
    daysLeft: "42",
    rankIcon: "assets/icons/rank.png",
    daysGoneIcon: "assets/icons/daysgone.png",
    daysLeftIcon: "assets/icons/daysleft.png",
  ),
];
