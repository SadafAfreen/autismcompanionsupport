import 'package:autismcompanionsupport/constants/routes.dart';
import 'package:autismcompanionsupport/services/auth/auth_service.dart';
import 'package:autismcompanionsupport/views/dashboard_view.dart';
import 'package:autismcompanionsupport/views/login_view.dart';
import 'package:autismcompanionsupport/views/profile/diagnosis_view.dart';
import 'package:autismcompanionsupport/views/profile/profile_view.dart';
import 'package:autismcompanionsupport/views/register_view.dart';
import 'package:autismcompanionsupport/views/verify_email_view.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        dashboardRoute: (context) => const DashboardView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        diagnosisRoute: (context) => const DiagnosisView(),
        profileRoute: (context) => const ProfileView(),
      }
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
            future: AuthService.firebase().initialize(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final user = AuthService.firebase().currentUser;
                  if(user != null) {
                    if(user.isEmailVerified) {
                      return const DashboardView();
                    } else {
                      return const VerifyEmailView();
                    }
                  } else {
                    return const LoginView();
                  }
                default:
                  return const CircularProgressIndicator();
              }
            },
          );
  }
}

