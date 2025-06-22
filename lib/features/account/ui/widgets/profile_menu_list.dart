import 'package:flutter/material.dart';

import 'profile_menu_item.dart';

class ProfileMenuList extends StatelessWidget {
  final VoidCallback onPersonalInfoTap;
  final VoidCallback onTestDiagnosticTap;
  final VoidCallback onPaymentTap;

  const ProfileMenuList({
    super.key,
    required this.onPersonalInfoTap,
    required this.onTestDiagnosticTap,
    required this.onPaymentTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileMenuItem(
          icon: Icons.person_outline,
          title: "Personal Information",
          onTap: onPersonalInfoTap,
        ),
        ProfileMenuItem(
          icon: Icons.description_outlined,
          title: "My Test & Diagnostic",
          onTap: onTestDiagnosticTap,
        ),
        ProfileMenuItem(
          icon: Icons.payment_outlined,
          title: "Payment",
          onTap: onPaymentTap,
        ),
      ],
    );
  }
}
