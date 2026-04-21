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
      title: 'YIR Text Form Fields',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
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
  bool _obscurePassword = true;

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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form submitted successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "YIR Text Form Fields",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('YIR Text Form Field'),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• Custom shaped border'),
                      Text('• Animated glow pulse'),
                      Text('• Shimmer sweep effect'),
                      Text('• Floating animation'),
                      Text('• Tap scale effect'),
                      SizedBox(height: 8),
                      Text(
                        'All fields have red borders matching the design!',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              YirTextFormField(
                controller: _nameController,
                hint: "John Doe",
                label: "Enter your full name",
                keyboardType: TextInputType.name,
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: Colors.white70,
                  size: 20,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Name is required";
                  }
                  if ((value?.length ?? 0) < 3) {
                    return "Name must be at least 3 characters";
                  }
                  return null;
                },
                onChanged: (value) {
                  debugPrint('Name changed: $value');
                },
              ),
              const SizedBox(height: 24),

              YirTextFormField(
                controller: _emailController,
                hint: "john@example.com",
                label: "Enter your email",
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Colors.white70,
                  size: 20,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Email is required";
                  }
                  if (!value!.contains("@") || !value.contains(".")) {
                    return "Enter a valid email address";
                  }
                  return null;
                },
                onSubmitted: (value) {
                  debugPrint('Email submitted: $value');
                },
              ),
              const SizedBox(height: 24),

              YirTextFormField(
                controller: _phoneController,
                hint: "+1 (555) 000-0000",
                label: "Enter your phone number",
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(
                  Icons.phone_outlined,
                  color: Colors.white70,
                  size: 20,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Phone number is required";
                  }
                  if ((value?.length ?? 0) < 10) {
                    return "Enter a valid phone number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              YirTextFormField(
                controller: _passwordController,
                hint: "••••••••",
                label: "Create a password",
                keyboardType: TextInputType.visiblePassword,

                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.white70,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Password is required";
                  }
                  if ((value?.length ?? 0) < 6) {
                    return "Password must be at least 6 characters";
                  }
                  if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)').hasMatch(value!)) {
                    return "Password must contain both letters and numbers";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
