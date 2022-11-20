import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/is_admin.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/drawer/providers/page_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/drawer/tools/constants.dart';
import 'package:myecl/home/providers/scrolled_provider.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:myecl/user/repositories/profile_picture_repository.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final profilePicture = ref.watch(profilePictureProvider);
    final isToggled = useState(false);
    final page = ref.watch(pageProvider);
    final pageNotifier = ref.watch(pageProvider.notifier);
    final hasScrolled = ref.watch(hasScrolledProvider.notifier);
    final isAdmin = ref.watch(isAdminProvider);
    return Column(children: [
      Container(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 25,
              ),
              GestureDetector(
                onTap: () {
                  if (isAdmin) {
                    isToggled.value = !isToggled.value;
                  } else {
                    pageNotifier.setPage(ModuleType.settings);
                    controllerNotifier.toggle();
                    hasScrolled.setHasScrolled(false);
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    profilePicture.when(
                      data: (file) => Row(children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage: file.image,
                              ),
                            ),
                            if (isAdmin)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () async {},
                                  child: Container(
                                    height: 18,
                                    width: 18,
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: const LinearGradient(
                                        colors: [
                                          ColorConstants.gradient1,
                                          ColorConstants.gradient2,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorConstants.gradient2
                                              .withOpacity(0.3),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: const Offset(1, 2),
                                        ),
                                      ],
                                    ),
                                    child: const HeroIcon(
                                      HeroIcons.bolt,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ]),
                      loading: () => Row(
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                      error: (error, stack) => Container(),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              user.nickname,
                              style: TextStyle(
                                  color: Colors.grey.shade100,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 3,
                          ),
                          SizedBox(
                              width: 200,
                              child: Text(
                                "${user.firstname} ${user.name}",
                                style: TextStyle(
                                  color: Colors.grey.shade100,
                                  fontSize: 15,
                                ),
                              ))
                        ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      if (isToggled.value)
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 20),
          child: Column(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  pageNotifier.setPage(ModuleType.settings);
                  controllerNotifier.toggle();
                  hasScrolled.setHasScrolled(false);
                },
                child: Row(
                  children: [
                    HeroIcon(
                      HeroIcons.cog,
                      color: page == ModuleType.settings
                          ? DrawerColorConstants.selectedText
                          : DrawerColorConstants.lightText,
                      size: 25,
                    ),
                    Container(
                      width: 15,
                    ),
                    Text(DrawerTextConstants.settings,
                        style: TextStyle(
                          color: page == ModuleType.settings
                              ? DrawerColorConstants.selectedText
                              : DrawerColorConstants.lightText,
                          fontSize: 15,
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (isAdmin)
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    pageNotifier.setPage(ModuleType.admin);
                    controllerNotifier.toggle();
                    hasScrolled.setHasScrolled(false);
                  },
                  child: Row(
                    children: [
                      HeroIcon(
                        HeroIcons.userGroup,
                        color: page == ModuleType.admin
                            ? DrawerColorConstants.selectedText
                            : DrawerColorConstants.lightText,
                        size: 25,
                      ),
                      Container(
                        width: 15,
                      ),
                      Text(DrawerTextConstants.admin,
                          style: TextStyle(
                            color: page == ModuleType.admin
                                ? DrawerColorConstants.selectedText
                                : DrawerColorConstants.lightText,
                            fontSize: 15,
                          )),
                      Container(
                        width: 25,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        )
    ]);
  }
}
