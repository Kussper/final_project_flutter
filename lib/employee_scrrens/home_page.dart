import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/comp_emmploye/drawer_employee.dart';
import '../shared_screens/app_bar.dart';
import '/comp_emmploye/bottom_nav_employee.dart';
import '/themes/theme_provider.dart';

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = themeProvider.themeData;
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: const EmployeeAppDrawer(),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
        onItemTapped: (index) {},
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Directionality(
        textDirection: TextDirection.rtl, // دعم اللغة العربية
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              _buildWelcomeMessage(theme),
              const SizedBox(height: 20),
              _buildStatisticsCounters(theme, isDarkMode),
              const SizedBox(height: 25),
              _buildLatestReportsTitle(theme),
              const SizedBox(height: 10),
              _buildLatestReportsList(theme, isDarkMode),
            ],
          ),
        ),
      ),
    );
  }

  // **رسالة الترحيب**
  Widget _buildWelcomeMessage(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "مرحبًا بك 👋",
          style: theme.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          "إليك ملخص سريع للبلاغات الخاصة بك:",
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
        ),
      ],
    );
  }

  // **عدّادات رقمية للإحصائيات**
  Widget _buildStatisticsCounters(ThemeData theme, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCounterCard("معلق", "5", Colors.red, theme, isDarkMode),
        _buildCounterCard("قيد التنفيذ", "2", Colors.orange, theme, isDarkMode),
        _buildCounterCard("تم الحل", "10", Colors.green, theme, isDarkMode),
      ],
    );
  }

  // **تصميم بطاقة العدّادات الرقمية**
  Widget _buildCounterCard(String title, String count, Color color,
      ThemeData theme, bool isDarkMode) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color:
          isDarkMode ? Colors.grey[800] : Colors.white, // Adjust for dark mode
      child: Container(
        width: 100,
        height: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count,
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // **عنوان قسم أحدث البلاغات**
  Widget _buildLatestReportsTitle(ThemeData theme) {
    return Text(
      "أحدث البلاغات المسندة",
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  // **قائمة أحدث البلاغات بتصميم حديث**
  Widget _buildLatestReportsList(ThemeData theme, bool isDarkMode) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: latestReports.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return _buildExpandableReportCard(
            latestReports[index], theme, isDarkMode);
      },
    );
  }

  // **تصميم بطاقة عرض البلاغات القابلة للتوسعة**
  Widget _buildExpandableReportCard(
      Map<String, String> report, ThemeData theme, bool isDarkMode) {
    return Card(
      color:
          isDarkMode ? Colors.grey[800] : Colors.white, // Adapting to dark mode
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: _getStatusColor(report['status']!), width: 1.5),
      ),
      child: ExpansionTile(
        collapsedTextColor: theme.textTheme.bodyLarge?.color,
        iconColor: theme.iconTheme.color,
        title: Text(
          report['title']!,
          style:
              theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "📍 ${report['location']} • ${report['time']}",
          style: theme.textTheme.bodyMedium,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              report['description']!,
              textAlign: TextAlign.justify,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.phone, color: Color(0xFF725DFE)),
            label: Text(
              "اتصل: ${report['contact']}",
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: Color(0xFF725DFE)),
            ),
          ),
        ],
      ),
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
