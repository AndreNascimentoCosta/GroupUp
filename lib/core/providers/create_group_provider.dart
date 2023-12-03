// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/gu_text_body.dart';
import 'package:groupup/core/widgets/texts/gu_text_header.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/models/participant.dart';
import 'package:groupup/models/user_data.dart';
import 'package:groupup/screens/groups/screens/groups_screen.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'mix_panel_provider.dart';

enum Currencies {
  AND(0.3),
  AWG(0.3),
  AZN(0.3),
  BAM(0.3),
  BBD(0.3),
  BMD(0.3),
  BND(0.3),
  BSD(0.3),
  BZD(0.3),
  FKP(0.3),
  GBP(0.3),
  GIP(0.3),
  KYD(0.3),
  PAB(0.3),
  USD(0.5),
  AUD(0.5),
  BRL(0.5),
  BYN(0.5),
  CAD(0.5),
  CHF(0.5),
  EUR(0.5),
  FJD(0.5),
  GEL(0.5),
  HRK(0.5),
  ILS(0.5),
  INR(0.5),
  NZD(0.5),
  PEN(0.5),
  PGK(0.5),
  QAR(0.5),
  SGD(0.5),
  SAR(0.5),
  TJS(0.5),
  TOP(0.5),
  WST(0.5),
  XCD(0.5),
  BGN(1),
  BOB(1),
  CNY(1),
  GTQ(1),
  MOP(1),
  SBD(1),
  SHP(1),
  TTD(1),
  BWP(1.5),
  MAD(1.5),
  AED(2),
  LSL(2),
  MYR(2),
  PLN(2),
  RON(2),
  SCR(2),
  SZL(2),
  ZAR(2),
  DKK(2.5),
  MDL(2.5),
  MVR(2.5),
  NAD(2.5),
  NOK(3),
  SEK(3),
  TRY(3),
  ZMW(3),
  EGP(5),
  HKD(5),
  HNL(5),
  MRO(5),
  NIO(5),
  SRD(5),
  TWD(5),
  UAH(5),
  UYU(5),
  PHP(7.5),
  DOP(10),
  ETB(10),
  GMD(10),
  MKD(10),
  MUR(10),
  MXN(10),
  MZN(10),
  THB(10),
  RUB(10),
  AFN(12),
  ALL(12),
  BDT(15),
  CZK(15),
  CVE(15),
  KES(15),
  KGS(15),
  NPR(15),
  RSD(15),
  XPF(15),
  DZD(20),
  ISK(20),
  JMD(20),
  HTG(20),
  LRD(20),
  VUV(20),
  ARS(25),
  DJF(25),
  GYD(25),
  SLE(25),
  PKR(30),
  YER(30),
  AMD(45),
  SLL(45),
  JPY(50),
  KMF(50),
  KZT(50),
  LKR(50),
  AOA(55),
  NGN(55),
  CRC(75),
  SOS(75),
  XAF(75),
  XOF(75),
  CLP(100),
  HUF(100),
  KRW(150),
  MWK(150),
  RWF(150),
  BIF(250),
  CDF(250),
  MMK(250),
  TZS(250),
  COP(475),
  MNT(475),
  UGX(475),
  KHR(500),
  MGA(500),
  GNF(1000),
  PYG(1000),
  UZS(1250),
  IDR(1750),
  LBP(1750),
  LAK(2000),
  STD(2500),
  VND(2500);

  final double minValue;

  const Currencies(this.minValue);
}

class CreateGroupProvider extends ChangeNotifier {
  final controllerProjectName = TextEditingController();
  final controllerObjective = TextEditingController();
  final controllerReward = TextEditingController();
  final controllerNumberParticipants = TextEditingController();
  final controllerStartDate = TextEditingController();
  final controllerEndDate = TextEditingController();

  final controller = PageController(initialPage: 0);
  final itemCount = 3;
  int pageIndex = 0;
  File? image;
  String groupCurrencyCode = '';
  final users = [];
  bool isCreatingGroup = false;
  bool isRefundRequested = true;
  bool isPaying = false;

  final newGroup = GroupModel.empty();

  CreateGroupProvider() {
    controllerProjectName.addListener(notifyListeners);
    controllerObjective.addListener(notifyListeners);
    controllerReward.addListener(notifyListeners);
    controllerNumberParticipants.addListener(notifyListeners);
    controllerStartDate.addListener(notifyListeners);
    controllerEndDate.addListener(notifyListeners);
  }

