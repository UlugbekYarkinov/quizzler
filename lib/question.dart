class Question {
  late String _questionText;
  late bool _questionAnswer;

  Question({required String text, required bool answer}) {
    _questionText = text;
    _questionAnswer = answer;
  }

  String getQuestionText() {
    return _questionText;
  }
  bool getQuestionAnswer() {
    return _questionAnswer;
  }
}