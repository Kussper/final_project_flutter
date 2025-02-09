import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submit/themes/theme_provider.dart';

class ReportDetailsScreen extends StatefulWidget {
  final Map<String, String> report;
  final Function(String) onUpdateStatus;

  const ReportDetailsScreen({
    super.key,
    required this.report,
    required this.onUpdateStatus,
  });

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "تفاصيل البلاغ",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF725DFE),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildCard(Icons.title, "عنوان البلاغ", widget.report['title'],
                    isDarkMode),
                _buildCard(Icons.location_on, "الموقع",
                    widget.report['location'], isDarkMode),
                _buildCard(Icons.access_time, "الوقت", widget.report['time'],
                    isDarkMode),
                _buildCard(Icons.calendar_today, "تاريخ البلاغ",
                    widget.report['date'], isDarkMode),
                _buildCard(Icons.description, "وصف البلاغ",
                    widget.report['description'], isDarkMode),
                _buildCard(Icons.phone, "معلومات الاتصال",
                    widget.report['contact'], isDarkMode),
                const SizedBox(height: 20),
                _buildStatusDropdown(isDarkMode),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onUpdateStatus(_selectedStatus);
                      Navigator.pop(context, _selectedStatus);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF725DFE),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("حفظ التغييرات",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
      IconData icon, String label, String? value, bool isDarkMode) {
    return Card(
      elevation: 3,
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Icon(icon, color: const Color(0xFF725DFE)),
        title: Text(
          label,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          value ?? "غير متوفر",
          textAlign: TextAlign.right,
          style: TextStyle(
            color: isDarkMode ? Colors.white70 : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusDropdown(bool isDarkMode) {
    List<String> statuses = [];
    if (_selectedStatus == "معلق") {
      statuses.add("قيد التنفيذ");
    } else if (_selectedStatus == "قيد التنفيذ") {
      statuses.add("تم الحل");
    }

    return Card(
      elevation: 3,
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "الحالة الحالية: $_selectedStatus",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _getStatusColor(_selectedStatus),
              ),
            ),
            const SizedBox(height: 10),
            if (_selectedStatus != "تم الحل")
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: null,
                  hint: Text(
                    "اختر الحالة الجديدة",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  dropdownColor:
                      isDarkMode ? Colors.grey[800] : const Color(0xFFEDE7F6),
                  items: statuses.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(
                        status,
                        textAlign: TextAlign.right,
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
              )
            else
              Text(
                "لا يمكن تغيير الحالة",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
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
