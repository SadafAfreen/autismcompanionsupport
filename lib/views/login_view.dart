import 'package:autismcompanionsupport/constants/routes.dart';
import 'package:autismcompanionsupport/services/auth/auth_exceptions.dart';
import 'package:autismcompanionsupport/services/auth/auth_service.dart';
import 'package:autismcompanionsupport/utilities/show_error_dialog.dart';
import 'package:autismcompanionsupport/widgets/custom_text_button.dart';
import 'package:autismcompanionsupport/widgets/input_field.dart';
import 'package:autismcompanionsupport/widgets/bold_text.dart';
import 'package:autismcompanionsupport/widgets/light_text.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login(BuildContext context) async {
    final email = _email.text;
    final password = _password.text;
    try {
      await AuthService.firebase().login(
        email: email, 
        password: password,
      );
      final user = AuthService.firebase().currentUser;
      if(user?.isEmailVerified ?? false) {
        if(context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            dashboardRoute, 
            (route) => false
          );
        }
      } else {
        if(context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            verifyEmailRoute, 
            (route) => false 
          );
        }
      }
    } on UserNotFoundAuthException {
      if(context.mounted) await showErrorDialog(context, 'User not found');
    } on WrongPasswordAuthException {
      if(context.mounted) await showErrorDialog(context, 'Invalid Credentials');
    } on GenericAuthException  {
      if(context.mounted) await showErrorDialog(context, 'Authentication Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Column (
        children: [ 
          Image.asset("assets/images/shape7.png"),
          const SizedBox(height: 45),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(child: BoldText(text: "Login")),
                const SizedBox(height: 15),
                InputField(
                  placeholder: 'Enter your email here', 
                  icon: Icons.email_outlined, 
                  controller: _email,
                  type: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                InputField(
                  placeholder: "Enter your password here", 
                  icon: Icons.lock_outline, 
                  controller: _password,
                  isProtected: true,
                ),
                const SizedBox(height: 20),
                CustomTextButton(text: 'Login', onPressed: () => _login(context)),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registerRoute, 
                      (route) => false
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LightText(text: "Not registered yet?"),
                      SizedBox(width: 3),
                      BoldText(text: "Register here!", size: 15,),
                    ],)
                ),
              ],
            ),
          ),
          const Spacer(),
          Image.asset("assets/images/shape6.png"),
        ],
      ),
    );
  }
}