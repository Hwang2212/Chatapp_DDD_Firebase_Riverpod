import 'dart:developer';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../login/login.dart';

class OnboardingModel {
  final String imageString;
  final String description;

  OnboardingModel({required this.imageString, required this.description});
}

List<OnboardingModel> contentList = [
  OnboardingModel(
      imageString: AppAssets.onboardingString1,
      description: "This picture is Chat App"),
  OnboardingModel(
      imageString: AppAssets.onboardingString2,
      description: "This Chat App is Chatti is Chat App"),
  OnboardingModel(
      imageString: AppAssets.onboardingString3,
      description: "This picture is Chat App"),
];
List<String> introAssets = [
  AppAssets.onboardingString1,
  AppAssets.onboardingString2,
  AppAssets.onboardingString3,
];

class OnboardingView extends ConsumerStatefulWidget {
  static const routeName = 'onboarding';
  static const routeLocation = '/$routeName';

  const OnboardingView({super.key});

  @override
  OnboardingViewState createState() => OnboardingViewState();
}

class OnboardingViewState extends ConsumerState<OnboardingView> {
  final introScreenController = PageController();
  final descriptionController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const BackgroundWidget(),
        Positioned.fill(top: AppPadding.p20, child: buildMainContent()),
      ]),
    );
  }

  Widget buildMainContent() {
    return Padding(
      padding: AppPadding.contentPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildPageView(),
          buildDescriptionCard(),
          pageIndicator(),
          buildNextandBackButton(),
          buildSignInButton()
        ],
      ),
    );
  }

  Widget buildPageView() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Chatti!",
            // textAlign: TextAlign.center,
            style: getBoldStyle(fontSize: FontSize.s40),
          ),
          SizedBox(
            height: ScreenUtils.screenHeight * 0.05,
          ),
          SizedBox(
            height: ScreenUtils.screenHeight * 0.4,
            width: ScreenUtils.screenWidth * 0.8,
            child: PageView(
              controller: introScreenController,
              onPageChanged: (value) {
                setState(() {
                  isLastPage = value == 2;
                });
                log(value.toString());

                descriptionController.animateToPage(value,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              children: [
                ...contentList.map((e) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      e.imageString,
                      fit: BoxFit.fill,
                    ),
                  );
                }).toList(),
              ],
            ),
          )
        ]);
  }

  Widget buildDescriptionCard() {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p15),
      width: ScreenUtils.screenWidth,
      height: ScreenUtils.screenHeight * 0.2,
      child: PageView(
        controller: descriptionController,
        onPageChanged: (value) {
          setState(() {
            isLastPage = value == 2;
          });
          introScreenController.animateToPage(value,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        },
        children: [
          ...contentList.map((e) {
            return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p20, horizontal: AppPadding.p10),
                child: Text(
                  e.description,
                  style: getRegularStyle(
                      fontSize: FontSize.s24, color: AppColors.orange),
                ));
          }).toList(),
        ],
      ),
    );
  }

  Widget buildNextandBackButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppElevatedButton.circular(
            backgroundColor: AppColors.white,
            onPressed: () {
              introScreenController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
              descriptionController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            },
            radius: 20,
            child:
                const Icon(Icons.arrow_back_ios_new, color: AppColors.orange)),
        RotatedBox(
          quarterTurns: 2,
          child: AppElevatedButton.circular(
              backgroundColor: AppColors.white,
              onPressed: () {
                introScreenController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
                descriptionController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              radius: 20,
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.orange,
              )),
        ),
      ],
    );
  }

  Widget pageIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: ScreenUtils.screenHeight * 0.01),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              // color: colorScheme.primary,
            ),
            height: ScreenUtils.screenHeight * 0.04,
            width: ScreenUtils.screenWidth * 0.3,
            alignment: Alignment.center,
            child: SmoothPageIndicator(
              controller: introScreenController,
              count: introAssets.length,
              onDotClicked: (index) {
                introScreenController.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
                descriptionController.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              effect: WormEffect(
                activeDotColor: AppColors.orange,
                spacing: 8.0,
                dotColor: AppColors.darkBlue,
                dotWidth: ScreenUtils.screenWidth * 0.03,
                dotHeight: ScreenUtils.screenWidth * 0.03,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignInButton() {
    return AnimatedOpacity(
        opacity: isLastPage ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: AppElevatedButton.text(
          onPressed: () {
            context.go(LoginView.routeLocation);
          },
          text: "Sign In",
          textColor: AppColors.darkBlue,
        ));
  }
}
