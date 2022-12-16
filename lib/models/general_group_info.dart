class GeneralGroupInfoModel {
  final String title, objective, reward, objectiveIcon, rewardIcon;
  DateTime startDate, endDate;
  final String groupCode;
  
  GeneralGroupInfoModel({
    required this.title,
    required this.objective,
    required this.reward,
    required this.objectiveIcon,
    required this.rewardIcon,
    required this.startDate,
    required this.endDate,
    required this.groupCode,
  });
}