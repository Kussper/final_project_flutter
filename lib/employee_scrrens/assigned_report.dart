import 'package:flutter/material.dart';
import '../comp/app_bar.dart';
import '/comp_emmploye/bottom_nav_employee.dart';
import '/comp_emmploye/drawer_employee.dart';

class Assigned extends StatefulWidget {
  const Assigned({super.key});

  @override
  State<Assigned> createState() => _AssignedState();
}

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

class _AssignedState extends State<Assigned> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    final updatedReport = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ReportDetailsScreen(report: report),
                      ),
                    );

                    if (updatedReport != null) {
                      setState(() {
                        assignedReports[index] = updatedReport;
                      });
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
                                style: const TextStyle(
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
                                style: TextStyle(color: Colors.grey.shade700)),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.access_time,
                                size: 18, color: Colors.grey),
                            const SizedBox(width: 5),
                            Text("${report['date']} - ${report['time']}",
                                style: TextStyle(color: Colors.grey.shade700)),
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
    String text;
    switch (status) {
      case "معلق":
        color = Colors.red;
        text = "🚨 معلق";
        break;
      case "قيد التنفيذ":
        color = Colors.orange;
        text = "⌛ قيد التنفيذ";
        break;
      case "تم الحل":
        color = Colors.green;
        text = "✅ تم الحل";
        break;
      default:
        color = Colors.blueGrey;
        text = "ℹ️ غير معروف";
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ReportDetailsScreen extends StatefulWidget {
  final Map<String, String> report;

  const ReportDetailsScreen({super.key, required this.report});

  @override
  _ReportDetailsScreenState createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  late String _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.report['status'] ?? "معلق";
  }

  void _updateStatus(String newStatus) {
    setState(() {
      _selectedStatus = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text("تفاصيل البلاغ",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          backgroundColor: const Color(0xFF725DFE),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildCard(Icons.title, "عنوان البلاغ", widget.report['title']),
              _buildCard(
                  Icons.location_on, "الموقع", widget.report['location']),
              _buildCard(Icons.access_time, "الوقت", widget.report['time']),
              _buildCard(
                  Icons.calendar_today, "تاريخ البلاغ", widget.report['date']),
              _buildCard(Icons.description, "وصف البلاغ",
                  widget.report['description']),
              _buildCard(
                  Icons.phone, "معلومات الاتصال", widget.report['contact']),

              const SizedBox(height: 20),
              _buildStatusDropdown(), // تعديل القائمة المنسدلة
              const SizedBox(height: 30),

              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF725DFE),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("حفظ التغييرات",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(IconData icon, String label, String? value) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF725DFE)),
        title: Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(value ?? "غير متوفر",
            style: const TextStyle(fontSize: 14, color: Colors.black87)),
      ),
    );
  }

  Widget _buildStatusDropdown() {
    List<String> statuses = ["معلق", "قيد التنفيذ", "تم الحل"];
    statuses.remove(_selectedStatus); // إزالة الحالة الحالية من القائمة

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "الحالة الحالية: $_selectedStatus",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _getStatusColor(_selectedStatus),
              ),
            ),
            const SizedBox(
                height: 10), // المسافة بين الحالة الحالية والقائمة المنسدلة
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: null,
                hint: const Text("اختر الحالة الجديدة"),
                dropdownColor: Colors.white,
                items: statuses.map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(
                      status,
                      style: TextStyle(
                        color: _getStatusColor(status),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _updateStatus(newValue);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "معلق":
        return Colors.red;
      case "قيد التنفيذ":
        return Colors.orange;
      case "تم الحل":
        return Colors.green;
      default:
        return Colors.blueGrey;
    }
  }
}
