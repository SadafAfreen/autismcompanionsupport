import 'package:autismcompanionsupport/constants/app_colors.dart';
import 'package:autismcompanionsupport/constants/questions.dart';
import 'package:autismcompanionsupport/constants/routes.dart';
import 'package:autismcompanionsupport/services/auth/auth_service.dart';
import 'package:autismcompanionsupport/services/diagnosis/firebase_diagnosis_stats.dart';
import 'package:autismcompanionsupport/services/profile/firebase_profile_storage.dart';
import 'package:autismcompanionsupport/services/profile/profile_storage_constants.dart';
import 'package:autismcompanionsupport/views/diagnosis/question_model.dart';
import 'package:autismcompanionsupport/widgets/bold_text.dart';
import 'package:autismcompanionsupport/widgets/container.dart';
import 'package:autismcompanionsupport/widgets/light_text.dart';
import 'package:flutter/material.dart';

class FormView extends StatefulWidget {
  const FormView({super.key});

  @override
  State<StatefulWidget> createState() => _FormView();
}

class _FormView extends State<FormView> {
  
  late final FirebaseProfileStorage _profileService;
  late final FirebaseDiagnosisStats _diagnosisService;

  late final String _currentUserId;

  bool? _isMute;
  List<Question>? questionList;
  int? currentQuestionIndex;
  Map<String, dynamic>? _diagnosis;
  String? _currentTitle;

  @override
  initState() {
    super.initState();
    _profileService = FirebaseProfileStorage();
    _diagnosisService = FirebaseDiagnosisStats();

    final currentUser = AuthService.firebase().currentUser!;

    setState(() {
      _currentUserId = currentUser.id;
    });
  
    _diagnosis = {};
    //"category" : { rawScore, subScaledScore, percentileScore}

    currentQuestionIndex = 0;
    
    if(mounted) _loadMuteStatusAndQuestions();
  }

  Future<void> _loadMuteStatusAndQuestions() async {
    _isMute = await _fetchMuteStatusFromFirebase() ?? true; 
    Future.delayed(const Duration(milliseconds: 10)); 

    setState(() {
      questionList = getQuestions(_isMute); 
      _currentTitle = "Restricted Repetitive Behavior"; 
    });
  }

  Future<bool?> _fetchMuteStatusFromFirebase() async {
    return await _profileService.isUserMute(ownerUserId: _currentUserId);
  }

  void _updateTitle(String key) {
    setState(() {
      _currentTitle = key.replaceAll("_", " "); 
    });
  }

  String getCurrentKey() {
    int questionCount = 0;

    for (var entry in questions.entries) {
      final key = entry.key;
      final value = entry.value; 

      if (currentQuestionIndex! < questionCount + value.length) {
        return key;
      }

      questionCount += value.length;
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BoldText(
          text: _currentTitle ?? "Autism Companion",
          size: 15,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LightText(
              text: "Question ${currentQuestionIndex! + 1}/${questionList?.length.toString()}", 
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 20),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: const Offset(0, 0),  
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: _questionWidget(key: ValueKey<int>(currentQuestionIndex!)),
            ),
            const SizedBox(height: 50),
            _answerList(),
          ],

        ),
      ),
    );
  }

  Widget _questionWidget({required Key key}) {
    return SizedBox(
      height: 220,
      child: CustomContainer(
        fileName: "shape2.png",
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: LightText(
            text: questionList != null ? questionList!.isNotEmpty ? questionList![currentQuestionIndex!].questionText : "Loading...": "Loading...",
          ),
        ),
      ),
    );
  }

  _answerList() {
    return Column(
      children: [
        _answerButton("Not at all like the individual", 0),
        _answerButton("Not much like the individual", 1),
        _answerButton("Somewhat like the individual", 2),
        _answerButton("Very much like the individual", 3),
      ],
    );
  }

  Widget _answerButton(String text, int optionIndex) {
    return CustomContainer(
      margin: 5,
      child: ElevatedButton(
        onPressed: () => _recordUserSelection(optionIndex),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
        ), 
        child: Text(text),
      ),
    );
  }

  _recordUserSelection(int selectedOption) {
    String key = getCurrentKey();
    
    if (_diagnosis!.containsKey(key)) {
       _diagnosis![key][rawScoreFieldName] += selectedOption;
    } else {
      _diagnosis![key] = {
        rawScoreFieldName: selectedOption,
        subScaledScoreFieldName: 0,
        percentileScoreFieldName: 0
      };
    }

    //log("Current Raw Score for $key: ${_diagnosis![key][rawScoreFieldName]}");

    if (currentQuestionIndex! < questionList!.length - 1) {
      setState(() {
        currentQuestionIndex = (currentQuestionIndex!) + 1;
        _updateTitle(key);
      });
    } 
    if (currentQuestionIndex! == questionList!.length - 1) {
      _calculateDiagnosisScore(); 
    }
  }

  void _calculateDiagnosisScore() async {
    try {
      _diagnosisService.uploadDiagnosisData(
        ownerUserId: _currentUserId, 
        diagnosisStats: _diagnosis!, 
      );  
      Future.delayed(const Duration(seconds: 1), () {
        if(mounted) {
          Navigator.of(context).pushNamed(
            diagnosisResultRoute, 
          );
        }
      });
    } catch(error) {
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error uploading assessment score')),
      );
    }
  }

}