// Import các package cần thiết
import 'package:flutter/material.dart'; // Package chính của Flutter
import 'package:flutter_bloc/flutter_bloc.dart'; // Package quản lý state
import 'package:go_router/go_router.dart'; // Package điều hướng
import 'package:sync_ops/features/auth/presentation/bloc/auth_bloc.dart'; // BLoC xử lý xác thực
import 'package:sync_ops/features/auth/presentation/utils/validation_utils.dart'; // Tiện ích xác thực
import 'package:sync_ops/features/auth/presentation/widgets/auth_button.dart'; // Widget nút xác thực
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
            // Chuyển hướng đến trang dashboard khi xác thực thành công
            context.go('/dashboard');
          } else if (state is Error) {
            // Hiển thị thông báo lỗi
            final errorState = state;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorState.message),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
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
                      _buildLogo(),
                      const SizedBox(height: 16),
                      _buildTitle(context),
                      const SizedBox(height: 8),
                      _buildSubtitle(context, l10n),
                      const SizedBox(height: 48),

                      // Form đăng nhập
                      _buildEmailField(context, l10n),
                      const SizedBox(height: 16),
                      _buildPasswordField(context, l10n),
                      _buildForgotPasswordButton(l10n),
                      const SizedBox(height: 24),

                      // Nút đăng nhập
                      AuthButton(
                        text: l10n.login,
                        onPressed: _submitForm,
                        isLoading: state is Loading,
                      ),
                      const SizedBox(height: 16),

                      // Chuyển sang đăng ký
                      _buildRegisterRow(context, l10n),
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

  /// Widget hiển thị logo
  Widget _buildLogo() {
    return const Hero(
      tag: 'app_logo',
      child: Icon(Icons.sync_alt_rounded, size: 80, color: Colors.blue),
    );
  }

  /// Widget hiển thị tiêu đề
  Widget _buildTitle(BuildContext context) {
    return Text(
      'SyncOps',
      style: Theme.of(context).textTheme.headlineMedium,
      textAlign: TextAlign.center,
    );
  }

  /// Widget hiển thị phụ đề
  Widget _buildSubtitle(BuildContext context, AppLocalizations l10n) {
    return Text(
      l10n.loginSubtitle,
      style: Theme.of(context).textTheme.bodyMedium,
      textAlign: TextAlign.center,
    );
  }

  /// Widget hiển thị trường nhập email
  Widget _buildEmailField(BuildContext context, AppLocalizations l10n) {
    return CustomTextField(
      controller: _emailController,
      labelText: l10n.email,
      hintText: l10n.emailHint,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator:
          (value) => ValidationUtils.validateEmail(
            value,
            l10n.emailEmpty,
            l10n.emailInvalid,
          ),
    );
  }

  /// Widget hiển thị trường nhập mật khẩu
  Widget _buildPasswordField(BuildContext context, AppLocalizations l10n) {
    return CustomTextField(
      controller: _passwordController,
      labelText: l10n.password,
      hintText: l10n.passwordHint,
      prefixIcon: Icons.lock_outline,
      suffixIcon: IconButton(
        icon: Icon(
          _obscurePassword
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
        ),
        onPressed: _togglePasswordVisibility,
      ),
      obscureText: _obscurePassword,
      validator:
          (value) => ValidationUtils.validatePassword(
            value,
            l10n.passwordEmpty,
            l10n.passwordTooShort,
          ),
    );
  }

  /// Widget hiển thị nút quên mật khẩu
  Widget _buildForgotPasswordButton(AppLocalizations l10n) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // TODO: Implement forgot password functionality
        },
        child: Text(l10n.forgotPassword),
      ),
    );
  }

  /// Widget hiển thị hàng đăng ký
  Widget _buildRegisterRow(BuildContext context, AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(l10n.noAccount),
        TextButton(
          onPressed: () {
            context.go('/register');
          },
          child: Text(l10n.register),
        ),
      ],
    );
  }
}
