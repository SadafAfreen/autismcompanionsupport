import 'package:autismcompanionsupport/constants/questions.dart';

class Question {
  final String questionText;

  Question(this.questionText);
}

List<Question> getQuestions(bool? isMute) {
  List<Question> list = [];

  questions.forEach((key, value) {
    if (isMute == false || 
        (isMute == true && (key != "Congnitive Style" && key != "Maladaptive Speech"))) {
      for (var question in value) {
        list.add(Question(question));
      }
    }
  });

  return list;
}