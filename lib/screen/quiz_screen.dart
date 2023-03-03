import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/questions_model.dart';
import 'package:quiz_app/screen/app_cubit.dart';
import 'package:quiz_app/screen/score_screen.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({Key? key}) : super(key: key);

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
                          builder: (context) => ScoreScreen(),
                        ),
                            (route) => false);
                  }
                  myObj.pageController.nextPage(
                    duration: Duration(milliseconds: 360),
                    curve: Curves.ease,
                  );
                },
                child: Text(
                  'skip'.toUpperCase(),
                  style: TextStyle(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF3F4768),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Stack(
                          children: [
                            LayoutBuilder(
                              builder: (context, constraints) => Container(
                                width: constraints.maxWidth * 0.4,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF46A0AE),
                                      const Color(0xFF00FFCB),
                                      Colors.blueAccent.withOpacity(.6),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(' 60 sec'),
                                    SvgPicture.asset('assets/icons/clock.svg'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text.rich(
                      TextSpan(
                        text: 'Question ${myObj.currentQuestion + 1}/',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 30,
                        ),
                        children: [
                          TextSpan(
                            text: '${questions.length}',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 5),
                    Expanded(
                      child: PageView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        onPageChanged: (value) {
                          myObj.changeCurrentTextOfPage(value);
                          myObj.isLastOrNot(value-1);
                          if (myObj.isLast) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScoreScreen(),
                                ),
                                (route) => false);
                          }
                        },
                        controller: myObj.pageController,
                        itemCount: questions.length + 1,
                        itemBuilder: (context, index) {
                          print(index);
                          return index == questions.length
                              ? Container()
                              : Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        questions[index].question,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      ),
                                      SizedBox(height: 10),
                                      ...List.generate(
                                        questions[index].options.length,
                                        (innerIndex) => InkWell(
                                          onTap: () {
                                            print(innerIndex);
                                            myObj.checkAns(innerIndex, index);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 20),
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${innerIndex + 1} - ${questions[index].options[innerIndex]}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey[900]),
                                                ),
                                                myObj.isAns
                                                    ? Container(
                                                        height: 26,
                                                        width: 26,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: myObj.changeIconeAfterAns(
                                                                      innerIndex,
                                                                      index)
                                                                  ? Colors.green
                                                                  : Colors.red),
                                                        ),
                                                        child: myObj
                                                                .changeIconeAfterAns(
                                                                    innerIndex,
                                                                    index)
                                                            ? Icon(
                                                                Icons.done,
                                                                color: Colors
                                                                    .green,
                                                              )
                                                            : Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
