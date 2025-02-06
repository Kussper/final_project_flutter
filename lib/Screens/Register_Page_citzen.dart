import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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

  String? emailValidator(String? value) {
    final emailRegExp =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (value == null || value.isEmpty) {
      return "البريد الإلكتروني مطلوب";
    } else if (!emailRegExp.hasMatch(value)) {
      return "يرجى إدخال بريد إلكتروني صالح";
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
    _password = value;
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "تأكيد كلمة المرور مطلوب";
    }
    if (value != _password) {
      return "كلمة المرور غير متطابقة";
    }
    _confirmPassword = value;
    return null;
  }

  // Define _pickImage function
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Show the image source options to the user
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Set the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl, // Set the text direction to RTL
        child: SingleChildScrollView(
          // Wrap the form content in a SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0), // Horizontal padding
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'images/logo-removebg-preview.png',
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "إنشاء حساب",
                    style: TextStyle(
                      color: Color(0xFF725DFE),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      height: 2.5,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                _buildTextField(
                    "البريد الالكتروني", Icons.email, false, emailValidator),
                _buildTextField(
                    "كلمة المرور", Icons.lock, true, passwordValidator),
                _buildTextField("تأكيد كلمة المرور", Icons.lock, true,
                    confirmPasswordValidator),
                _buildTextField("رقم الهاتف", Icons.phone, false, null),
                _buildImagePicker(),
                _buildSignUpButton(),
                _buildSignInLink(context),
                const SizedBox(height: 20), // Add some space at the bottom
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
            onTap: _pickImage, // On tap, call the _pickImage function
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF725DFE), width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _image == null
                  ? const Icon(Icons.camera_alt,
                      size: 50,
                      color: Colors.grey) // Icon color changed to grey
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
          // Set the background color to gray
          border: const UnderlineInputBorder(),
          labelText: label,
          labelStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey), // Label color changed to grey
          icon: Icon(icon, color: Colors.grey), // Icon color changed to grey
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
                    color: Colors.grey, // Icon color changed to grey
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Text(
          "التسجيل",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          " لديك حساب بالفعل !",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "تسجيل الدخول",
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF725DFE),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
