import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/CMM/providers/profile_picture_repository.dart';
import 'package:myecl/CMM/ui/my_cmm_tab/my_cmm_tab.dart';
import 'package:myecl/CMM/ui/cmm.dart';
import 'package:myecl/CMM/ui/leaderboard_tab/leaderboard_tab.dart';
import 'package:myecl/CMM/ui/scrolling_tab.dart/scrolling_tab.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class CMMMainPage extends ConsumerWidget {
  const CMMMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilePicture = ref.watch(profilePictureProvider);
    return CMMTemplate(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              ScrollingTab(),
              LeaderboardTab(),
              MyCMMTab(),
            ],
          ),
          bottomNavigationBar: Material(
            child: TabBar(
              tabs: [
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
                                    color: Colors.black.withOpacity(0.1),
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
