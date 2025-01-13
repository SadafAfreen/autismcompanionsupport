import 'package:autismcompanionsupport/constants/app_colors.dart';
import 'package:autismcompanionsupport/constants/routes.dart';
import 'package:autismcompanionsupport/widgets/bold_text.dart';
import 'package:autismcompanionsupport/widgets/container.dart';
import 'package:autismcompanionsupport/widgets/light_text.dart';
import 'package:flutter/material.dart';

class DiagnosisView extends StatefulWidget {
  const DiagnosisView({super.key});

  @override
  State<DiagnosisView> createState() => _DiagnosisView();
}

class _DiagnosisView extends State<DiagnosisView> {
  bool isMute = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomContainer(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: const BoldText(text: "Gilliam Autism Rating Scale - Third Edition", size: 12, align: TextAlign.center,)
                      ,),
                      const SizedBox(height: 20,),
                      const LightText(
                        text: "The Gilliam Autism Rating Scale-Third Edition is a standardized instrument designed for assessment of persons who have autism spectrum disorder (ASD) and other severe behavioral disorders. The GARS-3 provides norm-referenced information that can assist in the diagnosis of ASD.",
                        size: 12,
                        align: TextAlign.justify,
                      ),
                      const SizedBox(height: 20,),
                      const BoldText(text: "Item Selection:", size: 12,),
                      const LightText(
                        text: "Item on the GARS-3 are based on the DSM-5 diagnostic criteria for ASD, adopted by the American Psychiatric Association in 2013.",
                        size: 12,
                        align: TextAlign.justify,
                      ),
                      const SizedBox(height: 20,),
                      const BoldText(text: "Normative Data:", size: 12,),
                      const LightText(
                        text: "The GARS-3 was standardized on a sample of 1,859 individuals with ASD from 47 states and the District of Columbia.",
                        size: 12,
                        align: TextAlign.justify,
                      ),
                      const SizedBox(height: 20,),
                      const BoldText(text: "Reliability:", size: 12,),
                      RichText(
                        textAlign: TextAlign.justify,
                        text: const TextSpan(
                          style: TextStyle(fontSize: 18, color: AppColors.textColorBlack, fontFamily: "font30"),
                          children: [
                            TextSpan(text: "Internal consistency of the GARS-3 was determined using Cronbach's alpha technique. Studies revealed average coefficient alphas of .90 for "),
                            TextSpan(
                              text: "Restricted/Repetitive Behaviors", 
                              style: TextStyle(fontWeight: FontWeight.bold),  // Bold styling
                            ),
                            TextSpan(text: ", .94 for "),
                            TextSpan(
                              text: "Social Interaction", 
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ", .89 for "),
                            TextSpan(
                              text: "Social Communication", 
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ", .90 for "),
                            TextSpan(
                              text: "Emotional Responses", 
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ", .86 for "),
                            TextSpan(
                              text: "Cognitive Style", 
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ", .79 for "),
                            TextSpan(
                              text: "Maladaptive Speech", 
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ", .94 for "),
                            TextSpan(
                              text: "Autism Index 4", 
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: " and .93 for "),
                            TextSpan(
                              text: "Autism Index 6.", 
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: " These reliability coefficients indicate that the items within the subscales are consistent in the measurement of characteristic behaviors of persons with ASD and other serious behavioral disorders. All of the items are sufficient for contributing to important diagnostic decisions."
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const BoldText(text: "Validity:", size: 12,),
                      const LightText(
                        text: "The validity of the GARS-3 was demonstrated through several research studies. Item analysis established that GARS-3 subscale items are consistent and discriminative. Criterion-prediction validity studies indicate that the GARS-3 is a highly accurate predictor of autism. Construct-identification validity studies provide strong evidence for the structure of the GARS-3. One may conclude that the GARS-3 is a valid measure of autism spectrum disorder, particularly of those behaviors that are identified in DSM-5, and that examiners can use the scale with confidence.",
                        size: 12,
                        align: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[200],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Diagnosis",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      Row(
                        children: [
                            FloatingActionButton(
                              onPressed: () => Navigator.of(context).pushNamed(formRoute),
                              heroTag: "Start Diagnosis",
                              mini: true, 
                              backgroundColor: AppColors.primaryColor,
                              child: const Icon(Icons.add), 
                            ),
                            const SizedBox(width: 8.0), 
                            FloatingActionButton(
                              onPressed: () => Navigator.of(context).pushNamed(diagnosisResultRoute),
                              heroTag: "View Diagnosis",
                              mini: true, 
                              backgroundColor: AppColors.primaryColor,
                              child: const Icon(Icons.visibility), 
                            ),
                          ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },   
    );
  }
}