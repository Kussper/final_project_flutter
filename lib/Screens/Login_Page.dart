import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submit/Screens/home_screen.dart';
import '../employee_scrrens/home_page.dart';
import '../themes/theme_provider.dart';
import 'Register_Page_citzen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _loginMessage;

  void _handleLogin(BuildContext context) {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      if (email == "kussper@gmail.com" && password == "12345678") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } else {
      setState(() {
        _loginMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final theme = Theme.of(context);

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.asset(
                isDarkMode
                    ? 'images/logo-white.png' // Dark mode image
                    : 'images/logo-removebg-preview.png', // Light mode image
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                "مرحبا بك",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : const Color(0xFF725DFE),
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      "البريد الالكتروني",
                      Icons.email_outlined,
                      false,
                      emailController,
                      emailValidator,
                      "example@gmail.com",
                      theme,
                    ),
                    _buildTextField(
                      "كلمة المرور",
                      Icons.lock_outline,
                      true,
                      passwordController,
                      passwordValidator,
                      "******",
                      theme,
                    ),
                    _buildLoginButton(context, theme),
                    const SizedBox(height: 30),
                    _buildSignUpLink(context, theme),
                    if (_loginMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          _loginMessage!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _loginMessage == "Login Successful"
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon,
    bool isPassword,
    TextEditingController controller,
    String? Function(String?) validator,
    String hint,
    ThemeData theme,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? _obscurePassword : false,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: theme.colorScheme.onSurface.withOpacity(0.5)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: const Color(0xFF725DFE), width: 2.0),
          ),
          labelText: label,
          labelStyle: TextStyle(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              fontSize: 18,
              fontWeight: FontWeight.bold),
          hintText: hint,
          hintStyle: TextStyle(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
              fontSize: 16),
          prefixIcon: Icon(
            icon,
            color: theme.colorScheme.onSurface.withOpacity(0.7),
            size: 24,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                )
              : null,
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, ThemeData theme) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: MaterialButton(
        onPressed: () => _handleLogin(context),
        color: const Color(0xFF725DFE),
        height: 60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Text(
          "الدخول",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "ليس لديك حساب ؟",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SignUpPage_citzen()),
            );
          },
          child: Text(
            "انشاء حساب",
            style: TextStyle(
              fontSize: 20,
              color: const Color(0xFF725DFE),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  String? emailValidator(String? value) {
    final emailRegExp =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (value == null || value.isEmpty) {
      return "البريد الالكتروني مطلوب";
    } else if (!emailRegExp.hasMatch(value)) {
      return "يرجي ادخال بريد الكتروني صالح";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "كلمة المرور مطلوبة";
    }
    if (value.length < 6) {
      return "يجب أن تحتوي كلمة المرور على 6 أحرف على الأقل";
    }
    return null;
  }
}
