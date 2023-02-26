// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/providers/stripe_payment_provider.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/participant.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/screens/saved_cards/saved_cards_join_group_bottom_sheet/saved_cards_join_group_bottom_sheet_page_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'mix_panel_provider.dart';

enum JoinGroupErrorType {
  groupCodeEmpty,
  groupCodeInvalid,
  groupCodeExpired,
  groupCodeFull,
  userAlreadyInGroup,
}

class JoinGroupProvider extends ChangeNotifier {
  final controllerGroupCode = TextEditingController();
  final controller = PageController();
  int pageIndex = 0;
  bool isOpeningSavedCards = false;

  JoinGroupProvider() {
    controllerGroupCode.addListener(notifyListeners);
  }

  void Function()? nextPressedJoin(
    BuildContext context,
    String userId,
  ) {
    // Index 0
    final joinGroupText = controllerGroupCode.text;

    if ((joinGroupText.isEmpty)) {
      return null;
    } else if (pageIndex == 0) {
      return () async {
        Provider.of<MixPanelProvider>(context, listen: false).logEvent(
            eventName: 'Check if group code is valid and next button');
        FocusScope.of(context).unfocus();
        final scaffoldMessengerState = ScaffoldMessenger.of(context);
        final appLocalizations = AppLocalizations.of(context);
        final error = await validateJoinGroup(context);
        if (error != null) {
          switch (error) {
            case JoinGroupErrorType.groupCodeEmpty:
              scaffoldMessengerState.showSnackBar(
                SnackBar(
                  content: Text(appLocalizations.pleaseEnterGroupCode),
                  duration: const Duration(seconds: 2),
                ),
              );
              break;
            case JoinGroupErrorType.groupCodeInvalid:
              scaffoldMessengerState.showSnackBar(
                SnackBar(
                  content: Text(appLocalizations.invalidGroupCode),
                  duration: const Duration(seconds: 2),
                ),
              );
              break;
            case JoinGroupErrorType.groupCodeExpired:
              scaffoldMessengerState.showSnackBar(
                SnackBar(
                  content: Text(appLocalizations.groupAlreadyEnded),
                  duration: const Duration(seconds: 2),
                ),
              );
              break;
            case JoinGroupErrorType.groupCodeFull:
              scaffoldMessengerState.showSnackBar(
                SnackBar(
                  content: Text(appLocalizations.groupAlreadyFull),
                  duration: const Duration(seconds: 2),
                ),
              );
              break;
            case JoinGroupErrorType.userAlreadyInGroup:
              scaffoldMessengerState.showSnackBar(
                SnackBar(
                  content: Text(appLocalizations.userAlreadyInTheGroup),
                  duration: const Duration(seconds: 2),
                ),
              );
              break;
            default:
          }
          return;
        }
        controller.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      };
    } else {
      return () async {
        Provider.of<MixPanelProvider>(context, listen: false)
            .logEvent(eventName: 'Join group button');
        final navigatorState = Navigator.of(context);
        final stripePaymentProvider =
            Provider.of<StripePaymentProvider>(context, listen: false);
        FocusScope.of(context).unfocus();
        final groups = await FirebaseFirestore.instance
            .collection('groups')
            .where('groupCode', isEqualTo: controllerGroupCode.text)
            .get();
        final groupsDocs = groups.docs;
        final group = groupsDocs[0].data();
        if (double.parse(group['reward']) == 0) {
          await joinGroup(context);
          navigatorState.pop();
          navigatorState.pop();
          clean();
        } else {
          isOpeningSavedCards = true;
          notifyListeners();
          try {
            final listPaymentMethods = await FirebaseFunctions.instance
                .httpsCallable('ListPaymentMethods')
                .call(
              {
                'userId': userId,
              },
            );
            if (listPaymentMethods.data['paymentMethods'].length == 0) {
              try {
                await stripePaymentProvider.initPaymentJoinGroup(
                  controllerGroupCode.text,
                  userId,
                );
                await joinGroup(context);
                Navigator.of(context).popUntil((route) => route.isFirst);
              } catch (e) {
                final appLocalizations = AppLocalizations.of(context);
                Navigator.of(context).popUntil((route) => route.isFirst);
                print(e);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(appLocalizations.paymentInterrupted),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
              isOpeningSavedCards = false;
              notifyListeners();
            } else {
              navigatorState.pop();
              await showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Insets.m),
                ),
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Wrap(
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 400,
                              child: SavedCardsJoinGroupBottomSheetPageView(
                                groupCode: controllerGroupCode.text,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
              isOpeningSavedCards = false;
              notifyListeners();
            }
          } catch (e) {
            isOpeningSavedCards = false;
            notifyListeners();
            print(e);
          }
        }
        clean();
      };
    }
  }

  Future<JoinGroupErrorType?> validateJoinGroup(BuildContext context) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final navigatorState = Navigator.of(context);
    final groups = await FirebaseFirestore.instance
        .collection('groups')
        .where('groupCode', isEqualTo: controllerGroupCode.text.toUpperCase())
        .get();
    if (groups.docs.isEmpty) {
      navigatorState.pop();
      navigatorState.pop();
      return JoinGroupErrorType.groupCodeInvalid;
    }
    final groupDocument = groups.docs.first;
    final groupData = groupDocument.data();
    final groupModel = GroupModel.fromMap(groupDocument.id, groupData);
    if (groupModel.participants.contains(userId)) {
      navigatorState.pop();
      navigatorState.pop();
      return JoinGroupErrorType.userAlreadyInGroup;
    }
    if (groupModel.participants.length >= groupModel.maxParticipants) {
      navigatorState.pop();
      navigatorState.pop();
      return JoinGroupErrorType.groupCodeFull;
    }
    if (groupModel.endDate!.toUtc().year != (DateTime.now()).toUtc().year ||
        groupModel.endDate!.toUtc().month != (DateTime.now()).toUtc().month ||
        groupModel.endDate!.toUtc().day != (DateTime.now()).toUtc().day) {
      if (groupModel.endDate!.toUtc().isBefore((DateTime.now()).toUtc())) {
        navigatorState.pop();
        navigatorState.pop();
        return JoinGroupErrorType.groupCodeExpired;
      }
    }
    return null;
  }

  Future<JoinGroupErrorType?> joinGroup(BuildContext context) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    final group = await FirebaseFirestore.instance
        .collection('groups')
        .where('groupCode', isEqualTo: controllerGroupCode.text.toUpperCase())
        .get();
    if (group.docs.isEmpty) {
      return JoinGroupErrorType.groupCodeInvalid;
    }
    if (user == null) {
      return JoinGroupErrorType.groupCodeInvalid;
    }
    await FirebaseFirestore.instance
        .collection('groups')
        .doc(group.docs.first.id)
        .update(
      {
        'participants': FieldValue.arrayUnion([userId]),
        'participantsData': FieldValue.arrayUnion(
          [
            Participant(
              uid: userId,
              name: user.name,
              profilePicture: user.profilePicture,
              inputData: [],
              isAdmin: false,
            ).toMap()
          ],
        )
      },
    );
    return null;
  }

  void updateIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }

  void clean() {
    controllerGroupCode.clear();
    updateIndex(0);
    notifyListeners();
  }
}
