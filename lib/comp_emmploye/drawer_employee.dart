import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submit/Screens/Login_Page.dart';
import 'package:submit/employee_scrrens/assigned_report.dart';
import '/themes/theme_provider.dart';

class EmployeeAppDrawer extends StatelessWidget {
  const EmployeeAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // صورة المستخدم، إذا لم تكن متاحة سيتم عرض الأيقونة الافتراضية
    // String? userImage; // هنا يتم جلب الصورة من بيانات المستخدم إذا كانت متاحة

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: const Text(
                "أهلاً, يوسف",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
              accountEmail: const Text(
                "yousef121@civic.eg",
                textAlign: TextAlign.right,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/user.jpg'),
              ),
              decoration: BoxDecoration(color: Color(0xFF725DFE)),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  _createDrawerItem(
                      icon: Icons.settings,
                      text: 'الاعدادات',
                      onTap: () => _navigateTo(context, 'Settings')),
                  ListTile(
                    leading: Icon(Icons.brightness_6),
                    title: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.end, // Aligns children to the right
                      children: [
                        Switch(
                          value: themeProvider.isDarkMode,
                          onChanged: (value) {
                            themeProvider.toggleTheme();
                          },
                        ),
                        Text('الوضع المظلم',
                            textAlign:
                                TextAlign.right), // Text aligned to the right
                      ],
                    ),
                  ),
                  _createDrawerItem(
                      icon: Icons.help,
                      text: 'المساعدة والدعم',
                      onTap: () => _navigateTo(context, 'Help & Support')),
                  _createDrawerItem(
                      icon: Icons.info,
                      text: 'عن التطبيق',
                      onTap: () => _navigateTo(context, 'About')),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'تسجيل الخروج',
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.logout, color: Colors.red),
                ],
              ),
              onTap: () => _logout(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    GestureTapCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(text, textAlign: TextAlign.right),
      onTap: onTap,
    );
  }

  void _navigateTo(BuildContext context, String destination) {
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Assigned()),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pop(context); // Close the drawer
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
