class StoryModel {
  final String imageUrl;
  final double duration;
  final String caption;
  final String date;

  StoryModel({
    required this.imageUrl,
    required this.duration,
    required this.caption,
    required this.date,
  });

  static fromMap(e) {}
}