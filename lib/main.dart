import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  final _questions = [
    {
      'question': 'What is the largest ocean on Earth?',
      'options': ['Atlantic', 'Indian', 'Pacific', 'Arctic'],
      'answer': 'Pacific'
    },
    {
      'question': 'Which country invented pizza?',
      'options': ['France', 'Italy', 'Greece', 'Turkey'],
      'answer': 'Italy'
    },
    {
      'question': 'How many legs does a spider have?',
      'options': ['6', '8', '10', '12'],
      'answer': '8'
    },
    {
      'question': 'Which gas do plants use for photosynthesis?',
      'options': ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'],
      'answer': 'Carbon Dioxide'
    },
    {
      'question': 'Who painted the Mona Lisa?',
      'options': ['Van Gogh', 'Michelangelo', 'Da Vinci', 'Picasso'],
      'answer': 'Da Vinci'
    },
    {
      'question': 'What is the smallest prime number?',
      'options': ['0', '1', '2', '3'],
      'answer': '2'
    },
    {
      'question': 'Which animal is known as the King of the Jungle?',
      'options': ['Tiger', 'Elephant', 'Leopard', 'Lion'],
      'answer': 'Lion'
    },
    {
      'question': 'How many continents are there on Earth?',
      'options': ['5', '6', '7', '8'],
      'answer': '7'
    },
    {
      'question': 'What planet is closest to the sun?',
      'options': ['Earth', 'Venus', 'Mercury', 'Mars'],
      'answer': 'Mercury'
    },
    {
      'question': 'Who discovered gravity?',
      'options': ['Newton', 'Einstein', 'Tesla', 'Galileo'],
      'answer': 'Newton'
    },
  ];


  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizFinished = false;
  int _timeLeft = 15;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timeLeft = 15;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _nextQuestion();
        }
      });
    });
  }

  void _answerQuestion(String selectedAnswer) {
    if (!_quizFinished) {
      if (selectedAnswer == _questions[_currentQuestionIndex]['answer']) {
        _score++;
      }
      _nextQuestion();
    }
  }

  void _nextQuestion() {
    _timer?.cancel();
    setState(() {
      _currentQuestionIndex++;
      if (_currentQuestionIndex >= _questions.length) {
        _quizFinished = true;
      } else {
        _startTimer();
      }
    });
  }

  void _resetQuiz() {
    _timer?.cancel();
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _quizFinished = false;
      _startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurple.shade50,
        appBar: AppBar(
          title: Text('Quiz App'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _quizFinished
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _score == _questions.length
                      ? Icons.emoji_events       // perfect score
                      : _score >= _questions.length / 2
                      ? Icons.thumb_up       // decent score
                      : Icons.sentiment_dissatisfied, // low score
                  size: 80,
                  color: _score == _questions.length
                      ? Colors.amber
                      : _score >= _questions.length / 2
                      ? Colors.green
                      : Colors.redAccent,
                ),

                SizedBox(height: 20),
                Text(
                  'Quiz Completed!\nYour Score: $_score / ${_questions.length}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _resetQuiz,
                  icon: Icon(Icons.replay),
                  label: Text('Restart Quiz'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade100,
                  ),
                )
              ],
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(
                value: _timeLeft / 15,
                backgroundColor: Colors.grey[300],
                color: Colors.deepPurple,
              ),
              SizedBox(height: 10),
              Text(
                'Time Left: $_timeLeft seconds',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 16, color: Colors.deepPurple),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        _questions[_currentQuestionIndex]['question'] as String,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 20),
                      ...(_questions[_currentQuestionIndex]['options'] as List<String>)
                          .map(
                            (option) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: ElevatedButton(
                            onPressed: () => _answerQuestion(option),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: Text(option, style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      )
                          .toList(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Score: $_score',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
