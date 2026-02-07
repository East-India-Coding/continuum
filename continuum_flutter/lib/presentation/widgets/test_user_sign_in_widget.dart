import 'package:continuum_flutter/presentation/utils/continuum_colors.dart';
import 'package:continuum_flutter/presentation/widgets/cyberpunk_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class TestUserSignInWidget extends StatefulWidget {

  const TestUserSignInWidget({
    required this.client, super.key,
    this.onAuthenticated,
    this.onError,
  });
  final ServerpodClientShared client;
  final VoidCallback? onAuthenticated;
  // ignore: inference_failure_on_function_return_type
  final Function(Object error)? onError;

  @override
  State<TestUserSignInWidget> createState() => _TestUserSignInWidgetState();
}

class _TestUserSignInWidgetState extends State<TestUserSignInWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onSignIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final client = widget.client;
      final emailEndpoint = client.getEndpointOfType<EndpointEmailIdpBase>();

      final authResponse = await emailEndpoint.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      await client.auth.updateSignedInUser(authResponse);

      if (client.auth.isAuthenticated) {
        widget.onAuthenticated?.call();
      } else {
        throw Exception(
          'Authentication failed. Please check your credentials.',
        );
      }
    } catch (e) {
      widget.onError?.call(e);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTextField(
          controller: _emailController,
          label: 'EMAIL',
          icon: Icons.email_outlined,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _passwordController,
          label: 'PASSWORD',
          icon: Icons.lock_outline,
          isPassword: true,
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: CyberpunkButton(
            onPressed: _isLoading ? null : _onSignIn,
            text: _isLoading ? 'SIGNING IN...' : 'SIGN IN',
            icon: Icons.login,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.rajdhani(
            color: ContinuumColors.accent,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF051A1A),
            border: Border.all(color: ContinuumColors.accentDarker),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            style: GoogleFonts.robotoMono(
              color: Colors.white,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: 'Enter $label',
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.3),
              ),
              prefixIcon: Icon(
                icon,
                color: ContinuumColors.accentDark,
                size: 18,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
