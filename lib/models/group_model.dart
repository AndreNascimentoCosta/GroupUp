import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groupup/models/participant.dart';

class GroupModel {
  String projectName, objective, reward, groupCode;
  String image;
  int maxParticipants;
  DateTime? startDate, endDate;
  bool allowEditImage, allowRefundRequest;
  List<String> participants = [];
  List<Participant> participantsData = [];

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

  GroupModel({
    required this.projectName,
    required this.objective,
    required this.reward,
    required this.groupCode,
    required this.maxParticipants,
    required this.allowEditImage,
    required this.allowRefundRequest,
    required this.image,
    this.startDate,
    this.endDate,
  });

  factory GroupModel.empty() {
    return GroupModel(
      projectName: '',
      objective: '',
      reward: '',
      groupCode: '',
      image: '',
      maxParticipants: 0,
      allowEditImage: false,
      allowRefundRequest: false,
    );
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    DateTime? startDate;
    DateTime? endDate;
    if (map['startDate'] is Timestamp) {
      startDate = (map['startDate'] as Timestamp).toDate();
    }
    if (map['endDate'] is Timestamp) {
      endDate = (map['endDate'] as Timestamp).toDate();
    }
    return GroupModel(
      projectName: map['projectName'] ?? '',
      objective: map['objective'] ?? '',
      reward: map['reward'] ?? '',
      groupCode: map['groupCode'] ?? '',
      image: map['image'] ?? '',
      maxParticipants: map['noParticipants'] ?? 0,
      allowEditImage: map['allowEditImage'] ?? false,
      allowRefundRequest: map['allowRefundRequest'] ?? false,
      startDate: startDate,
      endDate: endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'projectName': projectName,
      'objective': objective,
      'reward': reward,
      'groupCode': groupCode,
      'image': image,
      'noParticipants': maxParticipants,
      'allowEditImage': allowEditImage,
      'allowRefundRequest': allowRefundRequest,
      'createdAt': FieldValue.serverTimestamp(),
      'participants': participants,
      'participantsData': participantsData.map((e) => e.toMap()).toList(),
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}
