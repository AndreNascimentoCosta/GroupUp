class GeneralGroupInfoModel {
  final String title, objective, reward;
  DateTime startDate, endDate;
  final String groupCode;
  
  GeneralGroupInfoModel({
    required this.title,
    required this.objective,
    required this.reward,
    required this.startDate,
    required this.endDate,
    required this.groupCode,
  });
}