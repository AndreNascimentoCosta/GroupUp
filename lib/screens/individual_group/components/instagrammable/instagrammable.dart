import 'package:flutter/material.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/instagrammable_provider.dart';
import 'package:groupup/screens/individual_group/components/instagrammable/components/body_instagrammable.dart';
import 'package:groupup/screens/individual_group/components/instagrammable/components/instagrammable_button.dart';
import 'package:provider/provider.dart';

class InstagrammableScreen extends StatefulWidget {
  const InstagrammableScreen({super.key});

  @override
  State<InstagrammableScreen> createState() => _InstagrammableScreenState();
}

class _InstagrammableScreenState extends State<InstagrammableScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final currentUser =
          Provider.of<AuthProvider>(context, listen: false).user;
      if (currentUser == null) {
        Navigator.of(context).pop();
      }
      if (!mounted) return;
      Provider.of<InstagrammableProvider>(context, listen: false)
          .setPlaceholderImages(
        currentUser!.profilePicture,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: BodyInstagrammable(),
      floatingActionButton: ShareInstagrammableButton(),
    );
  }
}
