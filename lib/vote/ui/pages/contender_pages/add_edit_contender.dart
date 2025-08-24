import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/settings/ui/pages/main_page/picture_button.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/widgets/image_picker_on_tap.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:titan/vote/class/contender.dart';
import 'package:titan/vote/providers/contender_logo_provider.dart';
import 'package:titan/vote/providers/contender_logos_provider.dart';
import 'package:titan/vote/providers/contender_members.dart';
import 'package:titan/vote/providers/contender_list_provider.dart';
import 'package:titan/vote/providers/contender_provider.dart';
import 'package:titan/vote/providers/sections_contender_provider.dart';
import 'package:titan/vote/providers/sections_provider.dart';
import 'package:titan/vote/ui/components/member_card.dart';
import 'package:titan/vote/ui/pages/contender_pages/contender_member.dart';
import 'package:titan/vote/ui/pages/admin_page/section_chip.dart';
import 'package:titan/vote/ui/vote.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class AddEditContenderPage extends HookConsumerWidget {
  const AddEditContenderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final section = useState(ref.watch(sectionProvider));
    final contenderListNotifier = ref.read(contenderListProvider.notifier);
    final sectionsNotifier = ref.read(sectionContenderProvider.notifier);
    final contender = ref.watch(contenderProvider);
    final isEdit = contender.id != Contender.empty().id;
    final name = useTextEditingController(text: contender.name);
    final description = useTextEditingController(text: contender.description);
    final listType = useState(contender.listType);
    final program = useTextEditingController(text: contender.program);
    final members = ref.watch(contenderMembersProvider);
    final membersNotifier = ref.read(contenderMembersProvider.notifier);
    final contenderLogosNotifier = ref.read(contenderLogosProvider.notifier);
    final logoNotifier = ref.read(contenderLogoProvider.notifier);
    final logo = useState<Uint8List?>(null);
    final logoFile = useState<Image?>(null);

    final contenderLogos = ref.watch(contenderLogosProvider);
    if (contenderLogos[contender.id] != null) {
      contenderLogos[contender.id]!.whenData((data) {
        if (data.isNotEmpty) {
          logoFile.value = data.first;
        }
      });
    }

    final ImagePicker picker = ImagePicker();

    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return VoteTemplate(
      child: ScrollToHideNavbar(
        controller: useScrollController(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: key,
            child: Column(
              children: [
                const SizedBox(height: 20),
                AlignLeftText(
                  AppLocalizations.of(context)!.voteAddPretendance,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  color: ColorConstants.title,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 20),
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(2, 3),
                            ),
                          ],
                        ),
                        child: logoFile.value != null
                            ? Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: logo.value != null
                                        ? Image.memory(
                                            logo.value!,
                                            fit: BoxFit.cover,
                                          ).image
                                        : logoFile.value!.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : const HeroIcon(
                                HeroIcons.userCircle,
                                size: 160,
                                color: Colors.grey,
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: ImagePickerOnTap(
                          picker: picker,
                          imageBytesNotifier: logo,
                          imageNotifier: logoFile,
                          displayToastWithContext: displayVoteToastWithContext,
                          child: const PictureButton(icon: HeroIcons.photo),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextEntry(
                    label: AppLocalizations.of(context)!.voteName,
                    controller: name,
                  ),
                ),
                const SizedBox(height: 20),
                HorizontalListView.builder(
                  height: 50,
                  items: ListType.values
                      .where((e) => e != ListType.blank)
                      .toList(),
                  itemBuilder: (context, e, i) => SectionChip(
                    label: capitalize(e.toString().split('.').last),
                    selected: listType.value == e,
                    onTap: () async {
                      listType.value = e;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextEntry(
                    keyboardType: TextInputType.multiline,
                    controller: description,
                    label: AppLocalizations.of(context)!.voteDescription,
                  ),
                ),
                const SizedBox(height: 20),
                ContenderMember(),
                const SizedBox(height: 10),
                members.isEmpty
                    ? Center(
                        child: Text(
                          AppLocalizations.of(context)!.adminNoMember,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: members
                              .map(
                                (e) => MemberCard(
                                  member: e,
                                  isAdmin: true,
                                  onEdit: () {}, // TODO: maybe hide
                                  onDelete: () async {
                                    membersNotifier.removeMember(e);
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextEntry(
                    keyboardType: TextInputType.multiline,
                    label: AppLocalizations.of(context)!.voteProgram,
                    controller: program,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: WaitingButton(
                    builder: (child) => Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 8, bottom: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.5),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                      child: child,
                    ),
                    onTap: () async {
                      if (key.currentState == null) {
                        return;
                      }
                      if (key.currentState!.validate()) {
                        await tokenExpireWrapper(ref, () async {
                          final contenderList = ref.watch(
                            contenderListProvider,
                          );
                          Contender newContender = Contender(
                            name: name.text,
                            id: isEdit ? contender.id : '',
                            description: description.text,
                            listType: listType.value,
                            members: members,
                            section: section.value,
                            program: program.text,
                          );
                          final editedPretendanceMsg = isEdit
                              ? AppLocalizations.of(
                                  context,
                                )!.voteEditedPretendance
                              : AppLocalizations.of(
                                  context,
                                )!.voteAddedPretendance;
                          final editingPretendanceErrorMsg =
                              AppLocalizations.of(context)!.voteEditingError;
                          final value = isEdit
                              ? await contenderListNotifier.updateContender(
                                  newContender,
                                )
                              : await contenderListNotifier.addContender(
                                  newContender,
                                );
                          if (value) {
                            QR.back();
                            displayVoteToastWithContext(
                              TypeMsg.msg,
                              editedPretendanceMsg,
                            );
                            if (isEdit) {
                              contenderList.maybeWhen(
                                data: (list) {
                                  final logoBytes = logo.value;
                                  if (logoBytes != null) {
                                    contenderLogosNotifier.autoLoad(
                                      ref,
                                      contender.id,
                                      (contenderId) => logoNotifier.updateLogo(
                                        contenderId,
                                        logoBytes,
                                      ),
                                    );
                                  }
                                },
                                orElse: () {},
                              );
                            } else {
                              contenderList.maybeWhen(
                                data: (list) {
                                  final newContender = list.last;
                                  final logoBytes = logo.value;
                                  if (logoBytes != null) {
                                    contenderLogosNotifier.autoLoad(
                                      ref,
                                      newContender.id,
                                      (contenderId) => logoNotifier.updateLogo(
                                        contenderId,
                                        logoBytes,
                                      ),
                                    );
                                  }
                                },
                                orElse: () {},
                              );
                            }
                            membersNotifier.clearMembers();
                            sectionsNotifier.setTData(
                              section.value,
                              await contenderListNotifier.copy(),
                            );
                          } else {
                            displayVoteToastWithContext(
                              TypeMsg.error,
                              editingPretendanceErrorMsg,
                            );
                          }
                        });
                      } else {
                        displayToast(
                          context,
                          TypeMsg.error,
                          AppLocalizations.of(
                            context,
                          )!.voteIncorrectOrMissingFields,
                        );
                      }
                    },
                    child: Text(
                      isEdit
                          ? AppLocalizations.of(context)!.voteEdit
                          : AppLocalizations.of(context)!.voteAdd,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
