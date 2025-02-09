import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF725DFE),
      title: Row(
        mainAxisAlignment:
            MainAxisAlignment.start, // Keeps content aligned to the left
        children: [
          Image.asset(
            'images/logo-removebg-preview.png',
            height: 60,
            fit: BoxFit.contain,
            color: Colors.white,
          ),
        ],
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
    );
  }
}
