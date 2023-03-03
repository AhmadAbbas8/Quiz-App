import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/questions_model.dart';
import 'package:quiz_app/screen/app_cubit.dart';
import 'package:quiz_app/screen/components/progress_bar.dart';
import 'package:quiz_app/screen/components/question_card.dart';
import 'package:quiz_app/screen/score_screen.dart';
import 'app_state.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<QuestionModel> questions = AppCubit.get(context).question;
        AppCubit myObj = AppCubit.get(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              MaterialButton(
                onPressed: () {
                  if (myObj.isLast) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScoreScreen(),
                        ),
                        (route) => false);
                  }
                  myObj.pageController.nextPage(
                    duration: const Duration(milliseconds: 360),
                    curve: Curves.ease,
                  );
                },
                child: Text(
                  'skip'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              // SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
              Image.asset("assets/icons/bg2.jpg", fit: BoxFit.fill),
              SafeArea(
                child: Column(
                  children: [
                    const ProgressBar(),
                    const SizedBox(height: 20),
                    Text.rich(
                      TextSpan(
                        text: 'Question ${myObj.currentQuestion + 1}/',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 30,
                        ),
                        children: [
                          TextSpan(
                            text: '${questions.length}',
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(thickness: 5),
                    Expanded(
                      child: PageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (value) {
                          myObj.changeCurrentTextOfPage(value);
                          myObj.isLastOrNot(value - 1);
                          if (myObj.isLast) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ScoreScreen(),
                                ),
                                (route) => false);
                          }
                        },
                        controller: myObj.pageController,
                        itemCount: questions.length + 1,
                        itemBuilder: (context, index) {
                          return index == questions.length
                              ? Container()
                              : QuestionCard(
                                  questions: questions,
                                  myObj: myObj,
                                  index: index,
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
