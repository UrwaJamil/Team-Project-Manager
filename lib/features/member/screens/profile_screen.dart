import 'package:flutter/material.dart';

import '../../common/placeholder_content.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderContent(
      icon: Icons.person_outline,
      message: 'Profile\n(edit skill tags)\ncoming in a later phase',
    );
  }
}
