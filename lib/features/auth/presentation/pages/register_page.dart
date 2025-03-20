// Import các package cần thiết
import 'package:flutter/material.dart'; // Package chính của Flutter
import 'package:flutter_bloc/flutter_bloc.dart'; // Package quản lý state
import 'package:go_router/go_router.dart'; // Package điều hướng
import 'package:sync_ops/features/auth/presentation/bloc/auth_bloc.dart'; // BLoC xử lý xác thực
import 'package:sync_ops/features/auth/presentation/widgets/custom_text_field.dart'; // Widget input tùy chỉnh
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Hỗ trợ đa ngôn ngữ

// Widget trang đăng ký
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

// State của trang đăng ký
class _RegisterPageState extends State<RegisterPage> {
  // Key để quản lý và validate form
  final _formKey = GlobalKey<FormState>();
  // Controller cho các trường nhập liệu
  final _fullNameController = TextEditingController(); // Quản lý input họ tên
  final _emailController = TextEditingController(); // Quản lý input email
  final _passwordController = TextEditingController(); // Quản lý input mật khẩu
  final _confirmPasswordController =
      TextEditingController(); // Quản lý input xác nhận mật khẩu
  // Trạng thái ẩn/hiện mật khẩu
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Giải phóng tài nguyên khi widget bị hủy
  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Hàm chuyển đổi trạng thái ẩn/hiện mật khẩu
  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  // Hàm chuyển đổi trạng thái ẩn/hiện xác nhận mật khẩu
  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  // Hàm xử lý khi submit form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Kiểm tra form hợp lệ
      // Gửi sự kiện đăng ký đến AuthBloc
      context.read<AuthBloc>().add(
        AuthEvent.registerRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          fullName: _fullNameController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.register)),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.go('/dashboard');
          } else if (state is Error) {
            final errorState = state;
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(errorState.message)));
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Tiêu đề
                      Text(
                        l10n.createAccount,
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.registerSubtitle,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),

                      // Form đăng ký
                      CustomTextField(
                        controller: _fullNameController,
                        labelText: l10n.fullName,
                        hintText: l10n.fullNameHint,
                        prefixIcon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.fullNameRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _emailController,
                        labelText: l10n.email,
                        hintText: l10n.emailHint,
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.emailRequired;
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return l10n.emailInvalid;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _passwordController,
                        labelText: l10n.password,
                        hintText: l10n.passwordHint,
                        prefixIcon: Icons.lock_outline,
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.passwordRequired;
                          }
                          if (value.length < 6) {
                            return l10n.passwordTooShort;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _confirmPasswordController,
                        labelText: l10n.confirmPassword,
                        hintText: l10n.confirmPasswordHint,
                        prefixIcon: Icons.lock_outline,
                        obscureText: _obscureConfirmPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: _toggleConfirmPasswordVisibility,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.confirmPasswordRequired;
                          }
                          if (value != _passwordController.text) {
                            return l10n.passwordsDoNotMatch;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Nút đăng ký
                      ElevatedButton(
                        onPressed: state is Loading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child:
                            state is Loading
                                ? const CircularProgressIndicator()
                                : Text(l10n.register),
                      ),
                      const SizedBox(height: 16),

                      // Chuyển sang đăng nhập
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(l10n.alreadyHaveAccount),
                          TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: Text(l10n.login),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
