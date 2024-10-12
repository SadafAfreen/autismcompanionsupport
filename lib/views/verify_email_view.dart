import 'package:autismcompanionsupport/constants/app_colors.dart';
import 'package:autismcompanionsupport/constants/routes.dart';
import 'package:autismcompanionsupport/services/auth/auth_service.dart';
import 'package:autismcompanionsupport/widgets/bold_text.dart';
import 'package:autismcompanionsupport/widgets/light_text.dart';
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
      appBar: AppBar(
        title: const BoldText(text: 'Verify Email'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/shape3.png', // Replace with your image path
                  fit: BoxFit.cover, // Cover the whole area
                ),
              ),
            
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.mark_email_unread_outlined,
                      size: 100,
                    ),
                    const SizedBox(height: 30),
                    const BoldText(text: "Verify your email address", align: TextAlign.center, size: 17),
                    const SizedBox(height: 30),
                    const LightText(
                      text: "We have just send email verification link on your email. Please check email and click on that link to verify your email address.",
                      textOverflow: TextOverflow.visible,
                      align: TextAlign.center,
                      size: 12.5,
                    ),
                    const SizedBox(height: 25),
                    const LightText(
                      text: "If have not received an email yet, click on the link below.",
                      textOverflow: TextOverflow.visible,
                      align: TextAlign.center,
                      size: 12.5,
                    ),
                    const SizedBox(height: 25),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.textColorBlack,
                        padding: const EdgeInsets.all(16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        AuthService.firebase().sendEmailVerification();
                      },
                      child: const LightText(text: "Send verification link", color: AppColors.whiteColor,),
                    ),
                    const SizedBox(height: 150),
                  ]
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              if(context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute, 
                  (route) => false
                );
              }
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_sharp),
                SizedBox(width: 10),
                Text('Login to continue'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}