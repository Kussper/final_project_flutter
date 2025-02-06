import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submit/Screens/Login_Page.dart';
import '/themes/theme_provider.dart';
import '/Screens/home_screen.dart'; // Import HomeScreen

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("اهلا,محمود", textAlign: TextAlign.right),
            accountEmail: Text("mahmoud@gmail.com", textAlign: TextAlign.right),
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
                  icon: Icons.home,
                  text: 'الرئيسية',
                  onTap: () =>
                      _navigateToHome(context), // Navigate to HomeScreen
                ),
                Divider(),
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
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('تسجيل الخروج',
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.right),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData? icon, required String text, GestureTapCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text, textAlign: TextAlign.right),
      onTap: onTap,
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pop(context); // Close drawer
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => HomeScreen()), // Navigate to HomeScreen
    );
  }

  void _navigateTo(BuildContext context, String destination) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Navigating to $destination')));
  }

  void _logout(BuildContext context) {
    Navigator.pop(context); // Close the drawer
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
