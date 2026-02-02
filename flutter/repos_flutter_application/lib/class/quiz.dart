import 'package:flutter/material.dart';
import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import 'question.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  // int _hitung = 0;
  int _hitung = 10;
  final int _initValue = 10;
  late Timer _timer;

  final List<Question> _questions = [];
  int _question_no = 0;
  int _point=0;

  String formatTime(int hitung) {
      var hours = (hitung ~/ 3600).toString().padLeft(2, '0');
      var minutes = ((hitung % 3600) ~/ 60).toString().padLeft(2, '0');	
      var seconds = (hitung % 60).toString().padLeft(2, '0');
      return "$hours:$minutes:$seconds";
  }

  void checkAnswer(String answer) {
    setState(() {
      if (answer == _questions[_question_no].answer) {
        _point += 100;
      }
      if(_question_no==_questions.length-1) {
        endGame();
      }
      else
      {        
        _question_no++;
        _hitung=_initValue;
      }
    });
  }
  void endGame() {
    _timer.cancel();
    showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: Text('Score'),
                    content: Text('Your Score is $_point'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ));
  }


  void startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (_hitung == 0) {
          _hitung = _initValue;
          if(_question_no==_questions.length-1) {
            endGame();
          }
          else
          {        
            _question_no++;
            _hitung=_initValue;
          }
          // _timer.cancel();
          // showDialog<String>(
          //     context: context,
          //     builder: (BuildContext context) => AlertDialog(
          //           title: Text('Quiz'),
          //           content: Text('Quiz Ended'),
          //           actions: <Widget>[
          //             TextButton(
          //               onPressed: () => Navigator.pop(context, 'OK'),
          //               child: const Text('OK'),
          //             ),
          //           ],
          //         ));
        }
        else {
          _hitung--;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    _questions.add(Question("Not a member of Avenger ", 'Ironman','Spiderman', 'Thor', 'Hulk Hogan', 'Hulk Hogan'));
    _questions.add(Question("Not a member of Teletubbies", 'Dipsy', 'Patrick','Laalaa', 'Poo', 'Patrick'));
    _questions.add(Question("Not a member of justice league", 'batman', 'aquades','superman', 'flash', 'aquades'));
    _questions.add(Question("Not a member of BTS", 'Jungkook','Jimin', 'Gong Yoo', 'Suga', 'Gong Yoo'));
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _hitung = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 20.0,
              percent: 1 - (_hitung / _initValue),
              center: Text(formatTime(_hitung)),
              progressColor: Colors.red,
            ),
        // LinearPercentIndicator(
        //       center: Text(formatTime(_hitung)),
        //       width: MediaQuery.of(context).size.width,
        //       lineHeight: 20.0,
        //       percent: 1 - (_hitung / _initValue),
        //       backgroundColor: Colors.grey,
        //       progressColor: Colors.red,
        //     ),

        // Text(formatTime(_hitung),
        //     style: const TextStyle(
        //       fontSize: 24,
        //     )),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _timer.isActive ? _timer.cancel() : startTimer();
                });
              },
              child: Text(
                _timer.isActive ? "Stop" : "Start",
              ),
		        ),
            Text(_questions[_question_no].narration),
            TextButton(
        onPressed: () { 
          checkAnswer(_questions[_question_no].optionA);
        },
        child: Text("A. ${_questions[_question_no].optionA}")),
            TextButton(
        onPressed: () {  
          checkAnswer(_questions[_question_no].optionB);
        },
        child: Text("B. ${_questions[_question_no].optionB}")),
            TextButton(
        onPressed: () {  
          checkAnswer(_questions[_question_no].optionC);
        },
        child: Text("C. ${_questions[_question_no].optionC}")),
            TextButton(
        onPressed: () { 
          checkAnswer(_questions[_question_no].optionD);
        },
        child: Text("D. ${_questions[_question_no].optionD}")),
          ]
        )
      ), 
    );
  }
} 