  void _confirm(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    showCupertinoDialog(
      context: context,
      builder: (BuildContext newContext) {
        final screenHeight = context.screenHeight;
        final screenWidth = context.screenWidth;
        final isSmallScreen = screenHeight < 800 || screenWidth < 350;
        final isVerySmallScreen = screenHeight < 600 || screenWidth < 350;
        return AlertDialog(
          title: GUTextHeader(
            text: appLocalizations.confirm,
            textAlign: TextAlign.center,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: GUTextBody(
              text: appLocalizations.confirmCreateGroup,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            GPButton(
              text: appLocalizations.no,
              textColor: GPColors.red,
              borderColor: GPColors.transparent,
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Create Group Cancel Dialog');
                Navigator.of(context).pop();
              },
              color: GPColors.transparent,
              height: 40,
              width: isVerySmallScreen
                  ? 100
                  : isSmallScreen
                      ? 120
                      : 140,
            ),
            // GPButton(
            //   text: appLocalizations.yes,
            //   borderColor: GPColors.primaryColor,
            //   onPressed: () async {
            //     final user =
            //         Provider.of<AuthProvider>(context, listen: false).user;
            //     Provider.of<MixPanelProvider>(context, listen: false)
            //         .logEvent(eventName: 'Create Group Confirm Dialog');
            //     final userId = Provider.of<AuthProvider>(context, listen: false)
            //             .user
            //             ?.id ??
            //         '';
            //     final stripePayment = Provider.of<StripePaymentProvider>(
            //       context,
            //       listen: false,
            //     );
            //     if (int.tryParse(controllerReward.text) != 0) {
            //       isPaying = true;
            //       notifyListeners();
            //       final navigatorState = Navigator.of(context);
            //       FocusScope.of(context).unfocus();
            //       navigatorState.pop();
            //       try {
            //         final listPaymentMethods = await FirebaseFunctions.instance
            //             .httpsCallable('ListPaymentMethods')
            //             .call(
            //           {
            //             'userId': userId,
            //           },
            //         );
            //         if (listPaymentMethods.data['paymentMethods'].length == 0) {
            //           try {
            //             final paymentIntentId =
            //                 await stripePayment.initPaymentCreateGroup(
            //               newContext,
            //               userId,
            //               controllerReward.text,
            //               groupCurrencyCode,
            //             );
            //             await createGroup(user);
            //             await stripePayment.addPaymentIntentId(
            //               paymentIntentId,
            //               newGroup.groupCode,
            //             );
            //             controller.nextPage(
            //               duration: const Duration(milliseconds: 300),
            //               curve: Curves.ease,
            //             );
            //           } catch (e) {
            //             debugPrint(e.toString());
            //           }
            //         } else {
            //           await showModalBottomSheet(
            //             isScrollControlled: true,
            //             context: context,
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(Insets.m),
            //             ),
            //             builder: (context) {
            //               return Padding(
            //                 padding: context.screenViewInsets,
            //                 child: Wrap(
            //                   children: <Widget>[
            //                     Column(
            //                       mainAxisSize: MainAxisSize.min,
            //                       children: [
            //                         SizedBox(
            //                           height: 400,
            //                           child:
            //                               SavedCardsCreateGroupBottomSheetPageView(
            //                             groupReward: controllerReward.text,
            //                             groupCurrency: groupCurrencyCode,
            //                             groupCode: newGroup.groupCode,
            //                           ),
            //                         ),
            //                       ],
            //                     )
            //                   ],
            //                 ),
            //               );
            //             },
            //           );
            //         }
            //       } catch (e) {
            //         debugPrint(e.toString());
            //       }
            //       isPaying = false;
            //       notifyListeners();
            //     } else {
            //       Navigator.of(context).pop();
            //       await createGroup(user);
            //     }
            //   },
            //   height: 40,
            //   width: isVerySmallScreen
            //       ? 100
            //       : isSmallScreen
            //           ? 120
            //           : 140,
            // ),
            GPButton(
              text: appLocalizations.yes,
              borderColor: GPColors.primaryColor,
              onPressed: () async {
                final user =
                    Provider.of<AuthProvider>(context, listen: false).user;
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Create Group Confirm Dialog');
                Navigator.of(context).pop();
                await createGroup(user);
              },
              height: 40,
              width: isVerySmallScreen
                  ? 100
                  : isSmallScreen
                      ? 120
                      : 140,
            ),
          ],
        );
      },
    );
  }

