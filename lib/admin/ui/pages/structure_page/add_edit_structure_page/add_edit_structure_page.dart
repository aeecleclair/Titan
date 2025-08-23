import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/admin.dart';
import 'package:titan/admin/ui/pages/structure_page/add_edit_structure_page/user_search_modal.dart';
import 'package:titan/admin/class/association_membership_simple.dart';
import 'package:titan/admin/providers/association_membership_list_provider.dart';
import 'package:titan/admin/providers/structure_manager_provider.dart';
import 'package:titan/admin/providers/structure_provider.dart';
import 'package:titan/paiement/class/structure.dart';
import 'package:titan/paiement/providers/structure_list_provider.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/styleguide/text_entry.dart';
import 'package:titan/user/class/simple_users.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

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

    final localizeWithContext = AppLocalizations.of(context)!;

    return AdminTemplate(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                      ? localizeWithContext.adminEditStructure
                      : localizeWithContext.adminAddStructure,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextEntry(
                  controller: name,
                  label: localizeWithContext.adminName,
                ),
                const SizedBox(height: 20),
                TextEntry(
                  controller: shortId,
                  label: localizeWithContext.adminShortId,
                  validator: (value) {
                    if (value.isNotEmpty && value.length != 3) {
                      return localizeWithContext.adminShortIdError;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Text(
                  localizeWithContext.adminSiegeAddress,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextEntry(
                  controller: siegeAddressStreet,
                  label: localizeWithContext.adminStreet,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextEntry(
                        controller: siegeAddressCity,
                        label: localizeWithContext.adminCity,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextEntry(
                        controller: siegeAddressZipcode,
                        label: localizeWithContext.adminZipcode,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextEntry(
                  controller: siegeAddressCountry,
                  label: localizeWithContext.adminCountry,
                ),
                const SizedBox(height: 20),
                TextEntry(
                  controller: siret,
                  label: localizeWithContext.adminSiret,
                  validator: (value) {
                    if (value.isNotEmpty &&
                        value.replaceAll(" ", "").length != 14) {
                      return localizeWithContext.adminSiretError;
                    }
                    return null;
                  },
                  canBeEmpty: true,
                ),
                const SizedBox(height: 20),
                Text(
                  localizeWithContext.adminBankDetails,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextEntry(
                  controller: iban,
                  label: localizeWithContext.adminIban,
                  validator: (value) {
                    if (value.isNotEmpty &&
                        value.replaceAll(" ", "").length != 27) {
                      return localizeWithContext.adminIbanError;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextEntry(
                  controller: bic,
                  label: localizeWithContext.adminBic,
                  validator: (value) {
                    if (value.isNotEmpty &&
                        value.replaceAll(" ", "").length != 11) {
                      return localizeWithContext.adminBicError;
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
                            localizeWithContext.adminManager,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            structureManager.getName(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : ListItem(
                        title: localizeWithContext.adminSelectManager,
                        subtitle: structureManager.getName(),
                        onTap: () async {
                          await showCustomBottomModal(
                            context: context,
                            ref: ref,
                            modal: UserSearchModal(),
                          );
                        },
                      ),
                const SizedBox(height: 20),
                Button(
                  onPressed: () async {
                    if (key.currentState == null) {
                      return;
                    }
                    if (structureManager.id.isEmpty && !isEdit) {
                      displayToastWithContext(
                        TypeMsg.error,
                        localizeWithContext.adminNoManager,
                      );
                      return;
                    }
                    if (key.currentState!.validate()) {
                      await tokenExpireWrapper(ref, () async {
                        final editedStructureMsg = isEdit
                            ? localizeWithContext.adminEditedStructure
                            : localizeWithContext.adminAddedStructure;
                        final addedStructureErrorMsg = AppLocalizations.of(
                          context,
                        )!.adminAddingError;
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
                            editedStructureMsg,
                          );
                        } else {
                          displayToastWithContext(
                            TypeMsg.error,
                            addedStructureErrorMsg,
                          );
                        }
                      });
                    }
                  },
                  text: isEdit
                      ? localizeWithContext.adminEdit
                      : localizeWithContext.adminAdd,
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
