import 'package:flutter/material.dart';
import 'package:submit/employee_scrrens/assigned_report.dart'; // استيراد الشاشة الثانية
import 'package:submit/employee_scrrens/home_page.dart'; // استيراد الشاشة الرئيسية

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set direction to RTL
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          onItemTapped(index);
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Assigned()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'البلاغات',
          ),
        ],
      ),
    );
  }
}
