import 'package:flutter/material.dart';
import 'package:yir_text_form_field/yir_text_form_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Controllers for each text form field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "YIR Text Form Fields",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              
              // Name field
              const Text(
                "Enter Your Name",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(height: 8),
              YirTextFormField(
                controller: _nameController,
                hint: "John Doe",
                label: "Full Name",
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Name is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Email field
              const Text(
                "Enter Your Email",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(height: 8),
              YirTextFormField(
                controller: _emailController,
                hint: "john@example.com",
                label: "Email Address",
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.mail, color: Colors.white70),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Email is required";
                  }
                  if (!value!.contains("@")) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Phone field
              const Text(
                "Enter Your Phone",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(height: 8),
              YirTextFormField(
                controller: _phoneController,
                hint: "+1 (555) 000-0000",
                label: "Phone Number",
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone, color: Colors.white70),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Phone is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Password field
              const Text(
                "Enter Your Password",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(height: 8),
              YirTextFormField(
                controller: _passwordController,
                hint: "••••••••",
                label: "Password",
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: const Icon(Icons.visibility, color: Colors.white70),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Password is required";
                  }
                  if ((value?.length ?? 0) < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Address field
              const Text(
                "Enter Your Address",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(height: 8),
              YirTextFormField(
                controller: _addressController,
                hint: "123 Main St, City, State 12345",
                label: "Full Address",
                keyboardType: TextInputType.streetAddress,
                maxLines: 2,
                minLines: 2,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Address is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Message field
              const Text(
                "Enter Your Message",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(height: 8),
              YirTextFormField(
                controller: _messageController,
                hint: "Type your message here...",
                label: "Message",
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                minLines: 3,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Message is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Form submitted!\nName: ${_nameController.text}",
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
