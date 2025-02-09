import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submit/Screens/Login_Page.dart';
import '/themes/theme_provider.dart';
import '/Screens/home_screen.dart'; // Import HomeScreen

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    // Dynamic icon color & style
    final Color iconColor = isDarkMode ? Colors.white54 : Colors.black87;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: const Text(
                "أهلاً, محمود",
                textAlign: TextAlign.right,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text(
                "mahmoud@gmail.com",
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
                    icon: isDarkMode ? Icons.home_outlined : Icons.home,
                    text: 'الرئيسية',
                    iconColor: iconColor,
                    onTap: () => _navigateToHome(context),
                  ),
                  const Divider(),
                  _createDrawerItem(
                    icon: isDarkMode ? Icons.settings_outlined : Icons.settings,
                    text: 'الإعدادات',
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.logout, color: Colors.red),
                  const SizedBox(width: 8),
                  const Text(
                    'تسجيل الخروج',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              onTap: () => _logout(context),
            ),
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 8),
          Text(text, textAlign: TextAlign.right),
        ],
      ),
      onTap: onTap,
    );
  }

  /// Dark Mode Toggle: **Uses Outlined Icon in Dark Mode**
  Widget _darkModeToggle(
      ThemeProvider themeProvider, Color iconColor, bool isDarkMode) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(isDarkMode ? Icons.brightness_6_outlined : Icons.brightness_6,
              color: iconColor),
          const SizedBox(width: 8),
          const Text('الوضع المظلم', textAlign: TextAlign.right),
          const Spacer(),
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

  void _navigateToHome(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  void _navigateTo(BuildContext context, String destination) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Navigating to $destination')));
  }

  void _logout(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
