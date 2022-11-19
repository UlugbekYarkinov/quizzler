import 'dart:math';

import 'package:flutter/material.dart';
import 'quiz_brain.dart';

QuestionBrain questionBrain = QuestionBrain();

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int scoreCounter = 0;
  final Icon rightIcon = const Icon(
    Icons.check,
    color: Colors.green,
    size: 30.0,
  );
  final Icon wrongIcon = const Icon(
    Icons.close,
    color: Colors.red,
    size: 30.0,
  );

  void checkAnswer(bool pickedAnswer) {
    bool questionAnswer = questionBrain.getQuestionAnswer();

    setState(() { //TODO: add an alert message and dynamic bear
      if(questionBrain.isFinished()) {
        scoreKeeper = [];
        scoreCounter = 0;
      } else {
        if(questionAnswer == pickedAnswer) {
          scoreCounter++;
          scoreKeeper.add(rightIcon);
        } else {
          scoreKeeper.add(wrongIcon);
        }
      }
      questionBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            'Question ${questionBrain.getQuestionNumber() + 1}/${questionBrain.getNumberOfQuestions()}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        )),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              questionBrain.getQuestionText(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton(
                  onPressed: () {
                    checkAnswer(true);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'True',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton(
                  onPressed: () {
                    checkAnswer(false);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'False',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: scoreKeeper,
          ),
        )
      ],
    );
  }
}
