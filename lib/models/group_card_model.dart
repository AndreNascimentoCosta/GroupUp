class GroupCardModel {
  final String image, projectName;
  final String? rank, daysGone, daysLeft;

  GroupCardModel({
    required this.image,
    required this.projectName,
    this.rank,
    this.daysGone,
    this.daysLeft,
  });
}