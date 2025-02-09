import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:submit/themes/theme_provider.dart';

class SignUpPage_citzen extends StatefulWidget {
  const SignUpPage_citzen({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage_citzen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final _formKey = GlobalKey<FormState>();
  File? _image;
  String? _password;
  String? _confirmPassword;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  isDarkMode
                      ? 'images/logo-white.png' // Dark mode image
                      : 'images/logo-removebg-preview.png', // Light mode logo
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                Text(
                  "إنشاء حساب",
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Color(0xFF725DFE),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    height: 2.5,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField("البريد الالكتروني", Icons.email, false, null),
                _buildTextField("كلمة المرور", Icons.lock, true, null),
                _buildTextField("تأكيد كلمة المرور", Icons.lock, true, null),
                _buildTextField("رقم الهاتف", Icons.phone, false, null),
                _buildImagePicker(),
                _buildSignUpButton(),
                _buildSignInLink(context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF725DFE), width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _image == null
                  ? const Icon(Icons.camera_alt, size: 50, color: Colors.grey)
                  : Image.file(_image!, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 10),
          const Text("إدراج صورة البطاقة الشخصية",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF725DFE))),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, bool isPassword,
      String? Function(String?)? validator) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        obscureText:
            isPassword ? (_obscurePassword || _obscureConfirmPassword) : false,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: label,
          labelStyle: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
          icon: Icon(icon, color: Colors.grey),
          hintText: "ادخل $label",
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey[600]),
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      if (label == "كلمة المرور") {
                        _obscurePassword = !_obscurePassword;
                      } else {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      }
                    });
                  },
                  icon: Icon(
                    (label == "كلمة المرور"
                            ? _obscurePassword
                            : _obscureConfirmPassword)
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                )
              : null,
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: MaterialButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sign Up Successful')));
          }
        },
        color: const Color(0xFF725DFE),
        height: 60,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Text(
          "التسجيل",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSignInLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(" لديك حساب بالفعل !",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("تسجيل الدخول",
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF725DFE),
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
