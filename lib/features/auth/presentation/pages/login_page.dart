// Import các package cần thiết
import 'package:flutter/material.dart'; // Package chính của Flutter
import 'package:flutter_bloc/flutter_bloc.dart'; // Package quản lý state
import 'package:go_router/go_router.dart'; // Package điều hướng
import 'package:sync_ops/features/auth/presentation/bloc/auth_bloc.dart'; // BLoC xử lý xác thực
import 'package:sync_ops/features/auth/presentation/widgets/custom_text_field.dart'; // Widget input tùy chỉnh
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Hỗ trợ đa ngôn ngữ

// Widget trang đăng nhập
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// State của trang đăng nhập
class _LoginPageState extends State<LoginPage> {
  // Key để quản lý và validate form
  final _formKey = GlobalKey<FormState>();
  // Controller cho các trường nhập liệu
  final _emailController = TextEditingController(); // Quản lý input email
  final _passwordController = TextEditingController(); // Quản lý input mật khẩu
  // Trạng thái ẩn/hiện mật khẩu
  bool _obscurePassword = true;

  // Giải phóng tài nguyên khi widget bị hủy
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Hàm chuyển đổi trạng thái ẩn/hiện mật khẩu
  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  // Hàm xử lý khi submit form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Kiểm tra form hợp lệ
      // Gửi sự kiện đăng nhập đến AuthBloc
      context.read<AuthBloc>().add(
        AuthEvent.loginRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state case Authenticated()) {
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
                      // Logo và tiêu đề
                      const Icon(
                        Icons.sync_alt_rounded,
                        size: 80,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'SyncOps',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.loginSubtitle,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),

                      // Form đăng nhập
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
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // TODO: Navigate to forgot password
                          },
                          child: Text(l10n.forgotPassword),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Nút đăng nhập
                      ElevatedButton(
                        onPressed: state is Loading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child:
                            state is Loading
                                ? const CircularProgressIndicator()
                                : Text(l10n.login),
                      ),
                      const SizedBox(height: 16),

                      // Chuyển sang đăng ký
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(l10n.dontHaveAccount),
                          TextButton(
                            onPressed: () {
                              context.push('/register');
                            },
                            child: Text(l10n.register),
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
