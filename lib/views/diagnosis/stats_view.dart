import 'dart:developer';

import 'package:autismcompanionsupport/constants/app_colors.dart';
import 'package:autismcompanionsupport/constants/routes.dart';
import 'package:autismcompanionsupport/services/auth/auth_service.dart';
import 'package:autismcompanionsupport/services/diagnosis/firebase_diagnosis_stats.dart';
import 'package:autismcompanionsupport/views/diagnosis/compress_view.dart';
import 'package:autismcompanionsupport/views/diagnosis/detailed_view.dart';
import 'package:autismcompanionsupport/widgets/bold_text.dart';
import 'package:flutter/material.dart';

class StatsView extends StatefulWidget {
  const StatsView({super.key});

  @override
  State<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {

  late final FirebaseDiagnosisStats _diagnosisService;

  late Map<String, dynamic>? _diagnosisStats;
  late Map<String, dynamic>? _diagnosisResults;
  late bool _detailedView;

  @override
  initState() {
    super.initState();

    _diagnosisService = FirebaseDiagnosisStats();
    _detailedView = false;
    _diagnosisStats = null;
    _diagnosisResults = null;

    _loadDiagnosisData();
  }

  Future<void> _loadDiagnosisData() async {
    final currentUser = AuthService.firebase().currentUser!;
    final diagnosisData = await _diagnosisService.getDiagnosisResults(ownerUserId: currentUser.id);

    if (diagnosisData != null) {
      setState(() {
        _diagnosisStats = diagnosisData.diagnosisStats;
        _diagnosisResults = diagnosisData.diagnosisResults;
      });
    } 
  }

  void _generateResult(diagnosis) {
    log("inside generateResult()");

    setState(() {
      _diagnosisStats = diagnosis;
    });

    _diagnosisStats?.forEach((key, value) {
      log("$key = $value");
    });

    if (_diagnosisStats == null) return;
  
    int cumulativeScore = 0;
    _diagnosisStats?.forEach((key, value) {
      cumulativeScore += int.tryParse(value['subScaledScore'].toString()) ?? 0;
      //cumulativeScore += value['subScaledScore'] as int;
    });

    final diagnosisResults = {
      "autismIndex": cumulativeScore,
      "probASD": "",
      "severityLevel": "",
      "descriptor": ""
    };
      
    if (cumulativeScore < 54) {
      diagnosisResults["probASD"] = "Unlikely";
      diagnosisResults["severityLevel"] = "";
      diagnosisResults["descriptor"] = "Not ASD";
    } else if (cumulativeScore < 77) {
      diagnosisResults["probASD"] = "Probable";
      diagnosisResults["severityLevel"] = "Level 1";
      diagnosisResults["descriptor"] = "Minimal Support Required";
    } else if (cumulativeScore < 100) {
      diagnosisResults["probASD"] = "Very Likely";
      diagnosisResults["severityLevel"] = "Level 2";
      diagnosisResults["descriptor"] = "Requiring Substantial Support";
    } else {
      diagnosisResults["probASD"] = "Very Likely";
      diagnosisResults["severityLevel"] = "Level 3";
      diagnosisResults["descriptor"] = "Requiring Very Substantial Support";
    }

    setState(() {
      _diagnosisResults = diagnosisResults;
    });

    try {
      final currentUser = AuthService.firebase().currentUser!;

      _diagnosisService.uploadDiagnosisData(
        ownerUserId: currentUser.id, 
        diagnosisStats: _diagnosisStats!,
        diagnosisResults: _diagnosisResults!,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Diagnosis successfully!')),
      );

      Future.delayed(const Duration(milliseconds: 1000), () {
        if(mounted) Navigator.popAndPushNamed(context, diagnosisResultRoute);
      });
    } catch(_) {
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error generating Diagnosis Results')),
      );
    }
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _detailedView 
          ? DetailedView(diagnosis: _diagnosisStats, callback: _generateResult)
          : CompressView(diagnosis: _diagnosisStats, results: _diagnosisResults),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BoldText(
          text: "Diagnosis Results",
          size: 15,
        ),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () => Navigator.of(context).popAndPushNamed(dashboardRoute), 
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            icon: Icon(_detailedView ? Icons.remove : Icons.add),
            onPressed: () {
              setState(() {
                _detailedView = !_detailedView;
              });
            },
          ),
        ],
      ),
      body: _body(),
    );
  }
}