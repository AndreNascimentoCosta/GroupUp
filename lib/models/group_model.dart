import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groupup/models/participant.dart';

class GroupModel {
  String id;
  String projectName, objective, reward, groupCode;
  String image;
  int maxParticipants;
  DateTime? startDate, endDate;
  bool allowEditImage, allowRefundRequest;
  List<String> participants;
  List<Participant> participantsData;

  Participant currentParticipant(String userId) {
    return participantsData.firstWhere(
      (element) => element.uid == userId,
    );
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
    required this.id,
    required this.projectName,
    required this.objective,
    required this.reward,
    required this.groupCode,
    required this.maxParticipants,
    required this.allowEditImage,
    required this.allowRefundRequest,
    required this.image,
    required this.participants,
    required this.participantsData,
    this.startDate,
    this.endDate,
  });

  factory GroupModel.empty() {
    return GroupModel(
      id: '',
      projectName: '',
      objective: '',
      reward: '',
      groupCode: '',
      image: '',
      participants: [],
      participantsData: [],
      maxParticipants: 0,
      allowEditImage: false,
      allowRefundRequest: false,
    );
  }

  factory GroupModel.fromMap(String id, Map<String, dynamic> map) {
    DateTime? startDate;
    DateTime? endDate;
    if (map['startDate'] is Timestamp) {
      startDate = (map['startDate'] as Timestamp).toDate();
    }
    if (map['endDate'] is Timestamp) {
      endDate = (map['endDate'] as Timestamp).toDate();
    }
    return GroupModel(
      id: id,
      projectName: map['projectName'] ?? '',
      objective: map['objective'] ?? '',
      reward: map['reward'] ?? '',
      groupCode: map['groupCode'] ?? '',
      image: map['image'] ?? '',
      participants: List<String>.from(map['participants'] ?? []),
      participantsData: List<Participant>.from(
        (map['participantsData'] ?? []).map(
          (e) => Participant.fromMap(e),
        ),
      ),
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
