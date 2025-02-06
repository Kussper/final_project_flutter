import 'package:flutter/material.dart';
import '/comp/app_drawer.dart';
import '/comp/app_bar.dart';
import '/comp/bottomnav.dart'; // Import CustomBottomNavBar
import 'submit_report.dart'; // Import SubmitReportPage
import 'track_reports.dart'; // Import TrackReportsPage

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // To track the selected index for bottom nav

  // Function to handle bottom nav item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex =
          index; // Update the selected index when an item is tapped
    });
    // Navigate to the respective screen based on selected index
    switch (index) {
      case 0:
        // Navigate to Home Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1:
        // Navigate to Submit Report Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SubmitReportPage()),
        );
        break;
      case 2:
        // Navigate to Track Reports Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TrackReportsPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      endDrawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // App Introduction Section
              Text(
                'مرحبا بكم في نظام تقارير البنية التحتية',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'الإبلاغ عن مشكلات البنية الأساسية وتتبعها وإدارتها بسهولة.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 40),

              // Features Section
              Text(
                'نظرة عامة على التطبيق',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Image(
                image: AssetImage('images/OIP.png'),
              ),

              // Call-to-Action
              Text(
                '!ابدأ الإبلاغ عن المشكلات الآن',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped, // Pass the function to handle item taps
      ),
    );
  }
}
