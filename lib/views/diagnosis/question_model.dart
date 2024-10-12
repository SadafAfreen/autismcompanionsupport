import 'package:autismcompanionsupport/constants/questions.dart';

class Question {
  final String questionText;
  final int option_1 = 0;
  final int option_2 = 0;
  final int option_3 = 0;
  final int option_4 = 0;

  Question(this.questionText);
}

List<Question> getQuestions(int isMute) {
  List<Question> list = [];

  questions.forEach((key, value) {
    if(isMute == 1 || isMute == 0) {
      for (var question in value) {
        list.add(Question(question));
      }
    }
  });

  return list;
}