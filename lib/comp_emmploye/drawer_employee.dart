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
    final bool isDarkMode = themeProvider.isDarkMode;

    // Dynamic icon color for dark and light mode
    final Color iconColor = isDarkMode ? Colors.white54 : Colors.grey[700]!;

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
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('images/user.jpg'),
              ),
              decoration: const BoxDecoration(color: Color(0xFF725DFE)),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  _createDrawerItem(
                    icon: isDarkMode ? Icons.settings_outlined : Icons.settings,
                    text: 'الاعدادات',
                    iconColor: iconColor,
                    onTap: () => _navigateTo(context, 'Settings'),
                  ),
                  _darkModeToggle(themeProvider, iconColor, isDarkMode),
                  _createDrawerItem(
                    icon: isDarkMode ? Icons.help_outline : Icons.help,
                    text: 'المساعدة والدعم',
                    iconColor: iconColor,
                    onTap: () => _navigateTo(context, 'Help & Support'),
                  ),
                  _createDrawerItem(
                    icon: isDarkMode ? Icons.info_outline : Icons.info,
                    text: 'عن التطبيق',
                    iconColor: iconColor,
                    onTap: () => _navigateTo(context, 'About'),
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'تسجيل الخروج',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.logout, color: Colors.red),
                ],
              ),
              onTap: () => _logout(context),
            )
          ],
        ),
      ),
    );
  }

  /// Creates a drawer item where **icons adapt to dark/light mode**.
  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required Color iconColor,
    GestureTapCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(text, textAlign: TextAlign.right),
      onTap: onTap,
    );
  }

  /// Dark Mode Toggle: **Uses Outlined Icon in Dark Mode**
  Widget _darkModeToggle(
      ThemeProvider themeProvider, Color iconColor, bool isDarkMode) {
    return ListTile(
      leading: Icon(
          isDarkMode ? Icons.brightness_6_outlined : Icons.brightness_6,
          color: iconColor),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'الوضع المظلم',
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 16),
          ),
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
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
