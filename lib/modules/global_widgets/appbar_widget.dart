import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorUtils = ColorUtils();
    return AppBar(
      toolbarHeight: 70,
      centerTitle: true,
      backgroundColor: colorUtils.lightBlueColor,
      title: const Text('Task Management List'),
      actions: [
        const Padding(padding: EdgeInsets.only(right: 15)),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.calendar_month_outlined))
      ],
    );
  }
}
