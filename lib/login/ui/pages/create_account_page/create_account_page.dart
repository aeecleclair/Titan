import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/login/class/create_account.dart';
import 'package:titan/login/providers/sign_up_provider.dart';
import 'package:titan/login/router.dart';
import 'package:titan/login/ui/components/login_field.dart';
import 'package:titan/login/ui/auth_page.dart';
import 'package:titan/login/ui/components/sign_in_up_bar.dart';
import 'package:titan/login/ui/components/password_strength.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:titan/user/class/floors.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:titan/l10n/app_localizations.dart';

class CreateAccountPage extends HookConsumerWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authTokenNotifier = ref.watch(authTokenProvider.notifier);
    final signUpNotifier = ref.watch(signUpProvider.notifier);
    final code = QR.params['code'] ?? '';
    final isCodeGiven = code != '';
    final activationCode = useTextEditingController(text: code.toString());
    final name = useTextEditingController();
    final password = useTextEditingController();
    final passwordConfirmation = useTextEditingController();
    final firstname = useTextEditingController();
    final nickname = useTextEditingController();
    final birthday = useTextEditingController();
    final phone = useTextEditingController();
    final promo = useTextEditingController();
    final lastIndex = useState(isCodeGiven ? 1 : 0);
    List<DropdownMenuItem> items = Floors.values
        .map(
          (e) => DropdownMenuItem(
            value: capitalize(e.toString().split('.').last),
            child: Text(capitalize(e.toString().split('.').last)),
          ),
        )
        .toList();

    final floor = useTextEditingController(text: items[0].value.toString());
    final currentPage = useState(isCodeGiven ? 1 : 0);
    final pageController = usePageController(initialPage: currentPage.value);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    List<GlobalKey<FormState>> formKeys = [
      GlobalKey<FormState>(),
      GlobalKey<FormState>(),
      GlobalKey<FormState>(),
      GlobalKey<FormState>(),
      GlobalKey<FormState>(),
      GlobalKey<FormState>(),
      GlobalKey<FormState>(),
      GlobalKey<FormState>(),
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
            label: AppLocalizations.of(context)!.loginPassword,
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
      Column(
        children: [
          CreateAccountField(
            controller: passwordConfirmation,
            label: AppLocalizations.of(context)!.loginConfirmPassword,
            index: 3,
            pageController: pageController,
            currentPage: currentPage,
            formKey: formKeys[2],
            keyboardType: TextInputType.visiblePassword,
            validator: (value) {
              if (value != password.text) {
                return AppLocalizations.of(context)!.loginPasswordMustMatch;
              }
              return null;
            },
          ),
          const Spacer(),
          PasswordStrength(
            newPassword: password,
            textColor: ColorConstants.background2,
          ),
          const Spacer(),
        ],
      ),
      CreateAccountField(
        controller: name,
        label: AppLocalizations.of(context)!.loginName,
        index: 4,
        pageController: pageController,
        currentPage: currentPage,
        formKey: formKeys[3],
        keyboardType: TextInputType.name,
        autofillHints: const [AutofillHints.familyName],
      ),
      CreateAccountField(
        controller: firstname,
        label: AppLocalizations.of(context)!.loginFirstname,
        index: 5,
        pageController: pageController,
        currentPage: currentPage,
        formKey: formKeys[4],
        keyboardType: TextInputType.name,
        autofillHints: const [AutofillHints.givenName],
      ),
      CreateAccountField(
        controller: nickname,
        label: AppLocalizations.of(context)!.loginNickname,
        index: 6,
        pageController: pageController,
        currentPage: currentPage,
        formKey: formKeys[5],
        keyboardType: TextInputType.name,
        canBeEmpty: true,
        hint: AppLocalizations.of(context)!.loginCanBeEmpty,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 9),
          AlignLeftText(
            AppLocalizations.of(context)!.loginBirthday,
            fontSize: 20,
            color: ColorConstants.background2,
          ),
          const SizedBox(height: 1),
          Form(
            key: formKeys[6],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: DateEntry(
              onTap: () {
                DateTime now = DateTime.now();
                getOnlyDayDate(
                  context,
                  birthday,
                  firstDate: DateTime(now.year - 110, now.month, now.day),
                  initialDate: DateTime(now.year - 21, now.month, now.day),
                  lastDate: DateTime.now(),
                );
              },
              label: AppLocalizations.of(context)!.loginBirthday,
              controller: birthday,
              color: Colors.white,
              enabledColor: ColorConstants.background2,
              errorColor: Colors.white,
            ),
          ),
        ],
      ),
      CreateAccountField(
        controller: phone,
        label: AppLocalizations.of(context)!.loginPhone,
        index: 8,
        pageController: pageController,
        currentPage: currentPage,
        formKey: formKeys[7],
        keyboardType: TextInputType.phone,
        autofillHints: const [AutofillHints.telephoneNumber],
        canBeEmpty: true,
        hint: AppLocalizations.of(context)!.loginCanBeEmpty,
      ),
      CreateAccountField(
        controller: promo,
        label: AppLocalizations.of(context)!.loginPromo,
        index: 9,
        pageController: pageController,
        currentPage: currentPage,
        formKey: formKeys[8],
        keyboardType: TextInputType.number,
        canBeEmpty: true,
        mustBeInt: true,
        hint: AppLocalizations.of(context)!.loginCanBeEmpty,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          AlignLeftText(
            AppLocalizations.of(context)!.loginFloor,
            fontSize: 20,
            color: ColorConstants.background2,
          ),
          const SizedBox(height: 8),
          AutofillGroup(
            child: DropdownButtonFormField(
              items: items,
              value: floor.text,
              onChanged: (value) {
                floor.text = value.toString();
              },
              dropdownColor: ColorConstants.background2,
              iconEnabledColor: Colors.grey.shade100.withValues(alpha: 0.8),
              style: const TextStyle(fontSize: 20, color: Colors.white),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                isDense: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorConstants.background2),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                errorStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      SignInUpBar(
        label: AppLocalizations.of(context)!.loginEndActivation,
        isLoading: false,
        onPressed: () async {
          if (name.text.isNotEmpty &&
              firstname.text.isNotEmpty &&
              birthday.text.isNotEmpty &&
              floor.text.isNotEmpty &&
              password.text.isNotEmpty &&
              activationCode.text.isNotEmpty &&
              passwordConfirmation.text.isNotEmpty &&
              password.text == passwordConfirmation.text) {
            CreateAccount finalCreateAccount = CreateAccount(
              name: name.text,
              firstname: firstname.text,
              nickname: nickname.text.isEmpty ? null : nickname.text,
              birthday: DateTime.parse(processDateBack(birthday.text)),
              phone: phone.text.isEmpty ? null : phone.text,
              promo: promo.text.isEmpty ? null : int.parse(promo.text),
              floor: floor.text,
              activationToken: activationCode.text.trim(),
              password: password.text,
            );
            final accountActivatedMsg = AppLocalizations.of(
              context,
            )!.loginAccountActivated;
            final accountNotActivatedMsg = AppLocalizations.of(
              context,
            )!.loginAccountNotActivated;
            try {
              final value = await signUpNotifier.activateUser(
                finalCreateAccount,
              );
              if (value) {
                displayToastWithContext(TypeMsg.msg, accountActivatedMsg);
                authTokenNotifier.deleteToken();
                QR.to(LoginRouter.root);
              } else {
                displayToastWithContext(TypeMsg.error, accountNotActivatedMsg);
              }
            } catch (e) {
              displayToastWithContext(TypeMsg.error, e.toString());
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
                  QR.to(LoginRouter.createAccount);
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
                  AppLocalizations.of(context)!.loginCreateAccountTitle,
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
                    flex: 6,
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      controller: pageController,
                      onPageChanged: (value) {
                        lastIndex.value = currentPage.value;
                        currentPage.value = value;
                      },
                      children: steps,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      currentPage.value != (isCodeGiven ? 1 : 0)
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
                                if (currentPage.value >= steps.length - 2 ||
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
                          currentPage.value >= steps.length - 2 ||
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
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
