class CreateGroupModel {
  String projectName, objective, reward;
  String? image;
  int noParticipants;
  DateTime? startDate, endDate;
  bool allowEditImage, allowRefundRequest;

  CreateGroupModel({
    required this.projectName,
    required this.objective,
    required this.reward,
    required this.noParticipants,
    required this.allowEditImage,
    required this.allowRefundRequest,
    this.image,
    this.startDate,
    this.endDate,
  });
}
