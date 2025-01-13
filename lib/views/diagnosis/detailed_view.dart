import 'package:autismcompanionsupport/constants/app_colors.dart';
import 'package:autismcompanionsupport/services/profile/profile_storage_constants.dart';
import 'package:autismcompanionsupport/widgets/bold_text.dart';
import 'package:autismcompanionsupport/widgets/custom_text_button.dart';
import 'package:autismcompanionsupport/widgets/input_field.dart';
import 'package:autismcompanionsupport/widgets/light_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailedView extends StatefulWidget {
  Map<String, dynamic>? diagnosis;
  Function? callback;

  DetailedView({
    super.key,
    required this.diagnosis,
    required this.callback,
  });

  @override
  State<DetailedView> createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {

  late final Map<String, TextEditingController> subScaledControllers;
  late final Map<String, TextEditingController> percentileControllers;

  late bool _allFieldsCompleted;

  @override
  void initState() {
    super.initState();

    if(!mounted) return;

    subScaledControllers = {
      rrbFieldName: TextEditingController(),
      siFieldName: TextEditingController(),
      scFieldName: TextEditingController(),
      erFieldName: TextEditingController(),
      csFieldName: TextEditingController(),
      msFieldName: TextEditingController(),
    };

    percentileControllers = {
      rrbFieldName: TextEditingController(),
      siFieldName: TextEditingController(),
      scFieldName: TextEditingController(),
      erFieldName: TextEditingController(),
      csFieldName: TextEditingController(),
      msFieldName: TextEditingController(),
    };

    _allFieldsCompleted = false;

    _loadDiagnosisData();
    
    Future.delayed(const Duration(seconds: 2), () {
      if(mounted) {
        _addListenersToControllers();
      }
    });
  }

  Future<void> _loadDiagnosisData() async {
    if(widget.diagnosis != null && mounted) {
      setState(() {
        widget.diagnosis?.forEach((key, value) { 
          if (subScaledControllers.containsKey(key) && percentileControllers.containsKey(key)) {
            subScaledControllers[key]!.text = (value['subScaledScore'] ?? "").toString();
            percentileControllers[key]!.text = (value['percentileScore'] ?? "").toString();
          }
        });
      });
    }
  }

  Future<void> _addListenersToControllers() async {
    subScaledControllers.forEach((key, controller) {
      controller.addListener(() {
        updateDiagnosisData(key, "subScaledScore", controller.text);
        _allFieldsFilled();
      });
    });

    percentileControllers.forEach((key, controller) {
      controller.addListener(() {
        updateDiagnosisData(key, "percentileScore", controller.text);
        _allFieldsFilled();
      });
    });
  }

  Future<void> _allFieldsFilled() async {
    
    bool flag = false;
    
    widget.diagnosis?.forEach((key,value) {
      flag = value[rawScoreFieldName] != 0 &&
        value[subScaledScoreFieldName] != 0 &&
        value[percentileScoreFieldName] != 0;
    });

      setState(() {
        _allFieldsCompleted = flag;
      });
  }
  
  @override
  dispose() {
    super.dispose();

    for (var controller in subScaledControllers.values) {
      controller.dispose();
    }
    for (var controller in percentileControllers.values) {
      controller.dispose();
    }
  }

  void updateDiagnosisData(String key, String scoreType, String value) {
    if (widget.diagnosis != null) {
      setState(() {
        widget.diagnosis![key] ??= {};
        widget.diagnosis![key][scoreType] = int.tryParse(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BoldText(text: "Detailed Results", size: 15, color: AppColors.primaryColor,),
        const SizedBox(height: 20),
        widget.diagnosis != null 
        ? Column(
            children: [
              ...widget.diagnosis!.entries.map((entry) {
                final key = entry.key;
                final value = entry.value;

                subScaledControllers[key] ??= TextEditingController();
                percentileControllers[key] ??= TextEditingController();

                final subScaledController = subScaledControllers[key]!;
                final percentileController = percentileControllers[key]!;
              
                return Column(
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        BoldText(text: "$key: ", size: 14),
                        const SizedBox(width: 3),
                        LightText(text: "${value['rawScore']}", size: 14),
                      ],
                    ),
                    const SizedBox(height: 10),
                    InputField(
                      placeholder: "SubScaled Score",
                      controller: subScaledController,
                      type: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    InputField(
                      placeholder: "Percentile Score",
                      controller: percentileController,
                      type: TextInputType.number,
                    ),
                  ],
                );
              }),
            ],
          )
        : const SizedBox(),
        const SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextButton(
              text: "Generate Result", 
              bgColor: _allFieldsCompleted ? AppColors.textColorBlack : AppColors.switchGreyColor,
              onPressed: () {
                _allFieldsCompleted 
                  ? widget.callback!(widget.diagnosis)
                  : null;
              }
            ),
          ],
        ),
      ],
    );
  }
}