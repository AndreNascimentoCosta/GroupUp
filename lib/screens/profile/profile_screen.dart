import 'package:flutter/material.dart';
import 'package:groupup/screens/groups/components/add_project.dart';
import 'package:groupup/screens/groups/components/bottom_navy_bar.dart';
import 'package:groupup/screens/profile/components/body_profile.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const BodyProfile(),
      floatingActionButton: const AddProject(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavyBar(pageController: pageController,),
      ),
    );
  }
}
