import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qlevar_router/qlevar_router.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:titan/admin/class/assocation.dart';
import 'package:titan/admin/providers/my_association_list_provider.dart';
// import 'package:titan/event/providers/selected_days_provider.dart';
// import 'package:titan/event/tools/constants.dart';
// import 'package:titan/event/tools/functions.dart';
import 'package:titan/event/ui/pages/event_pages/checkbox_entry.dart';
import 'package:titan/feed/class/event.dart';
import 'package:titan/feed/providers/event_image_provider.dart';
import 'package:titan/feed/providers/event_provider.dart';
import 'package:titan/feed/providers/news_list_provider.dart';
import 'package:titan/feed/ui/feed.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/styleguide/horizontal_multi_select.dart';
import 'package:titan/tools/ui/styleguide/text_entry.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:titan/tools/ui/widgets/image_picker_on_tap.dart';

class AddEventPage extends HookConsumerWidget {
  const AddEventPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context);
    final key = GlobalKey<FormState>();
    final myAssociations = ref.watch(myAssociationListProvider);
    final titleController = useTextEditingController();
    final locationController = useTextEditingController();
    final shotgunDateController = useTextEditingController();
    final externalLinkController = useTextEditingController();
    final startDateController = useTextEditingController();
    final endDateController = useTextEditingController();
    final allDay = useState(false);
    final notification = useState(true);
    // final recurrentController = useState(false);
    // final recurrenceEndDateController = useTextEditingController();

    final eventCreationNotifier = ref.watch(eventProvider.notifier);
    final eventImageNotifier = ref.watch(eventImageProvider.notifier);
    final newsListNotifier = ref.watch(newsListProvider.notifier);
    // final interval = useTextEditingController();
    // final recurrenceEndDate = useTextEditingController();
    // final selectedDays = ref.watch(selectedDaysProvider);
    // final selectedDaysNotifier = ref.watch(selectedDaysProvider.notifier);
    // final now = DateTime.now();
    final selectedAssociation = useState<Association?>(
      myAssociations.length == 1 ? myAssociations.first : null,
    );

    final poster = useState<Uint8List?>(null);
    final posterFile = useState<Image?>(null);

    final ImagePicker picker = ImagePicker();

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final localizeWithContext = AppLocalizations.of(context)!;

    return FeedTemplate(
      child: Expanded(
        child: Form(
          key: key,
          child: ScrollToHideNavbar(
            controller: ScrollController(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 50,
                      child: HorizontalMultiSelect<Association>(
                        items: myAssociations,
                        selectedItem: selectedAssociation.value,
                        onItemSelected: (association) {
                          selectedAssociation.value = association;
                        },
                        itemBuilder: (context, association, index, selected) =>
                            Text(
                              association.name,
                              style: TextStyle(
                                color: selected
                                    ? ColorConstants.background
                                    : ColorConstants.tertiary,
                                fontSize: 16,
                              ),
                            ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextEntry(
                      label: localizeWithContext.feedTitle,
                      controller: titleController,
                    ),
                    const SizedBox(height: 10),
                    CheckBoxEntry(
                      title: localizeWithContext.eventAllDay,
                      valueNotifier: allDay,
                      onChanged: () {
                        allDay.value = !allDay.value;
                        startDateController.text = "";
                        endDateController.text = "";
                        // recurrenceEndDateController.text = "";
                      },
                    ),

                    // const SizedBox(height: 10),
                    // CheckBoxEntry(
                    //   title: localizeWithContext.eventRecurrence,
                    //   valueNotifier: recurrentController,
                    //   onChanged: () {
                    //     startDateController.text = "";
                    //     endDateController.text = "";
                    //     recurrenceEndDateController.text = "";
                    //   },
                    // ),
                    // const SizedBox(height: 0),
                    // recurrentController.value
                    //     ? Column(
                    //         children: [
                    //           Column(
                    //             children: [
                    //               Text(
                    //                 AppLocalizations.of(
                    //                   context,
                    //                 )!.eventRecurrenceDays,
                    //                 style: const TextStyle(color: Colors.black),
                    //               ),
                    //               const SizedBox(height: 10),
                    //               Column(
                    //                 children: eventDayKeys.asMap().entries.map((
                    //                   entry,
                    //                 ) {
                    //                   final index = entry.key;
                    //                   final key = entry.value;
                    //                   final localizedLabel = getLocalizedEventDay(
                    //                     context,
                    //                     key,
                    //                   );

                    //                   return GestureDetector(
                    //                     onTap: () =>
                    //                         selectedDaysNotifier.toggle(index),
                    //                     behavior: HitTestBehavior.opaque,
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text(
                    //                           localizedLabel,
                    //                           style: TextStyle(
                    //                             color: Colors.grey.shade700,
                    //                             fontSize: 16,
                    //                           ),
                    //                         ),
                    //                         Checkbox(
                    //                           checkColor: Colors.white,
                    //                           activeColor: Colors.black,
                    //                           value: selectedDays[index],
                    //                           onChanged: (_) =>
                    //                               selectedDaysNotifier.toggle(
                    //                                 index,
                    //                               ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   );
                    //                 }).toList(),
                    //               ),
                    //               const SizedBox(height: 20),
                    //               Text(
                    //                 localizeWithContext.eventInterval,
                    //                 style: const TextStyle(color: Colors.black),
                    //               ),
                    //               const SizedBox(height: 10),
                    //               TextEntry(
                    //                 label: AppLocalizations.of(
                    //                   context,
                    //                 )!.eventInterval,
                    //                 controller: interval,
                    //                 prefix: AppLocalizations.of(
                    //                   context,
                    //                 )!.eventEventEvery,
                    //                 suffix: AppLocalizations.of(
                    //                   context,
                    //                 )!.eventWeeks,
                    //                 isInt: true,
                    //                 keyboardType: TextInputType.number,
                    //               ),
                    //               const SizedBox(height: 30),
                    //               if (!allDay.value)
                    //                 Column(
                    //                   children: [
                    //                     DateEntry(
                    //                       onTap: () => getOnlyHourDate(
                    //                         context,
                    //                         startDateController,
                    //                       ),
                    //                       controller: startDateController,
                    //                       label: AppLocalizations.of(
                    //                         context,
                    //                       )!.eventStartHour,
                    //                     ),
                    //                     const SizedBox(height: 30),
                    //                     DateEntry(
                    //                       onTap: () => getOnlyHourDate(
                    //                         context,
                    //                         endDateController,
                    //                       ),
                    //                       controller: endDateController,
                    //                       label: AppLocalizations.of(
                    //                         context,
                    //                       )!.eventEndHour,
                    //                     ),
                    //                     const SizedBox(height: 30),
                    //                   ],
                    //                 ),
                    //               DateEntry(
                    //                 onTap: () => getOnlyDayDate(
                    //                   context,
                    //                   recurrenceEndDate,
                    //                 ),
                    //                 controller: recurrenceEndDate,
                    //                 label: AppLocalizations.of(
                    //                   context,
                    //                 )!.eventRecurrenceEndDate,
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       )
                    // :
                    DateEntry(
                      onTap: () => allDay.value
                          ? getOnlyDayDate(context, startDateController)
                          : getFullDate(context, startDateController),
                      controller: startDateController,
                      label: localizeWithContext.eventStartDate,
                    ),
                    const SizedBox(height: 10),
                    DateEntry(
                      onTap: () => allDay.value
                          ? getOnlyDayDate(context, endDateController)
                          : getFullDate(context, endDateController),
                      controller: endDateController,
                      label: localizeWithContext.eventEndDate,
                    ),
                    SizedBox(height: 10),
                    TextEntry(
                      label: localizeWithContext.feedLocation,
                      controller: locationController,
                    ),
                    SizedBox(height: 10),
                    DateEntry(
                      onTap: () => getFullDate(context, shotgunDateController),
                      controller: shotgunDateController,
                      label: localizeWithContext.feedSGDate,
                      canBeEmpty: true,
                    ),
                    SizedBox(height: 10),
                    TextEntry(
                      label: localizeWithContext.feedSGExternalLink,
                      controller: externalLinkController,
                      canBeEmpty: true,
                    ),
                    const SizedBox(height: 10),
                    CheckBoxEntry(
                      title: localizeWithContext.feedNotification,
                      valueNotifier: notification,
                      onChanged: () {
                        notification.value = !notification.value;
                      },
                    ),
                    const SizedBox(height: 10),
                    FormField<File>(
                      builder: (formFieldState) => Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ImagePickerOnTap(
                              picker: picker,
                              imageBytesNotifier: poster,
                              imageNotifier: posterFile,
                              displayToastWithContext: displayToastWithContext,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: formFieldState.hasError
                                          ? Colors.red
                                          : Colors.black.withValues(alpha: 0.1),
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                      offset: const Offset(2, 3),
                                    ),
                                  ],
                                ),
                                child: posterFile.value != null
                                    ? Stack(
                                        children: [
                                          Container(
                                            width: 285,
                                            height: 160,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                              image: DecorationImage(
                                                image: poster.value != null
                                                    ? Image.memory(
                                                        poster.value!,
                                                        fit: BoxFit.cover,
                                                      ).image
                                                    : posterFile.value!.image,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: Center(
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                        Radius.circular(5),
                                                      ),
                                                  color: Colors.white
                                                      .withValues(alpha: 0.4),
                                                ),
                                                child: HeroIcon(
                                                  HeroIcons.photo,
                                                  size: 40,
                                                  color: Colors.black
                                                      .withValues(alpha: 0.5),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(
                                        width: 285,
                                        height: 160,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                        ),
                                        child: const HeroIcon(
                                          HeroIcons.photo,
                                          size: 160,
                                          color: Colors.grey,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    WaitingButton(
                      child: Text(
                        localizeWithContext.feedCreateEvent,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      builder: (child) => Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstants.tertiary,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ColorConstants.onTertiary),
                        ),
                        child: Center(child: child),
                      ),
                      onTap: () async {
                        if (key.currentState == null) {
                          return;
                        }
                        if (selectedAssociation.value == null) {
                          displayToastWithContext(
                            TypeMsg.error,
                            localizeWithContext.feedPleaseSelectAnAssociation,
                          );
                          return;
                        }
                        if (externalLinkController.text.isEmpty &&
                            shotgunDateController.text.isNotEmpty) {
                          displayToastWithContext(
                            TypeMsg.error,
                            localizeWithContext
                                .feedPleaseProvideASGExternalLink,
                          );
                          return;
                        }
                        if (externalLinkController.text.isNotEmpty &&
                            shotgunDateController.text.isEmpty) {
                          displayToastWithContext(
                            TypeMsg.error,
                            localizeWithContext.feedPleaseProvideASGDate,
                          );
                          return;
                        }
                        if (key.currentState!.validate()) {
                          // if (allDay.value) {
                          //   startDateController.text =
                          //       "${!recurrentController.value ? "${startDateController.text} " : ""}00:00";
                          //   endDateController.text =
                          //       "${!recurrentController.value ? "${endDateController.text} " : ""}23:59";
                          // }
                          if (endDateController.text.contains("/") &&
                              isDateBefore(
                                processDateBackWithHourMaybe(
                                  endDateController.text,
                                  locale.toString(),
                                ),
                                processDateBackWithHourMaybe(
                                  startDateController.text,
                                  locale.toString(),
                                ),
                              )) {
                            displayToast(
                              context,
                              TypeMsg.error,
                              localizeWithContext.eventInvalidDates,
                            );
                            // } else if (recurrentController.value &&
                            //     selectedDays.where((element) => element).isEmpty) {
                            //   displayToast(
                            //     context,
                            //     TypeMsg.error,
                            //     localizeWithContext.eventNoDaySelected,
                            //   );
                          } else {
                            await tokenExpireWrapper(ref, () async {
                              // String recurrenceRule = "";
                              // String startString = startDateController.text;
                              // if (!startString.contains("/")) {
                              //   startString = "${DateFormat.yMd(locale).format(now)} $startString";
                              // }
                              // String endString = endDateController.text;
                              // if (!endString.contains("/")) {
                              //   endString = "${DateFormat.yMd(locale).format(now)} $endString";
                              // }
                              // if (recurrentController.value) {
                              //   RecurrenceProperties recurrence =
                              //       RecurrenceProperties(startDate: now);
                              //   recurrence.recurrenceType = RecurrenceType.weekly;
                              //   recurrence.recurrenceRange =
                              //       RecurrenceRange.endDate;
                              //   recurrence.endDate = DateTime.parse(
                              //     processDateBack(recurrenceEndDate.text),
                              //   );
                              //   recurrence.weekDays = WeekDays.values
                              //       .where(
                              //         (element) =>
                              //             selectedDays[(WeekDays.values.indexOf(
                              //                       element,
                              //                     ) -
                              //                     1) %
                              //                 7],
                              //       )
                              //       .toList();
                              //   recurrence.interval = int.parse(interval.text);
                              //   recurrenceRule = SfCalendar.generateRRule(
                              //     recurrence,
                              //     DateTime.parse(
                              //       processDateBackWithHour(startString),
                              //     ),
                              //     DateTime.parse(
                              //       processDateBackWithHour(endString),
                              //     ),
                              //   );
                              // }
                              final newEvent = Event(
                                id: "",
                                start: DateTime.parse(
                                  processDateBackWithHourMaybe(
                                    startDateController.text,
                                    locale.toString(),
                                  ),
                                ),
                                end: DateTime.parse(
                                  processDateBackWithHourMaybe(
                                    endDateController.text,
                                    locale.toString(),
                                  ),
                                ),
                                location: locationController.text,
                                ticketUrlOpening:
                                    shotgunDateController.text != ""
                                    ? DateTime.parse(
                                        processDateBackWithHourMaybe(
                                          shotgunDateController.text,
                                          locale.toString(),
                                        ),
                                      )
                                    : null,
                                name: titleController.text,
                                allDay: allDay.value,
                                // recurrenceRule: recurrenceRule,
                                recurrenceRule: "",
                                associationId: selectedAssociation.value!.id,
                                ticketUrl: externalLinkController.text,
                                notification: notification.value,
                              );
                              try {
                                final eventCreated = await eventCreationNotifier
                                    .addEvent(newEvent);
                                if (poster.value == null) {
                                  QR.back();
                                  displayToastWithContext(
                                    TypeMsg.msg,
                                    localizeWithContext.eventAddedEvent,
                                  );
                                  newsListNotifier.loadNewsList();
                                  return;
                                }
                                final value = await eventImageNotifier
                                    .addEventImage(
                                      eventCreated.id,
                                      poster.value!,
                                    );
                                if (value) {
                                  QR.back();
                                  displayToastWithContext(
                                    TypeMsg.msg,
                                    localizeWithContext.eventAddedEvent,
                                  );
                                  newsListNotifier.loadNewsList();
                                } else {
                                  displayToastWithContext(
                                    TypeMsg.error,
                                    localizeWithContext.eventAddingError,
                                  );
                                }
                              } catch (e) {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  localizeWithContext.eventAddingError,
                                );
                              }
                            });
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
