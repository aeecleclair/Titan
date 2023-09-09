import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/login/class/recover_request.dart';
import 'package:myecl/login/providers/sign_up_provider.dart';
import 'package:myecl/login/router.dart';
import 'package:myecl/login/tools/constants.dart';
import 'package:myecl/login/ui/login_field.dart';
import 'package:myecl/login/ui/main_page.dart';
import 'package:myecl/login/ui/sign_in_up_bar.dart';
import 'package:myecl/settings/ui/pages/change_pass/password_strength.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RecoverPasswordPage extends HookConsumerWidget {
  const RecoverPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authTokenNotifier = ref.watch(authTokenProvider.notifier);
    final signUpNotifier = ref.watch(signUpProvider.notifier);
    final code = QR.params['code'] ?? '';
    final isCodeGiven = code != '';
    final activationCode = useTextEditingController(text: code.toString());
    final password = useTextEditingController();
    final passwordConfirmation = useTextEditingController();
    final lastIndex = useState(isCodeGiven ? 1 : 0);
    final currentPage = useState(isCodeGiven ? 1 : 0);
    final pageController = usePageController(initialPage: currentPage.value);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    List<GlobalKey<FormState>> formKeys = [
      GlobalKey<FormState>(),
      GlobalKey<FormState>(),
      GlobalKey<FormState>(),
    ];

    List<Widget> steps = [
      CreateAccountField(
        controller: activationCode,
        label: LoginTextConstants.activationCode,
        index: 1,
        pageController: pageController,
        currentPage: currentPage,
        formKey: formKeys[0],
      ),
      Column(
        children: [
          CreateAccountField(
            controller: password,
            label: LoginTextConstants.newPassword,
            index: 2,
            pageController: pageController,
            currentPage: currentPage,
            formKey: formKeys[1],
            keyboardType: TextInputType.visiblePassword,
          ),
          const Spacer(),
          PasswordStrength(
            newPassword: password,
            textColor: ColorConstants.background2,
          ),
          const Spacer(),
        ],
      ),Column(
          children: [
            CreateAccountField(
              controller: passwordConfirmation,
              label: LoginTextConstants.confirmPassword,
              index: 3,
              pageController: pageController,
              currentPage: currentPage,
              formKey: formKeys[2],
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value != password.text) {
                  return LoginTextConstants.passwordMustMatch;
                }
                return null;
              },
            ),
            const Spacer(),
            PasswordStrength(
              newPassword: passwordConfirmation,
              textColor: ColorConstants.background2,
            ),
            const Spacer(),
          ],
        ),
      SignInUpBar(
        label: LoginTextConstants.endResetPassword,
        isLoading: false,
        onPressed: () async {
          if (password.text.isNotEmpty &&
              activationCode.text.isNotEmpty &&
              passwordConfirmation.text.isNotEmpty &&
              password.text == passwordConfirmation.text) {
            RecoverRequest recoverRequest = RecoverRequest(
              resetToken: activationCode.text.trim(),
              newPassword: password.text,
            );
            final value = await signUpNotifier.resetPassword(recoverRequest);
            if (value) {
              displayToastWithContext(
                  TypeMsg.msg, LoginTextConstants.resetedPassword);
              authTokenNotifier.deleteToken();
              QR.to(LoginRouter.root);
            } else {
              displayToastWithContext(
                  TypeMsg.error, LoginTextConstants.invalidToken);
            }
          } else {
            displayToastWithContext(
                TypeMsg.error, LoginTextConstants.fillAllFields);
          }
        },
      ),
    ];
    final len = steps.length;

    return LoginTemplate(
      callback: (AnimationController controller) {
        if (!controller.isCompleted) {
          controller.forward();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  QR.to(LoginRouter.forgotPassword);
                },
                child: const HeroIcon(
                  HeroIcons.chevronLeft,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  LoginTextConstants.resetPasswordTitle,
                  style: GoogleFonts.elMessiri(
                      textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  const Spacer(),
                  Expanded(
                      flex: 4,
                      child: PageView(
                          scrollDirection: Axis.horizontal,
                          controller: pageController,
                          onPageChanged: (index) {
                            lastIndex.value = currentPage.value;
                            currentPage.value = index;
                          },
                          physics: const BouncingScrollPhysics(),
                          children: steps)),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      currentPage.value != (isCodeGiven ? 1 : 0)
                          ? GestureDetector(
                              onTap: (() {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                currentPage.value--;
                                lastIndex.value = currentPage.value;
                                pageController.previousPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.decelerate);
                              }),
                              child: const HeroIcon(
                                HeroIcons.arrowLeft,
                                color: Colors.white,
                                size: 30,
                              ))
                          : Container(),
                      currentPage.value != len - 1
                          ? GestureDetector(
                              onTap: (() {
                                if (currentPage.value == steps.length - 1 ||
                                    formKeys[lastIndex.value]
                                        .currentState!
                                        .validate()) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.decelerate);
                                  currentPage.value++;
                                  lastIndex.value = currentPage.value;
                                }
                              }),
                              child: const HeroIcon(
                                HeroIcons.arrowRight,
                                color: Colors.white,
                                size: 30,
                              ))
                          : Container(),
                    ],
                  ),
                  const Spacer(),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: len,
                    effect: const WormEffect(
                        dotColor: ColorConstants.background2,
                        activeDotColor: Colors.white,
                        dotWidth: 12,
                        dotHeight: 12),
                    onDotClicked: (index) {
                      if (index < lastIndex.value ||
                          index == steps.length - 1 ||
                          formKeys[lastIndex.value].currentState!.validate()) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        currentPage.value = index;
                        lastIndex.value = index;
                        pageController.animateToPage(index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.decelerate);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
