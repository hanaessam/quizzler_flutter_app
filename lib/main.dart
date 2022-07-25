import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:quizzler/question.dart';

QuizBrain quizBrain = QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questionNumber = 0;
  List<Icon> scoreKeeper = [];
  void checkAnswer(bool userPickedAnswer) {
    bool correct = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
          buttons: [
            DialogButton(
              child: Text(
                "RESET",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'Quicksand',
                    color: Colors.white,
                  ),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.green,
              radius: BorderRadius.circular(15.0),
            ),
          ],
        ).show();

        quizBrain.reset();
        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correct) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            flex: 2,
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset('images/img.png'),
        )),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.grey.withOpacity(.25),
                border: Border.all(width: 2.5, color: Colors.grey.shade400)

              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    quizBrain.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {
                checkAnswer(true);
              },
              child: const Text('True',style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'Quicksand',
              ),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green.shade200.withOpacity(.5)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0), side: BorderSide(color: Colors.green,width:2.5 )
                )),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {
                checkAnswer(false);
              },
              child: const Text('False',style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'Quicksand',
              ),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade200.withOpacity(.5)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0), side: BorderSide(color: Colors.red,width:2.5 )
                )),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: scoreKeeper),
        ),
      ],
    );
  }
}

/*
question1: , false,
question3:  true,
*/
