import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groupup/models/participant.dart';

class CreateGroupModel {
  String projectName, objective, reward, groupCode;
  String? image;
  int maxParticipants;
  DateTime? startDate, endDate;
  bool allowEditImage, allowRefundRequest;
  List<String> participants = [];
  List<Participant> participantsData = [];

  CreateGroupModel({
    required this.projectName,
    required this.objective,
    required this.reward,
    required this.groupCode,
    required this.maxParticipants,
    required this.allowEditImage,
    required this.allowRefundRequest,
    this.image,
    this.startDate,
    this.endDate,
  });

  factory CreateGroupModel.empty() {
    return CreateGroupModel(
      projectName: '',
      objective: '',
      reward: '',
      groupCode: '',
      maxParticipants: 0,
      allowEditImage: false,
      allowRefundRequest: false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'projectName': projectName,
      'objective': objective,
      'reward': reward,
      'groupCode': groupCode,
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
