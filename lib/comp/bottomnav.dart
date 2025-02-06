import 'package:flutter/material.dart';
import 'package:submit/Screens/home_screen.dart'; // Import HomeScreen
import 'package:submit/Screens/submit_report.dart'; // Import SubmitReportPage
import 'package:submit/Screens/track_reports.dart'; // Import TrackReportsPage

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
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
          // Call the function that navigates based on the tapped index
          onItemTapped(index);

          // Navigate to the appropriate screen
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SubmitReportPage()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TrackReportsPage()),
              );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report_problem),
            label: 'الإبلاغ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.visibility),
            label: 'عرض التقارير',
          ),
        ],
      ),
    );
  }
}
