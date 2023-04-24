import 'dart:developer';

import 'package:chatti_v2/features/auth/application/auth_provider.dart';
import 'package:chatti_v2/global_providers.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../home/presentation/view/home_view.dart';

class LoginView extends ConsumerStatefulWidget {
  static const routeName = 'login';
  static const routeLocation = '/$routeName';

  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends ConsumerState<LoginView> {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  bool _isValidated = false;
  bool get isValidated => _isValidated;
  final TextEditingController _passwordTEC = TextEditingController();

  final TextEditingController _emailTEC = TextEditingController();

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
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(),

          buildTextForms(),
          // buildPageView(),
          // buildDescriptionCard(),
          // pageIndicator(),
          // buildNextandBackButton(),
          const SizedBox(
            height: AppSize.s50,
          ),
          buildSignInButton(),
          const SizedBox(
            height: AppSize.s20,
          ),
          Center(
              child: Text(
            "OR",
            style: getExtraBoldStyle(
                fontSize: FontSize.s20, color: AppColors.greYest),
          )),
          const SizedBox(
            height: AppSize.s20,
          ),
          buildGoogleButton()
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Login",
          style: getExtraBoldStyle(fontSize: FontSize.s40),
        ),
        Text("Use your Google to Sign In!",
            style:
                getLightStyle(fontSize: FontSize.s16, color: AppColors.greYest))
      ],
    );
  }

  void onChanged(String? value) {
    _isValidated = _signUpFormKey.currentState?.validate() ?? false;
  }

  Widget buildTextForms() {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextFormField(
            validator: FormValidators.validatePhoneNumber,
            onChanged: onChanged,
            textInputAction: TextInputAction.next,
            isNumber: true,
            textEditingController: _emailTEC,
            labelText: "Email",
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          AppTextFormField(
            validator: FormValidators.validateEmail,
            onChanged: onChanged,
            textInputAction: TextInputAction.done,
            textEditingController: _passwordTEC,
            labelText: "Password",
          ),
        ],
      ),
    );
  }

  Widget buildSignInButton() {
    return SizedBox(
      height: AppSize.s40,
      width: double.infinity,
      child: AppElevatedButton.text(
        onPressed: () async {
          try {
            final authSuccess = await ref
                .watch(authNotifierProvider.notifier)
                .emailSignIn(_emailTEC.value.text, _passwordTEC.value.text);
            if (!mounted) return;
            if (authSuccess) {
              context.go(HomeView.routeLocation);
            } else {
              ref.read(snackBarProvider).show(
                  context: context,
                  text: "Login Fail",
                  actionText: "Dismiss",
                  actionOnPressed: () {});
            }
          } catch (e) {}

          // if (!mounted) return;
          // if (viewModel.finalStatus == FirebaseAuthStatus.authenticated) {
          //   context.go(HomeView.routeName);
          // } else {
          //   locator<SnackBarService>().show(
          //       context: context,
          //       text: "Login Fail",
          //       actionText: "Dismiss",
          //       actionOnPressed: () {});
          // }
        },
        text: "Sign In",
        textColor: AppColors.black,
      ),
    );
  }

  Widget buildGoogleButton() {
    return SizedBox(
      height: AppSize.s40,
      width: double.infinity,
      child: AppElevatedButton.icon(
        onPressed: () async {
          try {
            final bool authSuccess =
                await ref.read(authNotifierProvider.notifier).googleLogIn();
            // final authState = ref.watch(authNotifierProvider.notifier).state;
            if (!mounted) return;
            if (authSuccess) {
              context.go(HomeView.routeLocation);
            } else {
              ref.read(snackBarProvider).show(
                  context: context,
                  text: "Login Fail",
                  actionText: "Dismiss",
                  actionOnPressed: () {});
            }
          } catch (e) {
            log(e.toString());
            ref.read(snackBarProvider).show(
                context: context,
                text: "Login Fail",
                actionText: "Dismiss",
                actionOnPressed: () {});
          }
        },
        text: "Google Sign In",
        textColor: AppColors.black,
        icon: CircleAvatar(
            backgroundColor: AppColors.white,
            child: Image.asset(
              AppAssets.googleIcon,
              height: AppSize.s30,
              width: AppSize.s30,
              fit: BoxFit.contain,
            )),
      ),
    );
  }
}
