import 'package:autismcompanionsupport/constants/routes.dart';
import 'package:autismcompanionsupport/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailView();
}

class _VerifyEmailView extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Column(
              children: [
                const Text("We've sent you an email verification link, please open that link to verify your account"),
                const Text(""),
                const Text("If you haven't received a verification link yet, Please click on the link below"),
                TextButton(
                  onPressed: () async {
                    AuthService.firebase().sendEmailVerification();
                  },
                  child: const Text('Send verification link'),
                ),
                TextButton(
                  onPressed: () async {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute, 
                      (route) => false
                    );
                  },
                  child: const Text('Login to continue'),
                ),
              ]
            ),
    );
  }
}