import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/screens/groups/components/add_project.dart';
import 'package:groupup/screens/groups/components/bottom_navy_bar.dart';
import 'package:groupup/screens/profile/components/body_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GPColors.white,
      body: const BodyProfile(),
      floatingActionButton: const AddProject(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: kBottomNavigationBarHeight,
        child: BottomNavyBar(pageController: pageController,),
      ),
    );
  }
}
