import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/colors.dart'; // Ensure this file exists and defines `TColor.primaryColor`
import '../../widgets/round_textfield.dart'; // Ensure this file exists and `RoundTextField` widget is correctly defined

class ProfileScreen extends StatefulWidget {
  final bool showBackButton;

  const ProfileScreen({super.key, this.showBackButton = true});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<String> genderOptions = ['Male', 'Female'];
  String? selectedGender;
  String? profileImagePath;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = preferences.getString('name') ?? '';
      emailController.text = preferences.getString('email') ?? '';
      passwordController.text = preferences.getString('password') ?? '';
      addressController.text = preferences.getString('address') ?? '';
      phoneController.text = preferences.getString('phone') ?? '';
      selectedGender = preferences.getString('gender');
      profileImagePath = preferences.getString('profileImagePath');
    });
  }

  Future<void> _saveUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('name', nameController.text);
    await preferences.setString('email', emailController.text);
    await preferences.setString('address', addressController.text);
    await preferences.setString('phone', phoneController.text);
    await preferences.setString('gender', selectedGender ?? '');
    await preferences.setString('password', passwordController.text);
    if (profileImagePath != null) {
      await preferences.setString('profileImagePath', profileImagePath!);
    }

    setState(() {
      _isSaved = true;
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        profileImagePath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        automaticallyImplyLeading: false,
        leading: widget.showBackButton
            ? IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            size: 22,
            color: Colors.black,
          ),
        )
            : null,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(75.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: profileImagePath != null
                        ? Image.file(
                      File(profileImagePath!),
                      fit: BoxFit.cover,
                    )
                        : Image.asset(
                      "assets/images/me.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 105,
                    left: 105,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: TColor.primaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Iconsax.gallery,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              RoundTextField(
                bgColor: _isSaved ? Colors.green[50] : Colors.white70,
                controller: nameController,
                hintText: 'Your Name',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              RoundTextField(
                bgColor: _isSaved ? Colors.green[50] : Colors.white70,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                hintText: 'Your Email',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              RoundTextField(
                bgColor: _isSaved ? Colors.green[50] : Colors.white70,
                controller: passwordController,
                hintText: 'Your Password',
                obscureText: true,
              ),
              const SizedBox(height: 15),
              RoundTextField(
                bgColor: _isSaved ? Colors.green[50] : Colors.white70,
                keyboardType: TextInputType.phone,
                controller: phoneController,
                hintText: 'Your Number',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              RoundTextField(
                bgColor: _isSaved ? Colors.green[50] : Colors.white70,
                controller: addressController,
                hintText: 'Your Address',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: DropdownButtonFormField<String>(
                  value: selectedGender,
                  hint: const Text(
                    'Select Gender',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  items: genderOptions.map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedGender = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: _saveUserDetails,
                color: TColor.primaryColor,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontFamily: 'Poppins-Medium',
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