  void Function()? nextPressedCreate(
    BuildContext context,
  ) {
    // Index 0
    final projectNameText = controllerProjectName.text;
    final objectiveText = controllerObjective.text;
    final rewardText = controllerReward.text;
    final startDateText = controllerStartDate.text;
    final endDateText = controllerEndDate.text;

    // Index 1
    final noParticipantsText = controllerNumberParticipants.text;
    // double minValueCurrencies = Currencies.values
    //     .firstWhere(
    //       (element) => element.name == groupCurrencyCode,
    //       orElse: () => Currencies.BRL,
    //     )
    //     .minValue;

    if (pageIndex == 0 &&
        (projectNameText.length < 3 ||
            objectiveText.length < 3 ||
            projectNameText.length >= 20 ||
            objectiveText.length >= 50 ||
            rewardText.length < 3 ||
            rewardText.length >=
                50 // || double.parse(rewardText) < minValueCurrencies && double.parse(rewardText) > 0
        )) {
      return null;
    } else if (pageIndex == 1 &&
        (noParticipantsText.isEmpty ||
            (int.tryParse(noParticipantsText) ?? 0) > 50 ||
            (int.tryParse(noParticipantsText) ?? 0) == 0 ||
            startDateText.isEmpty ||
            endDateText.isEmpty ||
            newGroup.endDate == null ||
            newGroup.startDate == null ||
            newGroup.endDate!.isBefore(
              newGroup.startDate!,
            ))) {
      return null;
    } else if (pageIndex == 3) {
      return () {
        Provider.of<MixPanelProvider>(context, listen: false)
            .logEvent(eventName: 'Create Group Success');
        Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => GroupsScreen(
              homeViewModel: HomeViewModel(),
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
          (route) => false,
        );
      };
    } else {
      return () => {
            Provider.of<MixPanelProvider>(context, listen: false)
                .logEvent(eventName: 'Create Group Next'),
            FocusNode().unfocus(),
            if (pageIndex == 0 || pageIndex == 1)
              {
                controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                ),
              }
            else
              {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Confirm Create Group'),
                _confirm(context),
              }
          };
    }
  }

  void updateIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }

  String generateRandomString(int len) {
    var r = Random();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  Future<String> generateGroupCode() async {
    final groupCode = generateRandomString(6);
    final groupCodeExists = await FirebaseFirestore.instance
        .collection('groups')
        .where('groupCode', isEqualTo: groupCode)
        .get();
    if (groupCodeExists.docs.isNotEmpty) {
      return generateGroupCode();
    } else {
      return groupCode;
    }
  }

  /// Update group image

  Future<void> updateGroupImage(String imageFile, String groupId) async {
    final group = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();
    if (group.exists) {
      final groupData = group.data();
      if (groupData != null) {
        await FirebaseFirestore.instance
            .collection('groups')
            .doc(groupId)
            .update({'image': imageFile});
      }
    }
  }

  Future<bool> updateAllowEditImage(
      BuildContext context, bool value, String groupId) async {
    Provider.of<IndividualGroupProvider>(context, listen: false)
        .updateAllowGroupPicture(value);
    final group = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();
    if (group.exists) {
      final groupData = group.data();
      if (groupData != null) {
        final allowEditImage = groupData['allowEditImage'] as bool;
        if (allowEditImage != value) {
          await FirebaseFirestore.instance
              .collection('groups')
              .doc(groupId)
              .update({'allowEditImage': value});
          await Provider.of<IndividualGroupProvider>(context).getGroup(groupId);
          return true;
        }
      }
    }
    return false;
  }

  Future<bool> updateAllowRefundRequest(bool value, String groupId) async {
    final group = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();
    if (group.exists) {
      final groupData = group.data();
      if (groupData != null) {
        final allowRefundRequest = groupData['allowRefundRequest'] as bool;
        newGroup.allowRefundRequest = value;
        if (allowRefundRequest != value) {
          await FirebaseFirestore.instance
              .collection('groups')
              .doc(groupId)
              .update({'allowRefundRequest': value});
          return true;
        }
      }
    }
    return false;
  }

  Future<void> createGroup(UserDataModel? user) async {
    controller.jumpToPage(3);
    isCreatingGroup = true;
    notifyListeners();
    newGroup.projectName = controllerProjectName.text;
    newGroup.objective = controllerObjective.text;
    newGroup.reward = controllerReward.text;
    newGroup.maxParticipants =
        int.tryParse(controllerNumberParticipants.text) ?? 0;
    newGroup.groupCurrencyCode = groupCurrencyCode;

    final userId = FirebaseAuth.instance.currentUser!.uid;
    if (user == null) {
      return;
    }
    final userParticipant = Participant(
      uid: userId,
      name: user.name,
      profilePicture: user.profilePicture,
      inputData: [],
      isAdmin: true,
    );

    final groupCode = await generateGroupCode();
    newGroup.groupCode = groupCode;
    newGroup.creator = userId;
    newGroup.participants.add(userId);
    newGroup.participantsData.add(userParticipant);
    newGroup.paymentIntentIds = [];

    final image = this.image;
    if (image != null) {
      try {
        final fileExtension = image.path.split('.').last;
        final createdAt = Timestamp.now().nanoseconds;
        final result = await FirebaseStorage.instance
            .ref()
            .child(userId)
            .child("groupImage$createdAt.$fileExtension")
            .putFile(image);
        final url = await result.ref.getDownloadURL();
        newGroup.image = url;
      } on FirebaseException {
        debugPrint("Deu ruim");
      }
    }
    await FirebaseFirestore.instance
        .collection('groups')
        .doc()
        .set(newGroup.toMap());
    isCreatingGroup = false;
    notifyListeners();
  }

  void confirmExitGroup(BuildContext context, String groupId) {
    final appLocalizations = AppLocalizations.of(context);
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: AlertDialog(
            title: GUTextHeader(
              text: appLocalizations.confirm,
              textAlign: TextAlign.center,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: SingleChildScrollView(
                child: GUTextBody(
                  text: appLocalizations.confirmExitGroup,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
            actions: [
              GPButton(
                text: appLocalizations.no,
                textColor: GPColors.red,
                borderColor: GPColors.transparent,
                onPressed: () {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(eventName: 'Cancel Leave Group');
                  isRefundRequested = true;
                  Navigator.of(context).pop();
                },
                color: GPColors.transparent,
                height: 40,
                width: 140,
              ),
              GPButton(
                text: appLocalizations.yes,
                borderColor: GPColors.primaryColor,
                onPressed: () {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(eventName: 'Leave Group');
                  leaveGroup(context, groupId);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                height: 40,
                width: 140,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> leaveGroup(BuildContext context, String groupId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final group = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();
    if (group.exists) {
      final groupData = group.data();
      if (groupData != null) {
        final participants = groupData['participants'] as List<dynamic>;
        final participantsData = groupData['participantsData'] as List<dynamic>;
        final index = participants.indexOf(userId);
        if (index != -1) {
          final participantData =
              participantsData[index] as Map<String, dynamic>;
          final isAdmin = participantData['isAdmin'] as bool;
          if (isAdmin) {
            final newAdminId = participants.firstWhere(
              (element) => element != userId,
              orElse: () => '',
            );
            if (newAdminId != '') {
              final newAdminIndex = participants.indexOf(newAdminId);
              final newAdminData =
                  participantsData[newAdminIndex] as Map<String, dynamic>;
              final newAdmin = Participant.fromMap(newAdminData);
              newAdmin.isAdmin = true;
              participantsData[newAdminIndex] = newAdmin.toMap();
              participants.remove(userId);
              participantsData.removeAt(index);
              await FirebaseFirestore.instance
                  .collection('groups')
                  .doc(groupId)
                  .update({
                'participants': participants,
                'participantsData': participantsData,
              });
            } else {
              await FirebaseFirestore.instance
                  .collection('groups')
                  .doc(groupId)
                  .delete();
            }
          } else {
            participants.remove(userId);
            participantsData.removeAt(index);
            await FirebaseFirestore.instance
                .collection('groups')
                .doc(groupId)
                .update(
              {
                'participants': participants,
                'participantsData': participantsData,
              },
            );
          }
        }
      }
    }
  }

  /// Call this every time when openning bottom sheet for creating group
  void clean() {
    controllerProjectName.clear();
    controllerObjective.clear();
    controllerReward.clear();
    controllerNumberParticipants.clear();
    controllerStartDate.clear();
    controllerEndDate.clear();
    newGroup.projectName = '';
    newGroup.objective = '';
    newGroup.reward = ''; //'0';
    newGroup.image = '';
    newGroup.participants = [];
    newGroup.participantsData = [];
    image = null;
    newGroup.maxParticipants = 0;
    newGroup.allowEditImage = false;
    newGroup.allowRefundRequest = false;
    newGroup.startDate = null;
    newGroup.endDate = null;
    groupCurrencyCode = 'BRL';
    updateIndex(0);
    notifyListeners();
  }
}
