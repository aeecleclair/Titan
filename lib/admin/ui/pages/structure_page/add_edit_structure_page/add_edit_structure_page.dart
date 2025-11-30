import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/association_membership_simple.dart';
import 'package:titan/admin/providers/association_membership_list_provider.dart';
import 'package:titan/admin/providers/structure_manager_provider.dart';
import 'package:titan/admin/providers/structure_provider.dart';
import 'package:titan/admin/tools/constants.dart';
import 'package:titan/admin/ui/admin.dart';
import 'package:titan/admin/ui/components/admin_button.dart';
import 'package:titan/admin/ui/pages/structure_page/add_edit_structure_page/search_user.dart';
import 'package:titan/mypayment/class/structure.dart';
import 'package:titan/mypayment/providers/structure_list_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:titan/user/class/simple_users.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditStructurePage extends HookConsumerWidget {
  const AddEditStructurePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final structure = ref.watch(structureProvider);
    final structureManager = ref.watch(structureManagerProvider);
    final structureManagerNotifier = ref.watch(
      structureManagerProvider.notifier,
    );
    final structureListNotifier = ref.watch(structureListProvider.notifier);
    final isEdit = structure.id != '';
    final name = useTextEditingController(text: isEdit ? structure.name : null);
    final shortId = useTextEditingController(
      text: isEdit ? structure.shortId : null,
    );
    final siegeAddressStreet = useTextEditingController(
      text: isEdit ? structure.siegeAddressStreet : null,
    );
    final siegeAddressCity = useTextEditingController(
      text: isEdit ? structure.siegeAddressCity : null,
    );
    final siegeAddressZipcode = useTextEditingController(
      text: isEdit ? structure.siegeAddressZipcode : null,
    );
    final siegeAddressCountry = useTextEditingController(
      text: isEdit ? structure.siegeAddressCountry : null,
    );
    final siret = useTextEditingController(
      text: isEdit ? structure.siret : null,
    );
    final iban = useTextEditingController(text: isEdit ? structure.iban : null);
    final bic = useTextEditingController(text: isEdit ? structure.bic : null);
    final allAssociationMembershipList = ref.watch(
      allAssociationMembershipListProvider,
    );
    final currentMembership = useState<AssociationMembership>(
      isEdit ? structure.associationMembership : AssociationMembership.empty(),
    );
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AdminTemplate(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Form(
            key: key,
            child: Column(
              children: [
                Text(
                  isEdit
                      ? AdminTextConstants.editStructure
                      : AdminTextConstants.addStructure,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextEntry(controller: name, label: AdminTextConstants.name),
                const SizedBox(height: 20),
                TextEntry(
                  controller: shortId,
                  label: AdminTextConstants.structureShortId,
                  validator: (value) {
                    if (value.isNotEmpty && value.length != 3) {
                      return AdminTextConstants.shortIdError;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Text(
                  AdminTextConstants.siegeAddress,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextEntry(
                  controller: siegeAddressStreet,
                  label: AdminTextConstants.structureStreetAddress,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextEntry(
                        controller: siegeAddressCity,
                        label: AdminTextConstants.structureCity,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextEntry(
                        controller: siegeAddressZipcode,
                        label: AdminTextConstants.structureZipcode,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextEntry(
                  controller: siegeAddressCountry,
                  label: AdminTextConstants.structureCountry,
                ),
                const SizedBox(height: 20),
                TextEntry(
                  controller: siret,
                  label: AdminTextConstants.structureSiret,
                  validator: (value) {
                    if (value.isNotEmpty &&
                        value.replaceAll(" ", "").length != 14) {
                      return AdminTextConstants.structureSiretError;
                    }
                    return null;
                  },
                  canBeEmpty: true,
                ),
                const SizedBox(height: 20),
                Text(
                  AdminTextConstants.structureBankInformation,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextEntry(
                  controller: iban,
                  label: AdminTextConstants.structureIban,
                  validator: (value) {
                    if (value.isNotEmpty &&
                        value.replaceAll(" ", "").length != 27) {
                      return AdminTextConstants.structureIbanError;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextEntry(
                  controller: bic,
                  label: AdminTextConstants.structureBic,
                  validator: (value) {
                    if (value.isNotEmpty &&
                        value.replaceAll(" ", "").length != 11) {
                      return AdminTextConstants.structureBicError;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                AsyncChild(
                  value: allAssociationMembershipList,
                  builder: (context, allAssociationMembershipList) {
                    return HorizontalListView.builder(
                      height: 40,
                      items: [
                        ...allAssociationMembershipList,
                        AssociationMembership.empty(),
                      ],
                      itemBuilder: (context, associationMembership, index) {
                        final selected =
                            currentMembership.value.id ==
                            associationMembership.id;
                        return ItemChip(
                          selected: selected,
                          onTap: () async {
                            currentMembership.value = associationMembership;
                          },
                          child: Text(
                            associationMembership.name.toUpperCase(),
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                isEdit
                    ? Column(
                        children: [
                          Text(
                            AdminTextConstants.manager,
                            style: TextStyle(
                              color: ColorConstants.gradient1,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            structureManager.getName(),
                            style: TextStyle(
                              color: ColorConstants.gradient1,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SearchUser(),
                const SizedBox(height: 20),
                WaitingButton(
                  onTap: () async {
                    if (key.currentState == null) {
                      return;
                    }
                    if (structureManager.id.isEmpty && !isEdit) {
                      displayToastWithContext(
                        TypeMsg.error,
                        AdminTextConstants.structureManagerError,
                      );
                      return;
                    }
                    if (key.currentState!.validate()) {
                      await tokenExpireWrapper(ref, () async {
                        final value = isEdit
                            ? await structureListNotifier.updateStructure(
                                Structure(
                                  id: structure.id,
                                  shortId: shortId.text,
                                  name: name.text,
                                  siegeAddressStreet: siegeAddressStreet.text,
                                  siegeAddressCity: siegeAddressCity.text,
                                  siegeAddressZipcode: siegeAddressZipcode.text,
                                  siegeAddressCountry: siegeAddressCountry.text,
                                  siret: siret.text,
                                  iban: iban.text,
                                  bic: bic.text,
                                  associationMembership:
                                      currentMembership.value,
                                  managerUser: structureManager,
                                ),
                              )
                            : await structureListNotifier.createStructure(
                                Structure(
                                  id: '',
                                  shortId: shortId.text,
                                  name: name.text,
                                  siegeAddressStreet: siegeAddressStreet.text,
                                  siegeAddressCity: siegeAddressCity.text,
                                  siegeAddressZipcode: siegeAddressZipcode.text,
                                  siegeAddressCountry: siegeAddressCountry.text,
                                  siret: siret.text,
                                  iban: iban.text,
                                  bic: bic.text,
                                  associationMembership:
                                      currentMembership.value,
                                  managerUser: structureManager,
                                ),
                              );
                        if (value) {
                          QR.back();
                          structureManagerNotifier.setUser(SimpleUser.empty());
                          displayToastWithContext(
                            TypeMsg.msg,
                            isEdit
                                ? AdminTextConstants.updatedStructure
                                : AdminTextConstants.addedStructure,
                          );
                        } else {
                          displayToastWithContext(
                            TypeMsg.error,
                            isEdit
                                ? AdminTextConstants.updateStructureError
                                : AdminTextConstants.addStructureError,
                          );
                        }
                      });
                    }
                  },
                  builder: (child) => AdminButton(child: child),
                  child: Text(
                    isEdit ? AdminTextConstants.edit : AdminTextConstants.add,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
