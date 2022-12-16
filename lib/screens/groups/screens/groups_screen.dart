import 'package:flutter/material.dart';
import 'package:groupup/screens/groups/components/add_project.dart';
import 'package:groupup/screens/groups/components/bottom_navy_bar.dart';
import 'package:groupup/screens/groups/components/edit_bottom_navy_bar.dart';
import 'package:groupup/models/home_view.dart';
import '../../profile/components/body.dart';
import '../components/body.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBarGroup(homeViewModel: homeViewModel),
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: pageController,
        children: [
          Body(
            homeViewModel: homeViewModel,
          ),
          const BodyProfile(),
        ],
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: homeViewModel.isEditing,
        builder: (context, value, child) {
          return homeViewModel.isEditing.value
              ? const SizedBox()
              : const AddProject();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: 80,
        child: ValueListenableBuilder(
          valueListenable: homeViewModel.isEditing,
          builder: (context, value, child) {
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
