import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:quiz_app/questions_model.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());



  static AppCubit get(context) => BlocProvider.of(context);
  PageController pageController = PageController(initialPage: 0);
  List sample_data = [
    {
      "id": 1,
      "question":
          "Flutter is an open-source UI software development kit created by ______",
      "options": ['Apple', 'Google', 'Facebook', 'Microsoft'],
      "answer_index": 1,
    },
    {
      "id": 2,
      "question": "When google release Flutter.",
      "options": ['Jun 2017', 'Jun 2017', 'May 2017', 'May 2018'],
      "answer_index": 2,
    },
    {
      "id": 3,
      "question": "A memory location that holds a single letter or number.",
      "options": ['Double', 'Int', 'Char', 'Word'],
      "answer_index": 2,
    },
    {
      "id": 4,
      "question": "What command do you use to output data to the screen?",
      "options": ['Cin', 'Count>>', 'Cout', 'Output>>'],
      "answer_index": 2,
    },
  ];
  List<QuestionModel> question = [];
  int currentQuestion = 0;
  int score = 0;
  bool isAns = false;
  bool isCorrectAns = false;
  bool isLast = false;

  void getQuestion() {
    score = 0;
    question = sample_data.map((e) {
      return QuestionModel(
        id: e['id'],
        question: e['question'],
        answer: e['answer_index'],
        options: e['options'],
      );
    }).toList();
  }

  void changeCurrentTextOfPage(int index) {
    currentQuestion = index;
    emit(ChangeCurrentPageInText());
  }

  void checkAns(int innerIndex, int index) {
    if (question[index].options[innerIndex] ==
        question[index].options[question[index].answer]) {
      score++;
      isAns = true;
      isCorrectAns = true;
      emit(DisplayIconOfAns());
      Future.delayed(Duration(seconds: 2)).then((value) {
        pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
        isAns = false;
        isCorrectAns = false;
      });
      isLastOrNot(index);
      emit(DisplayIconOfAns());
    } else {
      isAns = true;
      emit(DisplayIconOfAns());
      Future.delayed(Duration(seconds: 2)).then((value) {
        pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
        isAns = false;
      });
      isLastOrNot(index);
      emit(DisplayIconOfAns());
    }
  }

  void isLastOrNot(int index) {
    if (index == question.length - 1)
      isLast = true;
    else
      isLast = false;
  }

  bool changeIconeAfterAns(int innerIndex, int index) {
    if (question[index].options[innerIndex] ==
        question[index].options[question[index].answer]) {
      return true;
    } else {
      return false;
    }
  }

}
