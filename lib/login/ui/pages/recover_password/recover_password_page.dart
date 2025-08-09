import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/login/class/recover_request.dart';
import 'package:titan/login/providers/sign_up_provider.dart';
import 'package:titan/login/router.dart';
import 'package:titan/login/ui/components/login_field.dart';
import 'package:titan/login/ui/auth_page.dart';
import 'package:titan/login/ui/components/sign_in_up_bar.dart';
import 'package:titan/login/ui/components/password_strength.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:titan/l10n/app_localizations.dart';

class RecoverPasswordPage extends HookConsumerWidget {
  const RecoverPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authTokenNotifier = ref.watch(authTokenProvider.notifier);
    final signUpNotifier = ref.watch(signUpProvider.notifier);
    final activationCode = useTextEditingController();
    final password = useTextEditingController();
    final currentPage = useState(0);
    final lastIndex = useState(0);
    final pageController = usePageController();
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    List<GlobalKey<FormState>> formKeys = [
      GlobalKey<FormState>(),
      GlobalKey<FormState>(),
    ];

    List<Widget> steps = [
      CreateAccountField(
        controller: activationCode,
        label: AppLocalizations.of(context)!.loginActivationCode,
        index: 1,
        pageController: pageController,
        currentPage: currentPage,
        formKey: formKeys[0],
      ),
      Column(
        children: [
          CreateAccountField(
            controller: password,
            label: AppLocalizations.of(context)!.loginNewPassword,
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
      ),
      SignInUpBar(
        label: AppLocalizations.of(context)!.loginEndResetPassword,
        isLoading: false,
        onPressed: () async {
          final resetedPasswordMsg = AppLocalizations.of(
            context,
          )!.loginResetedPassword;
          final invalidTokenMsg = AppLocalizations.of(
            context,
          )!.loginInvalidToken;
          if (password.text.isNotEmpty && activationCode.text.isNotEmpty) {
            RecoverRequest recoverRequest = RecoverRequest(
              resetToken: activationCode.text.trim(),
              newPassword: password.text,
            );
            final value = await signUpNotifier.resetPassword(recoverRequest);
            if (value) {
              displayToastWithContext(TypeMsg.msg, resetedPasswordMsg);
              authTokenNotifier.deleteToken();
              QR.to(LoginRouter.root);
            } else {
              displayToastWithContext(TypeMsg.error, invalidTokenMsg);
            }
          } else {
            displayToastWithContext(
              TypeMsg.error,
              AppLocalizations.of(context)!.loginFillAllFields,
            );
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
                  AppLocalizations.of(context)!.loginResetPasswordTitle,
                  style: GoogleFonts.elMessiri(
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
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
                      children: steps,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      currentPage.value != 0
                          ? GestureDetector(
                              onTap: (() {
                                FocusScope.of(
                                  context,
                                ).requestFocus(FocusNode());
                                currentPage.value--;
                                lastIndex.value = currentPage.value;
                                pageController.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.decelerate,
                                );
                              }),
                              child: const HeroIcon(
                                HeroIcons.arrowLeft,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          : Container(),
                      currentPage.value != len - 1
                          ? GestureDetector(
                              onTap: (() {
                                if (currentPage.value == steps.length - 1 ||
                                    formKeys[lastIndex.value].currentState!
                                        .validate()) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(FocusNode());
                                  pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.decelerate,
                                  );
                                  currentPage.value++;
                                  lastIndex.value = currentPage.value;
                                }
                              }),
                              child: const HeroIcon(
                                HeroIcons.arrowRight,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
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
                      dotHeight: 12,
                    ),
                    onDotClicked: (index) {
                      if (index < lastIndex.value ||
                          index == steps.length - 1 ||
                          formKeys[lastIndex.value].currentState!.validate()) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        currentPage.value = index;
                        lastIndex.value = index;
                        pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
