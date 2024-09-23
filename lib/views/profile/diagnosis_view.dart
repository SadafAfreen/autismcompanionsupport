import 'package:flutter/material.dart';

class DiagnosisView extends StatefulWidget {
  const DiagnosisView({super.key});

  @override
  State<DiagnosisView> createState() => _DiagnosisView();
}

class _DiagnosisView extends State<DiagnosisView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {}, 
            child: const Text('Start Diagnosis'),
          ),
        ],
      )
    );
  }
}