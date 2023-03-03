import 'package:flutter/material.dart';
import 'package:quiz_app/questions_model.dart';
import 'package:quiz_app/screen/app_cubit.dart';

// ignore: must_be_immutable
class QuestionCard extends StatelessWidget {
  QuestionCard({
    super.key,
    required this.questions,
    required this.myObj,
    required this.index
  });

  final List<QuestionModel> questions;
  final AppCubit myObj;
  int index ;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 25, vertical: 10),
      padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            questions[index].question,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
          const SizedBox(height: 10),
          ...List.generate(
            questions[index].options.length,
                (innerIndex) => InkWell(
              onTap: () {
                myObj.checkAns(innerIndex, index);
              },
              child: buildOption(innerIndex),
            ),
          ),
        ],
      ),
    );
  }

  Container buildOption(int innerIndex) {
    return Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(20),
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
                        ? const Icon(
                      Icons.done,
                      color: Colors
                          .green,
                    )
                        : const Icon(
                      Icons.close,
                      color:
                      Colors.red,
                    ),
                  )
                      : Container(),
                ],
              ),
            );
  }
}