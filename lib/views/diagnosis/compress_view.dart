import 'package:autismcompanionsupport/constants/app_colors.dart';
import 'package:autismcompanionsupport/widgets/bold_text.dart';
import 'package:autismcompanionsupport/widgets/light_text.dart';
import 'package:flutter/material.dart';

class CompressView extends StatelessWidget {
  final Map<String, dynamic>? diagnosis;
  final Map<String, dynamic>? results;

  const CompressView({
    super.key, 
    required this.diagnosis,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BoldText(text: "Summary Results", size: 15, color: AppColors.primaryColor,),
        const SizedBox(height: 20),

        if (results != null) 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(results!['descriptor'] != "") 
                LightText(text: results!['descriptor'].toString(), size: 25, align: TextAlign.center),
                const SizedBox(height: 20),
              Row(
                children: [
                  const BoldText(text: "Autism Index: ", size: 14),
                  LightText(text: results!['autismIndex'].toString(), size: 14),
                ],
              ),
              Row(
                children: [
                  const BoldText(text: "Probability ASD: ", size: 14),
                  LightText(text: results!['probASD'].toString(), size: 14),
                ],
              ),
              Row(
                children: [
                  const BoldText(text: "Severity Level: ", size: 14),
                  LightText(text: results!['severityLevel'].toString(), size: 14),
                ],
              ),
            ],
          ),
        const SizedBox(height: 20),

        if(diagnosis != null) 
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (var entry in diagnosis!.entries) ...[
                Center(
                  child: BoldText(text: "${entry.key}:", size: 14),
                ),
                const SizedBox(height: 5),
                Center(
                  child: LightText(text: "Raw Score: ${entry.value['rawScore']}", size: 12),
                ),
                Center(
                  child: LightText(text: "Subscaled Score: ${entry.value['subScaledScore'] ?? '...'}", size: 12),
                ),
                Center(
                  child: LightText(text: "Percentile Score: ${entry.value['percentileScore'] ?? '...'}", size: 12),
                ),
                const Divider(height: 20, color: AppColors.primaryColor),
              ],
            ],
          ),
      ],
    );
  }
}