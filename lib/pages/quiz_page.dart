import 'package:flutter/material.dart';
import '../utils/question.dart';
import '../utils/quiz.dart';
import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/correct_wrong.dart';
import '../pages/score_page.dart';


class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Question currentQuestion;
  Quiz quiz=new Quiz([
    new Question("开发本APP的人很帅", true),
    new Question("开发本APP的人亚索玩的很溜", true),
    new Question("这个问题的答案是正确的", true),
    new Question("上个问题的答案是错误的", false)
  ]);

  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible=false;


  @override
  void initState(){
    super.initState();
    currentQuestion =quiz.nextQuestion;
    questionText=currentQuestion.question;
    questionNumber=quiz.questionNuber;

  }

  void handleAnswer(bool answer){
    isCorrect=(currentQuestion.answer==answer);
    quiz.answer(isCorrect);
    this.setState(() {
     overlayShouldBeVisible=true; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          // This is our main page
          children: <Widget>[
            new AnswerButton(true, () => handleAnswer(true)),//true button
            new QuestionText(questionText,questionNumber),
            new AnswerButton(false, () => handleAnswer(false)),
          ],
        ),
        overlayShouldBeVisible==true?new CorrectWrongOverlay(
          isCorrect,
          (){
            if(quiz.length == questionNumber){
              Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) =>new ScorePage(quiz.score, quiz.length)),(Route route)=>route==null);
            }

             currentQuestion =quiz.nextQuestion;
            this.setState((){
              overlayShouldBeVisible=false;
              questionText=currentQuestion.question;
              questionNumber=quiz.questionNuber;
            });
          }
          ):new Container()
      ],
    );
  }
}
