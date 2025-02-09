import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submit/Screens/home_screen.dart';
import 'package:submit/Screens/submit_report.dart';
import '../comp_citizen/app_drawer.dart';
import '../shared_screens/app_bar.dart';
import '../comp_citizen/bottomnav.dart'; // Custom bottom navigation bar
import '/themes/theme_provider.dart';

class TrackReportsPage extends StatefulWidget {
  @override
  _TrackReportsPageState createState() => _TrackReportsPageState();
}

class _TrackReportsPageState extends State<TrackReportsPage> {
  final List<Map<String, String>> reports = [
    {
      'title': 'توسيع الإنترنت في الجيزة',
      'status': 'قيد التنفيذ',
      'details': '''
    - رقم البلاغ: 1
    - وصف البلاغ: ضعف سرعة الإنترنت في بعض المناطق نتيجة الضغط المتزايد.
    - المحافظة: الجيزة
    - المدينة: السادس من أكتوبر
    - القسم: الاتصالات
    - الحالة: قيد التنفيذ
    '''
    },
    {
      'title': 'انقطاع الكهرباء في المعادي',
      'status': 'معلق',
      'details': '''
    - رقم البلاغ: 2
    - وصف البلاغ: انقطاع التيار الكهربائي عن عدة شوارع في المعادي منذ 3 ساعات.
    - المحافظة: القاهرة
    - المدينة: المعادي
    - القسم: الكهرباء
    - الحالة: معلق
    '''
    },
    {
      'title': 'تسريب غاز في وسط البلد',
      'status': 'تم الحل',
      'details': '''
    - رقم البلاغ: 3
    - وصف البلاغ: رائحة غاز قوية في منطقة وسط البلد مما يشكل خطرًا على السكان.
    - المحافظة: القاهرة
    - المدينة: وسط البلد
    - القسم: الغاز
    - الحالة: تم الحل
    '''
    },
    {
      'title': 'انفجار ماسورة مياه',
      'status': 'معلق',
      'details': '''
    - رقم البلاغ: 4
    - وصف البلاغ: انفجار ماسورة مياه رئيسية مما تسبب في غرق الشوارع وتعطيل المرور.
    - المحافظة: الجيزة
    - المدينة: الهرم
    - القسم: المياه
    - الحالة: معلق
    '''
    },
  ];

  List<bool> _expanded = [];
  int _selectedIndex = 2;

  // Available filter options
  String? _selectedStatus;
  final List<String> _statusOptions = [
    'الكل',
    'معلق',
    'قيد التنفيذ',
    'تم الحل'
  ];

  @override
  void initState() {
    super.initState();
    _expanded = List.generate(reports.length, (index) => false);
  }

  // Function to get color and icon based on status
  Widget _getStatusWidget(String status) {
    switch (status) {
      case 'معلق':
        return Row(
          children: [
            Icon(Icons.pending_actions, color: Colors.orange), // Pending icon
            SizedBox(width: 5),
            Text(status, style: TextStyle(color: Colors.orange)),
          ],
        );
      case 'قيد التنفيذ':
        return Row(
          children: [
            Icon(Icons.access_time, color: Colors.blue), // Pending icon
            SizedBox(width: 5),
            Text(status, style: TextStyle(color: Colors.blue)),
          ],
        );
      case 'تم الحل':
        return Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green), // Resolved icon
            SizedBox(width: 5),
            Text(status, style: TextStyle(color: Colors.green)),
          ],
        );
      default:
        return Text(status);
    }
  }

  // Function to handle bottom nav item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
      case 1:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SubmitReportPage()));
        break;
      case 2:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => TrackReportsPage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    // Filtered reports based on selected status
    List<Map<String, String>> filteredReports =
        _selectedStatus == null || _selectedStatus == 'الكل'
            ? reports
            : reports
                .where((report) => report['status'] == _selectedStatus)
                .toList();

    return Scaffold(
      appBar: CustomAppBar(),
      endDrawer: AppDrawer(),
      body: Directionality(
        textDirection: TextDirection.rtl, // Right to Left for Arabic
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Filter Dropdown (Top Left Corner)
              Align(
                alignment: Alignment.centerLeft,
                child: DropdownButton<String>(
                  value: _selectedStatus ?? 'الكل',
                  icon: Icon(Icons.filter_list,
                      color: Theme.of(context).colorScheme.primary),
                  dropdownColor: isDarkMode ? Colors.grey[800] : Colors.white,
                  items: _statusOptions.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedStatus = newValue;
                    });
                  },
                ),
              ),

              SizedBox(height: 10),

              // Reports List
              Expanded(
                child: filteredReports.isEmpty
                    ? Center(
                        child: Text("لا توجد تقارير بالحالة المحددة",
                            style: TextStyle(fontSize: 18)))
                    : ListView.builder(
                        itemCount: filteredReports.length,
                        itemBuilder: (context, index) {
                          final status = filteredReports[index]['status']!;
                          return MouseRegion(
                            onEnter: (_) => setState(() {
                              _expanded[index] = true;
                            }),
                            onExit: (_) => setState(() {
                              _expanded[index] = false;
                            }),
                            child: Card(
                              color:
                                  isDarkMode ? Colors.grey[800] : Colors.white,
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      filteredReports[index]['title']!,
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    subtitle: _getStatusWidget(status),
                                    trailing: Icon(
                                      _expanded[index]
                                          ? Icons.expand_less
                                          : Icons.expand_more,
                                      color: _expanded[index]
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Colors.grey,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _expanded[index] = !_expanded[index];
                                      });
                                    },
                                  ),
                                  AnimatedCrossFade(
                                    firstChild: SizedBox.shrink(),
                                    secondChild: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        filteredReports[index]['details']!,
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? Colors.white70
                                              : Colors.black87,
                                        ),
                                      ),
                                    ),
                                    crossFadeState: _expanded[index]
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                    duration: Duration(milliseconds: 300),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
