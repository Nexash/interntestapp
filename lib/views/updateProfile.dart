import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revision/Constants/appTextStyles.dart';
import 'package:revision/Constants/colors.dart';
import 'package:revision/Provider/profileProvider.dart';
import 'package:revision/views/taskScreen.dart';

class UpdatePrfoileScreen extends StatefulWidget {
  const UpdatePrfoileScreen({super.key});

  @override
  State<UpdatePrfoileScreen> createState() => _UpdatePrfoileScreenState();
}

class _UpdatePrfoileScreenState extends State<UpdatePrfoileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();

  void SubmitData() {
    String name = nameController.text.trim();
    String address = addressController.text.trim();
    String ageText = ageController.text.trim();
    String phoneText = phoneNoController.text.trim();

    int? age = int.tryParse(ageText);
    int? phoneNo = phoneText.isEmpty ? null : int.tryParse(phoneText);

    if (name.isEmpty || address.isEmpty || age == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Fill the required fields")));
      return;
    }

    context.read<ProfileProvider>().updateProfile(name, address, age, phoneNo);

    // ProfileModal updatedProfile = ProfileModal(
    //   name: name,
    //   address: address,
    //   age: age,
    //   number: phoneNo,
    // );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Taskscreen(
              // profile: updatedProfile
            ),
      ),
    );

    nameController.clear();
    addressController.clear();
    ageController.clear();
    phoneNoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Center(child: Text("Task App", style: AppTextStyles.headline1)),
        backgroundColor: const Color.fromARGB(255, 217, 132, 84),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Update your Profile:",
                      style: AppTextStyles.headline2,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Name:", style: AppTextStyles.headline3),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      labelText: "Enter your name",
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none, // Remove default border
                      ),
                      // contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      //       // Already set by Container
                    ),

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter name";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 15),

                  Text("Address:", style: AppTextStyles.headline3),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      labelText: "Enter your Address",
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none, // Remove default border
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter address";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 15),
                  Text("Age:", style: AppTextStyles.headline3),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      labelText: "Enter your Age",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none, // Remove default border
                      ),
                      hintStyle: TextStyle(fontSize: 20),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          value.length > 3) {
                        return "Please enter valid age";
                      }
                      if (!RegExp(r'^\d+$').hasMatch(value)) {
                        return "Phone number must contain only digits";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),

                  SizedBox(height: 15),
                  Text("Phone NO:", style: AppTextStyles.headline3),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: phoneNoController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      labelText: "Enter your Phone No",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none, // Remove default border
                      ),
                      hintStyle: TextStyle(fontSize: 20),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return null;
                      }
                      if (!RegExp(r'^\d+$').hasMatch(value)) {
                        return "Phone number must contain only digits";
                      }
                      if (value.length != 10) {
                        return "phone number must be exactly 10 digits";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 15),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          SubmitData();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("invalid form submission")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.light, // Button background color
                        foregroundColor: const Color.fromARGB(
                          255,
                          94,
                          81,
                          85,
                        ), // Text/icon color
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            20,
                          ), // Rounded corners
                        ),
                      ),
                      child: Text("Submit profile"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
