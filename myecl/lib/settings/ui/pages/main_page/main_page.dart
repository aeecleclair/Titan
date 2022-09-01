import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/settings/providers/settings_page_provider.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/settings/ui/refresh_indicator.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/user/providers/user_provider.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(userProvider);
    final meNotifier = ref.watch(asyncUserProvider.notifier);
    final pageNotifier = ref.watch(settingsPageProvider.notifier);
    print(me);
    return SettingsRefresher(
      onRefresh: () async {
        await meNotifier.loadMe();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                  child: Column(children: [
                    Text(
                      me.nickname,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      me.firstname + " " + me.name,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                    width: 100,
                    child: GestureDetector(
                      onTap: () {
                        pageNotifier.setSettingsPage(SettingsPage.info);
                      },
                      child: Center(
                        child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              Transform.rotate(
                                angle: 3.14 / 12,
                                child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          SettingsColorConstants.gradient1,
                                          SettingsColorConstants.gradient2,
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: SettingsColorConstants
                                              .gradient2
                                              .withOpacity(0.5),
                                          blurRadius: 5,
                                          offset: const Offset(2, 2),
                                          spreadRadius: 2,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15),
                                    )),
                              ),
                              Positioned(
                                top: 5,
                                right: 7,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10.0, sigmaY: 10.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 1,
                                            ),
                                          ),
                                          width: 50,
                                          height: 50,
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ))),
                                ),
                              )
                            ]),
                      ),
                    )),
              ]),
              const SizedBox(
                height: 50,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  SettingsTextConstants.email,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  me.email,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ]),
              const SizedBox(height: 25),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  SettingsTextConstants.promo,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  me.promo.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ]),
              const SizedBox(height: 25),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  SettingsTextConstants.floor,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  me.floor.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ]),
              const SizedBox(height: 25),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  SettingsTextConstants.birthday,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  processDatePrint(me.birthday),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ]),
              const SizedBox(height: 25),
              me.groups.isNotEmpty
                  ? Column(children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            SettingsTextConstants.association +
                                (me.groups.length > 1 ? "s" : ""),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )),
                      ...me.groups.map((e) => Column(
                            children: [
                              const SizedBox(height: 15),
                              Text(
                                "- " + capitalize(e.name),
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ))
                    ])
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
