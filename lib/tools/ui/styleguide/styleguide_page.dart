import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/horizontal_multi_select.dart';
import 'package:titan/tools/ui/styleguide/item_chip.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/styleguide/navbar.dart';
import 'package:titan/tools/ui/styleguide/router.dart';
import 'package:titan/tools/ui/styleguide/searchbar.dart';
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

                    // Divider
                    const Divider(height: 40),

                    // SearchBar Section
                    sectionHeader(
                      "4. SearchBar",
                      "A customizable search component with filtering capabilities",
                    ),

                    // SearchBar Examples
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
                            "Basic SearchBar:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          CustomSearchBar(
                            hintText: "Search something...",
                            onSearch: (query) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Searching for: "$query"'),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            onFilter: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Filter button clicked'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 24),
                          const Text(
                            "SearchBar with Filter Dialog:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          CustomSearchBar(
                            hintText: "Search users...",
                            onSearch: (query) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('User search: "$query"'),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            onFilter: () {
                              // Show filter dialog
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Filter Options"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        title: const Text("Name"),
                                        onTap: () {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text('Filter by Name'),
                                            ),
                                          );
                                        },
                                      ),
                                      ListTile(
                                        title: const Text("Role"),
                                        onTap: () {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text('Filter by Role'),
                                            ),
                                          );
                                        },
                                      ),
                                      ListTile(
                                        title: const Text("Age"),
                                        onTap: () {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text('Filter by Age'),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    // Divider
                    const Divider(height: 40),

                    // Bottom Modal Template Section
                    sectionHeader(
                      "5. Bottom Modal Template",
                      "A reusable bottom sheet modal with a handle and customizable content",
                    ),

                    // Bottom Modal Example
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
                            "Bottom Modal Example:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Button(
                            text: "Show Bottom Modal",
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return BottomModalTemplate(
                                    title: "Example Modal",
                                    description:
                                        "This is a customizable bottom modal template that can contain any content.",
                                    actions: [
                                      Button(
                                        text: "Close Modal",
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                    child: Container(
                                      height: 150,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Modal Content Area",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: ColorConstants.tertiary,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),

                          const SizedBox(height: 16),
                          Button.danger(
                            text: "Show Danger Modal",
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return BottomModalTemplate.danger(
                                    title: "Confirm Deletion",
                                    description:
                                        "This action cannot be undone. All data will be permanently deleted.",
                                    actions: [
                                      Button.onDanger(
                                        text: "Delete Permanently",
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      const SizedBox(height: 8),
                                      Button.secondary(
                                        text: "Cancel",
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                    child: Container(
                                      height: 100,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Danger Content Area",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: ColorConstants.background,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),

                          const SizedBox(height: 16),
                          Button.secondary(
                            text: "Show Member Management Modal",
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return BottomModalTemplate(
                                    title: "Member Management",
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        // Search bar
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: CustomSearchBar(
                                            hintText: "Search members...",
                                            onSearch: (query) {},
                                            onFilter: () {},
                                          ),
                                        ),

                                        ListItem(
                                          title: "Add member",
                                          icon: const HeroIcon(
                                            HeroIcons.plus,
                                            color: ColorConstants.tertiary,
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Add member tapped',
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        const Divider(),

                                        ListItem(
                                          title: "Zoto - Prez",
                                          subtitle: "Jules Barra",
                                          onTap: () {
                                            Navigator.pop(context);
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              builder: (context) {
                                                return BottomModalTemplate(
                                                  title: "Member Details",
                                                  description: "Jules Barra",
                                                  actions: [
                                                    Button.secondary(
                                                      text: "Modify Role",
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                              'Modify role tapped',
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Button.danger(
                                                      text: "Remove Role",
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                              'Remove role tapped',
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                  child: const Center(
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                        24.0,
                                                      ),
                                                      child: Text(
                                                        "Role: Zoto - Prez",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorConstants
                                                              .title,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),

                                        ListItem(
                                          title: "Corpo",
                                          subtitle:
                                              "Gère toutes les autres assos",
                                          onTap: () {
                                            // Show member details
                                          },
                                        ),

                                        ListItem(
                                          title: "Biero",
                                          subtitle: "Nathan Guigui",
                                          onTap: () {
                                            // Show member details
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),

                          const SizedBox(height: 16),
                          const Text(
                            "Usage Example:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "showModalBottomSheet(",
                                  style: TextStyle(fontFamily: "monospace"),
                                ),
                                Text(
                                  "  context: context,",
                                  style: TextStyle(fontFamily: "monospace"),
                                ),
                                Text(
                                  "  isScrollControlled: true,",
                                  style: TextStyle(fontFamily: "monospace"),
                                ),
                                Text(
                                  "  backgroundColor: Colors.transparent,",
                                  style: TextStyle(fontFamily: "monospace"),
                                ),
                                Text(
                                  "  builder: (context) => BottomModalTemplate(",
                                  style: TextStyle(fontFamily: "monospace"),
                                ),
                                Text(
                                  "    child: YourContent(),",
                                  style: TextStyle(fontFamily: "monospace"),
                                ),
                                Text(
                                  "  ),",
                                  style: TextStyle(fontFamily: "monospace"),
                                ),
                                Text(
                                  ");",
                                  style: TextStyle(fontFamily: "monospace"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Horizontal Multi Select Section
                    sectionHeader(
                      "6. Horizontal Multi Select",
                      "A horizontally scrollable list of selectable items with customizable appearance",
                    ),

                    // Horizontal Multi Select Examples
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
                            "Basic Multi Select:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 50,
                            child: HorizontalMultiSelect<String>(
                              items: const [
                                "Apple",
                                "Banana",
                                "Cherry",
                                "Date",
                                "Fig",
                                "Grape",
                              ],
                              itemBuilder: (context, item, index, selected) {
                                return Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: selected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                );
                              },
                              onItemSelected: (item) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Selected: $item'),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 24),
                          const Text(
                            "With Custom First Child:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 50,
                            child: HorizontalMultiSelect<Color>(
                              items: const [
                                Colors.red,
                                Colors.orange,
                                Colors.yellow,
                                Colors.green,
                                Colors.blue,
                                Colors.purple,
                              ],
                              firstChild: ItemChip(
                                child: const HeroIcon(
                                  HeroIcons.plus,
                                  size: 24,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Add new color'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                              ),
                              itemBuilder: (context, color, index, selected) {
                                return Container(
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                );
                              },
                              onItemSelected: (color) {
                                final colorName = color == Colors.red
                                    ? "Red"
                                    : color == Colors.orange
                                    ? "Orange"
                                    : color == Colors.yellow
                                    ? "Yellow"
                                    : color == Colors.green
                                    ? "Green"
                                    : color == Colors.blue
                                    ? "Blue"
                                    : "Purple";
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Selected: $colorName'),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 24),
                          const Text(
                            "With Long Press Support:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 70,
                            child: HorizontalMultiSelect<Map<String, dynamic>>(
                              items: const [
                                {"name": "John", "role": "Admin"},
                                {"name": "Emma", "role": "Editor"},
                                {"name": "Michael", "role": "Viewer"},
                                {"name": "Sarah", "role": "Admin"},
                                {"name": "David", "role": "Editor"},
                              ],
                              itemBuilder: (context, user, index, selected) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      user["name"],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: selected
                                            ? Colors.blue
                                            : Colors.black,
                                      ),
                                    ),
                                    Text(
                                      user["role"],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: selected
                                            ? Colors.blue.shade700
                                            : Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                );
                              },
                              onItemSelected: (user) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Selected: ${user["name"]}'),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              onLongPress: (user) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Long press on ${user["name"]}',
                                    ),
                                    backgroundColor: Colors.orange,
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 16),
                          const Text(
                            "Usage Example:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "HorizontalMultiSelect<String>(",
                                  style: TextStyle(fontFamily: "monospace"),
                                ),
                                Text(
                                  "  items: ['Item 1', 'Item 2', 'Item 3'],",
                                  style: TextStyle(fontFamily: "monospace"),
                                ),
                                Text(
                                  "  itemBuilder: (context, item, index) {",
                                  style: TextStyle(fontFamily: "monospace"),
                                ),
                                Text(
                                  "    return Text(item);",
                                  style: TextStyle(fontFamily: "monospace"),
                                ),
                                Text(
                                  "  },",
                                  style: TextStyle(fontFamily: "monospace"),
                                ),
                                Text(
                                  "  onItemSelected: (item) {",
                                  style: TextStyle(fontFamily: "monospace"),
                                ),
                                Text(
                                  "    print('Selected: \$item');",
                                  style: TextStyle(fontFamily: "monospace"),
                                ),
                                Text(
                                  "  },",
                                  style: TextStyle(fontFamily: "monospace"),
                                ),
                                Text(
                                  ")",
                                  style: TextStyle(fontFamily: "monospace"),
                                ),
                              ],
                            ),
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
