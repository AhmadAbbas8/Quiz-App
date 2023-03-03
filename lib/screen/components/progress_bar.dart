import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
