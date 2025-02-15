import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/meme/providers/is_meme_admin_provider.dart';
import 'package:myecl/meme/providers/my_profile_picture_provider.dart';
import 'package:myecl/meme/ui/admin_tab/admin_main_tab.dart';
import 'package:myecl/meme/ui/my_meme_tab/my_meme_tab.dart';
import 'package:myecl/meme/ui/meme.dart';
import 'package:myecl/meme/ui/leaderboard_tab/leaderboard_tab.dart';
import 'package:myecl/meme/ui/scrolling_tab.dart/scrolling_tab.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class MemeMainPage extends ConsumerWidget {
  const MemeMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilePicture = ref.watch(myProfilePictureProvider);
    final isAdmin = ref.watch(isMemeAdminProvider);
    return MemeTemplate(
      child: DefaultTabController(
        length: isAdmin ? 4 : 3,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: isAdmin
                ? [
                    ScrollingTab(),
                    LeaderboardTab(),
                    AdminTab(),
                    MyMemeTab(),
                  ]
                : [
                    ScrollingTab(),
                    LeaderboardTab(),
                    MyMemeTab(),
                  ],
          ),
          bottomNavigationBar: Material(
            child: TabBar(
              tabs: isAdmin
                  ? [
                      const Tab(icon: Icon(Icons.home_outlined, size: 30)),
                      const Tab(
                        icon: Icon(Icons.emoji_events_outlined, size: 30),
                      ),
                      const Tab(
                        icon: Icon(
                          Icons.admin_panel_settings_outlined,
                          size: 30,
                        ),
                      ),
                      Tab(
                        child: AsyncChild(
                          value: profilePicture,
                          builder: (context, file) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.1),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: file.isEmpty
                                          ? AssetImage(getTitanLogo())
                                          : Image.memory(file).image,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                  : [
                      const Tab(icon: Icon(Icons.newspaper, size: 30)),
                      const Tab(
                        icon: HeroIcon(
                          HeroIcons.trophy,
                          size: 30,
                        ),
                      ),
                      Tab(
                        child: AsyncChild(
                          value: profilePicture,
                          builder: (context, file) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.1),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: file.isEmpty
                                          ? AssetImage(getTitanLogo())
                                          : Image.memory(file).image,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
            ),
          ),
        ),
      ),
    );
  }
}
