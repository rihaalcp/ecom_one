import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import '../../theme/app_colors.dart';
import '../services/auth_service.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/gradient_button.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _agreedToTerms = false;
  bool _isLoading = false;
  double _strength = 0; // 0..1
  String _strengthLabel = 'Password strength';
  Color _strengthColor = AppColors.surfaceContainerHigh;

  Map<String, dynamic> registerData = {};

  @override
  void initState() {
    super.initState();
    loadRegisterCMS();
  }

  Future<void> loadRegisterCMS() async {
    try {
      final res = await http.get(
        Uri.parse("http://localhost:5000/admin/page/get-register-page"),
      );
      if (!mounted) return;
      setState(() {
        registerData = jsonDecode(res.body);
      });
    } catch (e) {}
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _checkStrength(String value) {
    int score = 0;
    if (value.length >= 8) score++;
    if (RegExp(r'[A-Z]').hasMatch(value)) score++;
    if (RegExp(r'[0-9]').hasMatch(value)) score++;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(value)) score++;

    const labels = {
      0: 'Password strength',
      1: 'Weak password',
      2: 'Fair password',
      3: 'Good password',
      4: 'Strong password',
    };
    const colors = {
      0: AppColors.surfaceContainerHigh,
      1: AppColors.error,
      2: Color(0xFF914800),
      3: AppColors.secondary,
      4: AppColors.primary,
    };

    setState(() {
      _strength = score / 4;
      _strengthLabel = labels[score]!;
      _strengthColor = colors[score]!;
    });
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the Terms & Privacy Policy'),
        ),
      );
      return;
    }
    try {
      setState(() => _isLoading = true);

      await AuthService.instance.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  
  Future<void> saveRegisterCMS() async {
    try {
      final res = await http.get(
        Uri.parse("http://localhost:5000/admin/page/get-register-page"),
      );
      if(res.statusCode == 200){
        registerData = jsonDecode(res.body);
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(jsonDecode(res.body)['message'] ?? 'Saved')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving: $e')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Row(
                  //   children: [
                  //     IconButton(
                  //       onPressed: () => Navigator.of(context).pop(),
                  //       icon: const Icon(
                  //         Icons.arrow_back,
                  //         color: AppColors.onSurface,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 8),
                   Text(
                    registerData["title"] ?? 'Create Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                   Text(
                    registerData["subtitle"] ?? 'Join Lumina for a curated premium shopping experience.',
                    style: TextStyle(color: AppColors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 28),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AuthTextField(
                          label: registerData["fullNameLabel"] ?? 'Full Name',
                          hint: registerData["fullNameHint"] ?? 'John Doe',
                          icon: Icons.person_outline,
                          controller: _nameController,
                          validator: (v) => (v == null || v.isEmpty)
                              ? 'Name is required'
                              : null,
                        ),
                        const SizedBox(height: 18),
                        AuthTextField(
                          label: registerData["emailLabel"] ?? 'Email Address',
                          hint: registerData["emailHint"] ?? 'email@example.com',
                          icon: Icons.mail_outline,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.isEmpty)
                              return 'Email is required';
                            if (!v.contains('@')) return 'Enter a valid email';
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        AuthTextField(
                          label: registerData["phoneLabel"] ?? 'Phone Number',
                          hint: registerData["phoneHint"] ?? '+1 (555) 000-0000',
                          icon: Icons.call_outlined,
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (v) => (v == null || v.isEmpty)
                              ? 'Phone is required'
                              : null,
                        ),
                        const SizedBox(height: 18),
                        AuthTextField(
                          label: registerData["passwordLabel"] ?? 'Password',
                          hint: registerData["passwordHint"] ?? 'Min. 8 characters',
                          icon: Icons.lock_outline,
                          controller: _passwordController,
                          isPassword: true,
                          onChanged: _checkStrength,
                          validator: (v) {
                            if (v == null || v.isEmpty)
                              return 'Password is required';
                            if (v.length < 8) return 'Minimum 8 characters';
                            return null;
                          },
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: _strength,
                                  minHeight: 4,
                                  backgroundColor:
                                      AppColors.surfaceContainerHighest,
                                  valueColor: AlwaysStoppedAnimation(
                                    _strengthColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _strengthLabel,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _strength > 0.5
                                      ? AppColors.primary
                                      : AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        AuthTextField(
                          label: registerData["confirmPasswordLabel"] ?? 'Confirm Password',
                          hint: registerData["confirmPasswordHint"] ?? 'Re-type password',
                          icon: Icons.lock_outline,
                          controller: _confirmController,
                          isPassword: true,
                          validator: (v) {
                            if (v == null || v.isEmpty)
                              return 'Please confirm password';
                            if (v != _passwordController.text)
                              return 'Passwords do not match';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _agreedToTerms,
                              activeColor: AppColors.primary,
                              onChanged: (v) =>
                                  setState(() => _agreedToTerms = v ?? false),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: AppColors.onSurfaceVariant,
                                      fontSize: 14,
                                      height: 1.3,
                                    ),
                                    children: [
                                      const TextSpan(text: 'I agree to the '),
                                      TextSpan(
                                        text: 'Terms of Service',
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const TextSpan(text: ' and '),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const TextSpan(text: '.'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        GradientButton(
                          label: registerData["buttonText"] ?? 'Create Account',
                          height: 60,
                          isLoading: _isLoading,
                          gradient: AppColors.primaryGradient,
                          onPressed: _handleRegister,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'or continue with',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/google.svg',
                            width: 22,
                            height: 22,
                          ),
                          label:  Text(
                            registerData["googleLabel"] ?? 'Google',
                            style: TextStyle(color: AppColors.onSurface),
                          ),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                            side: const BorderSide(
                              color: AppColors.outlineVariant,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.apple,
                            size: 30,
                            color: AppColors.onSurface,
                          ),
                          label:  Text(
                            registerData["appleLabel"] ?? 'Apple',
                            style: TextStyle(color: AppColors.onSurface),
                          ),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                            side: const BorderSide(
                              color: AppColors.outlineVariant,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(color: AppColors.onSurfaceVariant),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
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