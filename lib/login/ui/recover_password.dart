import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/drawer/providers/page_provider.dart';
import 'package:myecl/login/class/recover_request.dart';
import 'package:myecl/login/providers/sign_up_provider.dart';
import 'package:myecl/login/tools/constants.dart';
import 'package:myecl/login/tools/functions.dart';
import 'package:myecl/login/ui/login_field.dart';
import 'package:myecl/login/ui/sign_in_up_bar.dart';
import 'package:myecl/tools/functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RecoverPasswordPage extends HookConsumerWidget {
  final VoidCallback onActivationPressed;
  const RecoverPasswordPage({Key? key, required this.onActivationPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(pageProvider.notifier);
    final authTokenNotifier = ref.watch(authTokenProvider.notifier);
    final signUpNotifier = ref.watch(signUpProvider.notifier);
    final activationCode = useTextEditingController();
    final password = useTextEditingController();
    final currentPage = useState(0);
    final pageController = usePageController();
    void displayLoginToastWithContext(TypeMsg type, String msg) {
      displayLoginToast(context, type, msg);
    }

    List<Widget> steps = [
      CreateAccountField(
        controller: activationCode,
        label: LoginTextConstants.activationCode,
        index: 1,
        pageController: pageController,
        currentPage: currentPage,
      ),
      CreateAccountField(
        controller: password,
        label: LoginTextConstants.newPassword,
        index: 2,
        pageController: pageController,
        currentPage: currentPage,
        keyboardType: TextInputType.visiblePassword,
      ),
      SignUpBar(
        label: LoginTextConstants.endResetPassword,
        isLoading: false,
        onPressed: () async {
          if (password.text.isNotEmpty && activationCode.text.isNotEmpty) {
            RecoverRequest recoverRequest = RecoverRequest(
              resetToken: activationCode.text,
              newPassword: password.text,
            );
            final value = await signUpNotifier.resetPassword(recoverRequest);
            if (value) {
              displayLoginToastWithContext(
                  TypeMsg.msg, LoginTextConstants.resetedPassword);
              pageNotifier.setPage(ModuleType.home);
              authTokenNotifier.deleteToken();
              onActivationPressed();
            } else {
              displayLoginToastWithContext(
                  TypeMsg.error, LoginTextConstants.errorResetPassword);
            }
          } else {
            displayLoginToastWithContext(
                TypeMsg.error, LoginTextConstants.fillAllFields);
          }
        },
      ),
    ];
    final len = steps.length;

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: onActivationPressed,
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
                LoginTextConstants.createAccountTitle,
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
                    currentPage.value != 0
                        ? GestureDetector(
                            onTap: (() {
                              pageController.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.decelerate);
                              currentPage.value--;
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
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.decelerate);
                              currentPage.value++;
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
                      dotColor: LoginColorConstants.background,
                      activeDotColor: Colors.white,
                      dotWidth: 12,
                      dotHeight: 12),
                  onDotClicked: (index) {
                    pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.decelerate);
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
    );
  }
}
