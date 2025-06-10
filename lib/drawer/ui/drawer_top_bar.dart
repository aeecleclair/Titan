import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/admin/router.dart';
import 'package:titan/auth/providers/is_connected_provider.dart';
import 'package:titan/drawer/providers/animation_provider.dart';
import 'package:titan/drawer/providers/swipe_provider.dart';
import 'package:titan/drawer/tools/constants.dart';
import 'package:titan/home/providers/scrolled_provider.dart';
import 'package:titan/settings/router.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:titan/user/providers/profile_picture_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class DrawerTopBar extends HookConsumerWidget {
  const DrawerTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pathForwardingNotifier = ref.read(pathForwardingProvider.notifier);
    final pathForwarding = ref.watch(pathForwardingProvider);
    final user = ref.watch(userProvider);
    final profilePicture = ref.watch(profilePictureProvider);
    final hasScrolled = ref.watch(hasScrolledProvider.notifier);
    final isAdmin = ref.watch(isAdminProvider);
    final isConnected = ref.watch(isConnectedProvider);
    final animation = ref.watch(animationProvider);
    final dropDownAnimation = useAnimationController(
      duration: const Duration(milliseconds: 250),
      initialValue: 0.0,
    );

    void onBack(String path) {
      if (animation != null) {
        final controllerNotifier = ref.watch(
          swipeControllerProvider(animation).notifier,
        );
        controllerNotifier.toggle();
      }
      QR.to(path);
      pathForwardingNotifier.forward(path);
      hasScrolled.setHasScrolled(false);
    }

    return Column(
      children: [
        Container(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(width: 25),
                GestureDetector(
                  onTap: () {
                    if (isAdmin) {
                      if (dropDownAnimation.isDismissed) {
                        dropDownAnimation.forward();
                      } else {
                        dropDownAnimation.reverse();
                      }
                    } else {
                      onBack(SettingsRouter.root);
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: [
                      AsyncChild(
                        value: profilePicture,
                        builder: (context, file) => Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.1,
                                        ),
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: file.isEmpty
                                        ? AssetImage(getTitanLogo())
                                        : Image.memory(file).image,
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
                                                  .withValues(alpha: 0.3),
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
                            const SizedBox(width: 15),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              user.nickname ?? user.firstname,
                              style: TextStyle(
                                color: Colors.grey.shade100,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(height: 3),
                          SizedBox(
                            width: 200,
                            child: Text(
                              user.nickname != null
                                  ? "${user.firstname} ${user.name}"
                                  : user.name,
                              style: TextStyle(
                                color: Colors.grey.shade100,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (!isConnected)
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: const HeroIcon(
                  HeroIcons.signalSlash,
                  color: Colors.white,
                  size: 40,
                ),
              ),
          ],
        ),
        AnimatedBuilder(
          builder: (context, child) {
            return Opacity(
              opacity: dropDownAnimation.value,
              child: Padding(
                padding: const EdgeInsets.only(left: 25, top: 15),
                child: Column(
                  children: [
                    Transform.translate(
                      offset: Offset(0, -10 * (1 - dropDownAnimation.value)),
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => onBack(SettingsRouter.root),
                        child: Row(
                          children: [
                            HeroIcon(
                              HeroIcons.cog,
                              color:
                                  pathForwarding.path.startsWith(
                                    SettingsRouter.root,
                                  )
                                  ? DrawerColorConstants.selectedText
                                  : DrawerColorConstants.lightText,
                              size: 25,
                            ),
                            Container(width: 15),
                            Text(
                              DrawerTextConstants.settings,
                              style: TextStyle(
                                color:
                                    pathForwarding.path.startsWith(
                                      SettingsRouter.root,
                                    )
                                    ? DrawerColorConstants.selectedText
                                    : DrawerColorConstants.lightText,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (isAdmin)
                      Transform.translate(
                        offset: Offset(0, -15 * (1 - dropDownAnimation.value)),
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => onBack(AdminRouter.root),
                          child: Row(
                            children: [
                              HeroIcon(
                                HeroIcons.userGroup,
                                color:
                                    pathForwarding.path.startsWith(
                                      AdminRouter.root,
                                    )
                                    ? DrawerColorConstants.selectedText
                                    : DrawerColorConstants.lightText,
                                size: 25,
                              ),
                              Container(width: 15),
                              Text(
                                DrawerTextConstants.admin,
                                style: TextStyle(
                                  color:
                                      pathForwarding.path.startsWith(
                                        AdminRouter.root,
                                      )
                                      ? DrawerColorConstants.selectedText
                                      : DrawerColorConstants.lightText,
                                  fontSize: 15,
                                ),
                              ),
                              Container(width: 25),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
          animation: dropDownAnimation,
        ),
      ],
    );
  }
}
