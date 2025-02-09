import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submit/employee_scrrens/ReportDetailsScreen.dart';
import 'package:submit/themes/theme_provider.dart';
import '../comp/app_bar.dart';
import '/comp_emmploye/bottom_nav_employee.dart';
import '/comp_emmploye/drawer_employee.dart';

class Assigned extends StatefulWidget {
  const Assigned({super.key});

  @override
  State<Assigned> createState() => _AssignedState();
}

class _AssignedState extends State<Assigned> {
  final List<Map<String, String>> assignedReports = [
    {
      "title": "كسر ماسورة مياه",
      "location": "حي السلام",
      "status": "معلق",
      "time": "10:00 صباحًا",
      "date": "2024-02-01",
      "description": "تسرب مياه غزير من الماسورة في الشارع.",
      "contact": "0551234567",
    },
    {
      "title": "شارع غير مضاء",
      "location": "وسط المدينة",
      "status": "قيد التنفيذ",
      "time": "5:00 مساءً",
      "date": "2024-01-28",
      "description": "أعمدة الإنارة معطلة منذ عدة أيام.",
      "contact": "0559876543",
    },
    {
      "title": "حفرة في الطريق",
      "location": "شارع النصر",
      "status": "تم الحل",
      "time": "1:00 مساءً",
      "date": "2024-01-30",
      "description": "حفرة خطيرة تتسبب في عرقلة المرور.",
      "contact": "0561112233",
    },
  ];

  void updateReportStatus(int index, String newStatus) {
    setState(() {
      assignedReports[index]['status'] = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: themeProvider.themeData.scaffoldBackgroundColor,
      appBar: const CustomAppBar(),
      endDrawer: const EmployeeAppDrawer(),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 1,
        onItemTapped: (index) {},
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            itemCount: assignedReports.length,
            itemBuilder: (context, index) {
              final report = assignedReports[index];
              return Card(
                color: isDarkMode ? Colors.grey[800] : Colors.white,
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    final updatedStatus = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportDetailsScreen(
                          report: report,
                          onUpdateStatus: (newStatus) =>
                              updateReportStatus(index, newStatus),
                        ),
                      ),
                    );

                    if (updatedStatus != null) {
                      updateReportStatus(index, updatedStatus);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                report['title']!,
                                style: themeProvider
                                    .themeData.textTheme.bodyLarge
                                    ?.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            _buildStatusBadge(report['status']!),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 18, color: Colors.grey),
                            const SizedBox(width: 5),
                            Text(report['location']!,
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white70
                                      : Colors.black87,
                                )),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.access_time,
                                size: 18, color: Colors.grey),
                            const SizedBox(width: 5),
                            Text("${report['date']} - ${report['time']}",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white70
                                      : Colors.black87,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case "معلق":
        color = Colors.red;
        break;
      case "قيد التنفيذ":
        color = Colors.orange;
        break;
      case "تم الحل":
        color = Colors.green;
        break;
      default:
        color = Colors.blueGrey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
