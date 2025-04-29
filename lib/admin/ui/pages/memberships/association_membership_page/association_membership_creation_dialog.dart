import 'package:flutter/material.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/admin/tools/constants.dart';

class MembershipCreationDialogBox extends StatelessWidget {
  final Function() onYes;
  final Function()? onNo;
  final TextEditingController nameController;
  final TextEditingController groupIdController;
  final List<SimpleGroup> groups;

  static const double _padding = 20;
  static const double _avatarRadius = 45;

  const MembershipCreationDialogBox({
    super.key,
    required this.nameController,
    required this.groupIdController,
    required this.onYes,
    required this.groups,
    this.onNo,
  });

  @override
  Widget build(BuildContext context) {
    groups.sort(
      (SimpleGroup a, SimpleGroup b) =>
          a.name.toLowerCase().compareTo(b.name.toLowerCase()),
    );
    groupIdController.text = groups.first.id;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(MembershipCreationDialogBox._padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(MembershipCreationDialogBox._padding),
            margin: const EdgeInsets.only(
              top: MembershipCreationDialogBox._avatarRadius,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).colorScheme.surface,
              borderRadius:
                  BorderRadius.circular(MembershipCreationDialogBox._padding),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  offset: const Offset(0, 5),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  AdminTextConstants.createAssociationMembership,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: AdminTextConstants.associationMembershipName,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  value: groupIdController.text,
                  onChanged: (String? newValue) {
                    groupIdController.text = newValue!;
                  },
                  items: groups
                      .map(
                        (SimpleGroup group) => DropdownMenuItem<String>(
                          value: group.id,
                          child: Text(group.name),
                        ),
                      )
                      .toList(),
                  decoration: const InputDecoration(
                    hintText: AdminTextConstants.group,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await onYes();
                        },
                        child: Text(
                          "Créer",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (onNo == null) {
                            Navigator.of(context).pop();
                          }
                          onNo?.call();
                        },
                        child: Text(
                          "Annuler",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
