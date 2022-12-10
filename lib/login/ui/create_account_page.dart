import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/login/class/create_account.dart';
import 'package:myecl/login/providers/sign_up_provider.dart';
import 'package:myecl/login/tools/constants.dart';
import 'package:myecl/login/ui/login_field.dart';
import 'package:myecl/login/ui/sign_in_up_bar.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CreateAccountPage extends HookConsumerWidget {
  final VoidCallback onActivationPressed;
  const CreateAccountPage({Key? key, required this.onActivationPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authTokenNotifier = ref.watch(authTokenProvider.notifier);
    final signUpNotifier = ref.watch(signUpProvider.notifier);
    final activationCode = useTextEditingController();
    final name = useTextEditingController();
    final password = useTextEditingController();
    final firstname = useTextEditingController();
    final username = useTextEditingController();
    final birthday = useTextEditingController();
    final promo = useTextEditingController();
    final phone = useTextEditingController();
    final lastIndex = useState(0);
    List<DropdownMenuItem> items = [
      "Adoma",
      "Exté",
      "T1",
      "T2",
      "T3",
      "T4",
      "T56",
      "U1",
      "U2",
      "U3",
      "U4",
      "U56",
      "V1",
      "V2",
      "V3",
      "V45",
      "V6",
      "X1",
      "X2",
      "X3",
      "X4",
      "X5",
      "X6",
    ]
        .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ))
        .toList();

    final floor = useTextEditingController(text: items[0].value.toString());
    final currentPage = useState(0);
    final pageController = usePageController();
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
      CreateAccountField(
        controller: password,
        label: LoginTextConstants.password,
        index: 2,
        pageController: pageController,
        currentPage: currentPage,
        formKey: formKeys[1],
        keyboardType: TextInputType.visiblePassword,
      ),
      CreateAccountField(
        controller: name,
        label: LoginTextConstants.name,
        index: 3,
        pageController: pageController,
        currentPage: currentPage,
        formKey: formKeys[2],
        keyboardType: TextInputType.name,
        autofillHints: const [AutofillHints.familyName],
      ),
      CreateAccountField(
        controller: firstname,
        label: LoginTextConstants.firstname,
        index: 4,
        pageController: pageController,
        currentPage: currentPage,
        formKey: formKeys[3],
        keyboardType: TextInputType.name,
        autofillHints: const [AutofillHints.givenName],
      ),
      CreateAccountField(
        controller: username,
        label: LoginTextConstants.username,
        index: 5,
        pageController: pageController,
        currentPage: currentPage,
        formKey: formKeys[4],
        keyboardType: TextInputType.name,
      ),
      Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const SizedBox(
          height: 9,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(LoginTextConstants.birthday,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorConstants.background2,
              )),
        ),
        GestureDetector(
          onTap: () {
            _selectDate(context, birthday);
          },
          child: AbsorbPointer(
            child: Form(
              key: formKeys[5],
              child: TextFormField(
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                controller: birthday,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                    suffix: HeroIcon(HeroIcons.calendar,
                        color: Colors.white, size: 30),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorConstants.background2)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    errorStyle: TextStyle(color: Colors.white)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LoginTextConstants.emptyFieldError;
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      ]),
      CreateAccountField(
        controller: promo,
        label: LoginTextConstants.promo,
        index: 7,
        pageController: pageController,
        currentPage: currentPage,
        formKey: formKeys[6],
        keyboardType: TextInputType.number,
        hint: "20",
      ),
      CreateAccountField(
        controller: phone,
        label: LoginTextConstants.phone,
        index: 8,
        pageController: pageController,
        currentPage: currentPage,
        formKey: formKeys[7],
        keyboardType: TextInputType.phone,
        autofillHints: const [AutofillHints.telephoneNumber],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 9,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(LoginTextConstants.floor,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.background2,
                )),
          ),
          const SizedBox(
            height: 21,
          ),
          AutofillGroup(
            child: DropdownButtonFormField(
              items: items,
              value: floor.text,
              onChanged: (value) {
                floor.text = value.toString();
              },
              dropdownColor: ColorConstants.background2,
              iconEnabledColor: Colors.grey.shade100.withOpacity(.8),
              style: const TextStyle(fontSize: 20, color: Colors.white),
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  isDense: true,
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorConstants.background2)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.white,
                  )),
                  errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.white,
                  )),
                  errorStyle: TextStyle(color: Colors.white)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return LoginTextConstants.emptyFieldError;
                }
                return null;
              },
            ),
          ),
        ],
      ),
      SignUpBar(
        label: LoginTextConstants.endActivation,
        isLoading: false,
        onPressed: () async {
          if (name.text.isNotEmpty &&
              firstname.text.isNotEmpty &&
              username.text.isNotEmpty &&
              birthday.text.isNotEmpty &&
              promo.text.isNotEmpty &&
              phone.text.isNotEmpty &&
              floor.text.isNotEmpty &&
              password.text.isNotEmpty &&
              activationCode.text.isNotEmpty) {
            CreateAccount finalcreateAccount = CreateAccount(
              name: name.text,
              firstname: firstname.text,
              nickname: username.text,
              birthday: DateTime.parse(processDateBack(birthday.text)),
              promo: promo.text,
              phone: phone.text,
              floor: floor.text,
              activationToken: activationCode.text,
              password: password.text,
            );
            try {
              final value =
                  await signUpNotifier.activateUser(finalcreateAccount);
              if (value) {
                displayToastWithContext(
                    TypeMsg.msg, LoginTextConstants.accountActivated);
                authTokenNotifier.deleteToken();
                onActivationPressed();
              } else {
                displayToastWithContext(
                    TypeMsg.error, LoginTextConstants.accountNotActivated);
              }
            } catch (e) {
              displayToastWithContext(TypeMsg.error, e.toString());
            }
          } else {
            displayToastWithContext(
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
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        controller: pageController,
                        onPageChanged: (index) {
                          if (index < lastIndex.value ||
                              index == steps.length - 2 ||
                              formKeys[lastIndex.value]
                                  .currentState!
                                  .validate()) {
                            currentPage.value = index;
                            lastIndex.value = index;
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
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
                              FocusScope.of(context).requestFocus(FocusNode());
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
                              if (currentPage.value == steps.length - 2 ||
                                  formKeys[lastIndex.value]
                                      .currentState!
                                      .validate()) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
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
                        index == steps.length - 2 ||
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
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _selectDate(
      BuildContext context, TextEditingController dateController) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xFFfb6d10),
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });

    dateController.text = processDatePrint(
        DateFormat('yyyy-MM-dd').format(picked ?? DateTime.now()));
  }
}
