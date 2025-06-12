import 'package:flutter/material.dart';
import '../../../../../../../core/themes/style.dart';

class LoginHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final EdgeInsetsGeometry? padding;

  const LoginHeader({
    super.key,
    this.title = "Welcome Back!",
    this.subtitle =
        "We're excited to have you back, can't wait to see what you've been up to since you last logged in.",
    this.titleStyle,
    this.subtitleStyle,
    this.padding = const EdgeInsets.only(top: 80, left: 30, right: 30),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 80, left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ?? TextStyles.font32BlueBold,
          ),
          const SizedBox(height: 20),
          Text(
            subtitle,
            style: subtitleStyle ?? TextStyles.font16WhiteSemiBold,
          ),
        ],
      ),
    );
  }
}
