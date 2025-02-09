import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../themes/theme_provider.dart';
import '/comp/app_drawer.dart';
import '/comp/app_bar.dart';
import '/comp/bottomnav.dart';
import 'submit_report.dart';
import 'track_reports.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  Timer? _timer;

  final List<String> imagePaths = [
    'images/emp2.jpg',
    'images/emp1.jpg',
    'images/5984913_57279.svg', // SVG Image
  ];

  @override
  void initState() {
    super.initState();
    _startImageSlider();
  }

  void _startImageSlider() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentImageIndex < imagePaths.length - 1) {
        _currentImageIndex++;
      } else {
        _currentImageIndex = 0;
      }
      _pageController.animateToPage(
        _currentImageIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: CustomAppBar(),
      endDrawer: AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Introduction Section
            Text(
              'مرحبا بكم في نظام بلاغات البنية التحتية',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'الإبلاغ عن مشكلات البنية الأساسية وتتبعها وإدارتها بسهولة.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 40),

            // Auto-sliding Image Carousel
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _buildImage(imagePaths[
                          index]), // Use function to handle PNG & SVG
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // Call-to-Action
            Text(
              '!ابدأ الإبلاغ عن المشكلات الآن',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),

            const SizedBox(height: 30),

            // Feature Highlights
            _buildFeatureCard(Icons.aod, "إصلاح الطرق والأرصفة",
                "أبلغ عن الحفر أو الطرق المتضررة.", isDarkMode),
            _buildFeatureCard(Icons.lightbulb, "إنارة الشوارع",
                "أبلغ عن إنارة معطلة أو تالفة.", isDarkMode),
            _buildFeatureCard(Icons.water, "مشاكل الصرف الصحي",
                "أبلغ عن انسدادات وتسربات المياه.", isDarkMode),
            _buildFeatureCard(Icons.business, "المباني الخطرة",
                "قم بالإبلاغ عن المنشآت الغير آمنة.", isDarkMode),

            const SizedBox(height: 30),

            // Community Encouragement
            Text(
              "كل بلاغ يُساهم في تحسين مدينتنا!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "هل لديك ملاحظات؟ لا تتردد في التواصل معنا!",
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  // Feature Card Widget
  Widget _buildFeatureCard(
      IconData icon, String title, String description, bool isDarkMode) {
    return Card(
      elevation: 3,
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Directionality(
        // Wrap with Directionality for RTL support
        textDirection: TextDirection.rtl,
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          leading: Icon(icon,
              color: const Color(0xFF725DFE)), // Keep the icon on the right
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          subtitle: Text(
            description,
            style: TextStyle(
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  // Handle Image Formats (SVG & PNG)
  Widget _buildImage(String path) {
    if (path.endsWith('.svg')) {
      return SvgPicture.asset(
        path,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        path,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }
}
