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
        mainAxisAlignment: MainAxisAlignment.start, // جعل المحتوى في اليسار
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                  '/home'); // استبدل '/home' بمسار الشاشة الرئيسية
            },
            child: Image.asset(
              'images/logo-removebg-preview.png',
              height: 60, // ضبط الحجم
              fit: BoxFit.contain,
              color: Colors.white,
            ),
          ),
        ],
      ),
      iconTheme: const IconThemeData(color: Colors.white), // ضبط لون الأيقونات
      elevation: 0, // إزالة الظل لجعل التصميم أنيقًا
    );
  }
}
