import 'package:autismcompanionsupport/constants/app_colors.dart';
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
  List<Question> questionList = getQuestions(0);
  int currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BoldText(
          text: "Restricted Repetitive Behavior", 
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
              text: "Question ${currentQuestionIndex + 1}/${questionList.length.toString()}", 
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 220,
              child: CustomContainer(
                fileName: "shape2.png",
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: LightText(
                    text: questionList[currentQuestionIndex].questionText,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            _answerList(),
          ],

        ),
      ),
    );
  }

  _answerList() {
    return Column(
      children: [
        _answerButton("Not at all like the individual"),
        _answerButton("Not much like the individual"),
        _answerButton("Somewhat like the individual"),
        _answerButton("Very much like the individual"),
      ],
    );
  }

  Widget _answerButton(String text) {
    return CustomContainer(
      //width: double.infinity,
      margin: 5,
      //height: 58,
      child: ElevatedButton(
        onPressed: _handleSelectedAnswer,
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
        ), 
        child: Text(text),
      ),
    );
  }

  _handleSelectedAnswer() {
    bool isLastQuestion = currentQuestionIndex == questionList.length - 1;
    if(!isLastQuestion) {
      setState(() => currentQuestionIndex++ );
    }
  }

}