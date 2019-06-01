import 'package:quiz/utils/question.dart';

class Quiz{
  List<Question> _questions;
  int _currentQuestionIndex = -1;
  int _score = 0;
  Quiz(this._questions){
    //开启本句将会使问题顺序打乱
    //_questions.shuffle();
  }

  List<Question> get questions => _questions;
  int get length => questions.length;
  int get questionNuber => _currentQuestionIndex+1;
  int get score => _score;

  Question get nextQuestion {
    _currentQuestionIndex++;
    if(_currentQuestionIndex >= length) return null;
    return _questions[_currentQuestionIndex];
  }

  void answer(bool isCorrect){
    if(isCorrect) _score++;
  }
}
