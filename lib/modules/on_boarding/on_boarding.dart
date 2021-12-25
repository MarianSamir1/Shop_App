import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/models/boarding_model.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/chash_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends StatelessWidget {
  var pageController = PageController();

  bool? isLast;

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onBoarding_2.json',
        title: 'Screen Title 1',
        body: 'Screen Body 1'),
    BoardingModel(
        image: 'assets/images/onBoarding_3.json',
        title: 'Screen Title 2',
        body: 'Screen Body 2'),
    BoardingModel(
        image: 'assets/images/onBoarding_1.json',
        title: 'Screen Title 3',
        body: 'Screen Body 3'),
  ];

  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void submit() {
      ChashHelper.saveData(key: 'onBoarding', value: true).then((value) {
        if (value) {
          navigateAndFinsh(context,const LoginScreen() );
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: const Text(
                'SKIP',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index) {
                if (index == boarding.length - 1) {
                  isLast = true;
                } else {
                  isLast = false;
                }
              },
              controller: pageController,
              itemBuilder: (context, index) =>
                  itemBoardingBuild(boarding[index]),
              itemCount: boarding.length,
            )),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                      expansionFactor: 4 //عرض المستطيل من جوا
                      ),
                ),
                const Spacer(),
                FloatingActionButton(
                    onPressed: () {
                      if (isLast == true) {
                        submit();
                      } else {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.easeOut);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget itemBoardingBuild(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Lottie.asset(model.image)),
          const SizedBox(
            height: 20,
          ),
          Text(
            model.title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            model.body,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      );
}
