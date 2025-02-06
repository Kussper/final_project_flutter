import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submit/Screens/ChatbotScreen.dart';
import 'package:submit/comp/bottomnav.dart'; // Import the custom bottom navigation bar
import '/comp/app_drawer.dart';
import '/comp/app_bar.dart';
import '/themes/theme_provider.dart';
import 'home_screen.dart'; // Import HomeScreen
import 'track_reports.dart'; // Import TrackReportsPage

class SubmitReportPage extends StatefulWidget {
  @override
  _SubmitReportPageState createState() => _SubmitReportPageState();
}

class _SubmitReportPageState extends State<SubmitReportPage> {
  final Map<String, List<String>> governoratesAndCities = {
    "القليوبية": ["الخانكة", "بنها", "قليوب", "شبرا الخيمة"],
  };

  String? selectedGovernorate;
  String? selectedCity;

  // Text Controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final contactInfoController = TextEditingController();
  final locationController = TextEditingController();

  bool isHovered = false; // To track hover state

  int _selectedIndex = 1; // Default selected index (SubmitReportPage)

  // Function to handle bottom nav item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
        // Stay on Submit Report Screen (SubmitReportPage)
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
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(),
      endDrawer: AppDrawer(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title text
                Text(
                  "الابلاغ عن مشكلة",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 16),

                // Governorate Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: "اختار المحافظة"),
                  value: selectedGovernorate,
                  items: governoratesAndCities.keys
                      .map(
                        (governorate) => DropdownMenuItem(
                          value: governorate,
                          child: Text(governorate),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGovernorate = value;
                      selectedCity = null;
                    });
                  },
                ),
                SizedBox(height: 16),

                // City Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: "اختار المدينة"),
                  value: selectedCity,
                  items: selectedGovernorate != null
                      ? governoratesAndCities[selectedGovernorate]!
                          .map(
                            (city) => DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            ),
                          )
                          .toList()
                      : [],
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value;
                    });
                  },
                  disabledHint: Text("اختار المحافظة أولاً"),
                ),
                SizedBox(height: 16),

                // Title Text Field
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: "عنوان المشكلة"),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 16),

                // Description Text Field

                // Contact Info Text Field
                TextField(
                  controller: contactInfoController,
                  decoration: InputDecoration(labelText: "رقم التليفون"),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 16),

                // Location Text Field
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: "تفاصيل المشكله"),
                  maxLines: 5,
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 16),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (selectedGovernorate == null || selectedCity == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text("Please select both Governorate and City."),
                        ),
                      );
                      return;
                    }
                    if (titleController.text.isEmpty ||
                        descriptionController.text.isEmpty ||
                        locationController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please fill out all required fields."),
                        ),
                      );
                      return;
                    }

                    print("Governorate: $selectedGovernorate");
                    print("City: $selectedCity");
                    print("Title: ${titleController.text}");
                    print("Description: ${descriptionController.text}");
                    print("Contact Info: ${contactInfoController.text}");
                    print("Location: ${locationController.text}");

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("تم ارسال المشكلة بنجاح"),
                      ),
                    );

                    setState(() {
                      selectedGovernorate = null;
                      selectedCity = null;
                    });
                    titleController.clear();
                    descriptionController.clear();
                    contactInfoController.clear();
                    locationController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeProvider.isDarkMode
                        ? Color(0xFF725DFE)
                        : Color(0xFF725DFE),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("إرسال المشكلة"),
                ),
              ],
            ),
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped, // Handle item taps
      ),

      // Floating Action Button for Chatbot
      floatingActionButton: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ChatBotApp()), // Navigate to Chatbot Screen
            );
          },
          backgroundColor: Color(0xFF725DFE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.chat_bubble, size: 30),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.startFloat, // Move FAB to the left
    );
  }
}
