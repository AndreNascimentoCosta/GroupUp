import 'package:flutter/material.dart';
import 'package:groupup/core/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/screens/groups/components/add_project.dart';
import 'package:groupup/screens/groups/components/bottom_navy_bar.dart';
import 'package:groupup/screens/groups/components/edit_bottom_navy_bar.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/screens/groups/components/add_username.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:provider/provider.dart';
import '../../profile/components/body_profile.dart';
import '../components/body_group.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({
    required this.homeViewModel,
  });

  final int selectedIndex = 0;
  final HomeViewModel homeViewModel;

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final HomeViewModel homeViewModel = HomeViewModel();
  final pageController = PageController();

  var willShowNameBottomSheet = false;

  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(
      context,
      listen: false,
    ).addListener(
      askNameIfNeeded,
    );
    Provider.of<MixPanelProvider>(
      context,
      listen: false,
    ).logEvent(
      eventName: 'Groups Screen',
    );
  }

  void askNameIfNeeded() {
    if (!mounted) return;
    final user = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).user;
    final phoneProvider = Provider.of<PhoneAuthenProvider>(
      context,
      listen: false,
    );
    if (user?.name.isEmpty ?? true) {
      if (willShowNameBottomSheet) return;
      willShowNameBottomSheet = true;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          if (!mounted) return;
          phoneProvider.cleanName();
          return gpModalBottomSheet(
            context,
            280,
            AddUsername(
              controller: phoneProvider.controller,
            ),
            isDismissible: false,
            enableDrag: false,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GPColors.white,
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          BodyGroup(
            homeViewModel: homeViewModel,
          ),
          const BodyProfile(),
        ],
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: homeViewModel.isEditing,
        builder: (
          context,
          value,
          child,
        ) {
          return homeViewModel.isEditing.value
              ? const SizedBox()
              : const AddProject();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: context.screenHeight * 0.095,
        child: ValueListenableBuilder(
          valueListenable: homeViewModel.isEditing,
          builder: (
            context,
            value,
            child,
          ) {
            return homeViewModel.isEditing.value
                ? const BottomNavyBarEdit()
                : BottomNavyBar(
                    pageController: pageController,
                  );
          },
        ),
      ),
    );
  }
}
