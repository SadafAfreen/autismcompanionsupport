import 'package:autismcompanionsupport/constants/routes.dart';
import 'package:autismcompanionsupport/services/auth/auth_exceptions.dart';
import 'package:autismcompanionsupport/services/auth/auth_service.dart';
import 'package:autismcompanionsupport/utilities/show_error_dialog.dart';
import 'package:autismcompanionsupport/widgets/bold_text.dart';
import 'package:autismcompanionsupport/widgets/custom_text_button.dart';
import 'package:autismcompanionsupport/widgets/input_field.dart';
import 'package:autismcompanionsupport/widgets/light_text.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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

  void _register(BuildContext context) async {
    final email = _email.text;
    final password = _password.text;
    try {
      await AuthService.firebase().createUser(
        email: email, 
        password: password
      );
      AuthService.firebase().sendEmailVerification();
      if(context.mounted) Navigator.of(context).pushNamed(verifyEmailRoute);
    } on EmailAlreadyInUseAuthException {
      if(context.mounted) await showErrorDialog(context, 'Email is already in use');
    } on InvalidEmailAuthException {
      if(context.mounted) await showErrorDialog(context, 'Invalid email entered');
    } on WeakPasswordAuthException {
      if(context.mounted) await showErrorDialog(context, 'Weak password');
    } on GenericAuthException {
      if(context.mounted) await showErrorDialog(context, 'Failed to Register');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column (
        children: [ 
          Image.asset("assets/images/shape8.png"),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(child: BoldText(text: "Register")),
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
                CustomTextButton(text: "Register", onPressed: () => _register(context)),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute, 
                      (route) => false
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LightText(text: "Already registered?"),
                      SizedBox(width: 3),
                      BoldText(text: "Login here!", size: 15),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Image.asset("assets/images/shape9.png"),
        ],
      ),
    );
  }
}