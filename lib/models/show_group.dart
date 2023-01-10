import 'package:cloud_firestore/cloud_firestore.dart';

class ShowGroupModel {
  final String image, projectName;
  final DateTime? startDate, endDate;

  String get rank {
    return '-'; // foda
  }

  String get daysGone {
    final startDate = this.startDate;
    if (startDate == null) return '-';
    final difference = startDate.difference(DateTime.now());
    if (difference.inDays > 0) return '0';
    return difference.inDays.abs().toString();
  }

  String get daysLeft {
    final endDate = this.endDate;
    final startDate = this.startDate;
    if (endDate == null || startDate == null) return '-';
    if (startDate.isAfter(DateTime.now())) return '0';
    final difference = DateTime.now().difference(endDate);
    return difference.inDays.abs().toString();
  }

  ShowGroupModel({
    required this.image,
    required this.projectName,
    this.startDate,
    this.endDate,
  });

  static ShowGroupModel fromJson(Map<String, dynamic> json) {
    DateTime? startDate;
    DateTime? endDate;
    if (json['startDate'] is Timestamp) {
      startDate = (json['startDate'] as Timestamp).toDate();
    }
    if (json['endDate'] is Timestamp) {
      endDate = (json['endDate'] as Timestamp).toDate();
    }
    return ShowGroupModel(
      image: json['image'] ?? "",
      projectName: json['projectName'] ?? "",
      startDate: startDate,
      endDate: endDate,
    );
  }
}
