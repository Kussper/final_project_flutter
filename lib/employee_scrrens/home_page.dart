import 'package:flutter/material.dart';
import '/comp_emmploye/drawer_employee.dart';
import '../comp/app_bar.dart';
import '/comp_emmploye/bottom_nav_employee.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> latestReports = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: const EmployeeAppDrawer(),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
        onItemTapped: (index) {},
      ),
      body: Directionality(
        textDirection: TextDirection.rtl, // دعم اللغة العربية
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              _buildWelcomeMessage(),
              const SizedBox(height: 20),
              _buildStatisticsCounters(),
              const SizedBox(height: 25),
              _buildLatestReportsTitle(),
              const SizedBox(height: 10),
              _buildLatestReportsList(),
            ],
          ),
        ),
      ),
    );
  }

  // **رسالة الترحيب**
  Widget _buildWelcomeMessage() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "مرحبًا بك 👋",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          "إليك ملخص سريع للبلاغات الخاصة بك:",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ],
    );
  }

  // **عدّادات رقمية للإحصائيات**
  Widget _buildStatisticsCounters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCounterCard("معلق", "5", Colors.red),
        _buildCounterCard("قيد التنفيذ", "2", Colors.orange),
        _buildCounterCard("تم الحل", "10", Colors.green),
      ],
    );
  }

  // **تصميم بطاقة العدّادات الرقمية**
  Widget _buildCounterCard(String title, String count, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 100,
        height: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  // **عنوان قسم أحدث البلاغات**
  Widget _buildLatestReportsTitle() {
    return const Text(
      "أحدث البلاغات المسندة",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  // **قائمة أحدث البلاغات بتصميم حديث**
  Widget _buildLatestReportsList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: latestReports.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return _buildExpandableReportCard(latestReports[index]);
      },
    );
  }

  // **تصميم بطاقة عرض البلاغات القابلة للتوسعة**
  Widget _buildExpandableReportCard(Map<String, String> report) {
    return ExpansionTile(
      initiallyExpanded: false,
      backgroundColor: Colors.white,
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: _getStatusColor(report['status']!), width: 1.5),
      ),
      title: Text(
        report['title']!,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text("📍 ${report['location']} • ${report['time']}"),
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            report['description']!,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.phone, color: Colors.blue),
          label: Text("اتصل: ${report['contact']}"),
        ),
      ],
    );
  }

  // **إرجاع لون الحالة حسب نوعها**
  Color _getStatusColor(String status) {
    switch (status) {
      case "معلق":
        return Colors.red;
      case "قيد التنفيذ":
        return Colors.orange;
      case "تم الحل":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
