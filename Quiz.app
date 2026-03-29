import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int currentQuestion = 0;
  int score = 0;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Berlin', 'Madrid', 'Paris', 'Rome'],
      'answer': 'Paris'
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Earth', 'Mars', 'Jupiter', 'Venus'],
      'answer': 'Mars'
    },
    {
      'question': 'Who wrote Hamlet?',
      'options': [
        'Charles Dickens',
        'William Shakespeare',
        'Mark Twain',
        'Leo Tolstoy'
      ],
      'answer': 'William Shakespeare'
    },
  ];

  void checkAnswer(String selected) {
    if (selected == questions[currentQuestion]['answer']) {
      score++;
    }
    setState(() {
      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Quiz Finished"),
            content: Text("Your score is $score/${questions.length}"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    currentQuestion = 0;
                    score = 0;
                  });
                },
                child: Text("Restart"),
              )
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion]['question'] as String;
    final options = questions[currentQuestion]['options'] as List<String>;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Quiz App")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                question,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ...options.map((option) {
                return ElevatedButton(
                  onPressed: () => checkAnswer(option),
                  child: Text(option),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
