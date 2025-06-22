import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/style.dart';
import 'notification_button.dart';

class HeaderSection extends StatelessWidget {
  final String? username;

  const HeaderSection({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, $username',
              style: TextStyles.font32BlueBold.copyWith(
                color: Colors.black,
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "How Are you Today?",
              style: TextStyles.font13GrayRegular,
            ),
          ],
        ),
        const Spacer(),
        NotificationButton(),
      ],
    );
  }
}
