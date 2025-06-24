import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/styleguide/navbar.dart';
import 'package:titan/tools/ui/styleguide/router.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class StyleGuidePage extends HookConsumerWidget {
  const StyleGuidePage({super.key});

  Widget sectionHeader(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ColorConstants.title,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 16, color: ColorConstants.tertiary),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        children: [
          TopBar(title: "Style Guide", root: StyleGuideRouter.root),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section title
                    const Text(
                      "Components",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.title,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Floating Navbar Section
                    sectionHeader(
                      "1. Floating Navigation Bar",
                      "A customizable navigation bar with a floating design and rounded corners",
                    ),

                    // Floating Navbar Example
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: FloatingNavbar(
                        items: [
                          FloatingNavbarItem(
                            title: 'Home',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Home tapped')),
                              );
                            },
                          ),
                          FloatingNavbarItem(
                            title: 'Search',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Search tapped')),
                              );
                            },
                          ),
                          FloatingNavbarItem(
                            title: 'Favorites',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Favorites tapped'),
                                ),
                              );
                            },
                          ),
                          FloatingNavbarItem(
                            title: 'Profile',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Profile tapped')),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    // Divider
                    const Divider(height: 40),

                    // Buttons Section
                    sectionHeader(
                      "2. Buttons",
                      "Collection of styled buttons for different actions and states",
                    ),

                    // Button Examples
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Main Button:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Button(
                            text: "Main Action",
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Main button pressed'),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 16),
                          const Text(
                            "Danger Button:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Button.danger(
                            text: "Delete",
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Danger button pressed'),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 16),
                          const Text(
                            "On Danger Button:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Button.onDanger(
                            text: "Confirm Delete",
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('On danger button pressed'),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 16),
                          const Text(
                            "Secondary Button:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Button.secondary(
                            text: "Cancel",
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Secondary button pressed'),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 16),
                          const Text(
                            "Disabled Button:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Button(
                            text: "Disabled",
                            disabled: true,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),

                    // Divider
                    const Divider(height: 40),

                    // List Items Section
                    sectionHeader(
                      "3. List Items",
                      "Consistent list items for displaying information with optional icon and subtitle",
                    ),

                    // List Items Example
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Basic List Item:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ListItem(
                            title: "Settings",
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Settings tapped'),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 16),
                          const Text(
                            "List Item with Subtitle:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ListItem(
                            title: "Account",
                            subtitle: "Manage your account details",
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Account tapped')),
                              );
                            },
                          ),

                          const SizedBox(height: 16),
                          const Text(
                            "List Item with Icon:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ListItem(
                            title: "Notifications",
                            icon: const HeroIcon(
                              HeroIcons.bell,
                              color: ColorConstants.tertiary,
                            ),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Notifications tapped'),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 16),
                          const Text(
                            "Complete List Item:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ListItem(
                            title: "Profile",
                            subtitle: "Edit your personal information",
                            icon: const HeroIcon(
                              HeroIcons.user,
                              color: ColorConstants.tertiary,
                            ),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Profile tapped')),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
