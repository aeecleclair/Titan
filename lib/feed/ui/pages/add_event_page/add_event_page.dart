import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:titan/admin/class/assocation.dart';
import 'package:titan/admin/providers/my_association_list_provider.dart';
// import 'package:titan/event/providers/selected_days_provider.dart';
// import 'package:titan/event/tools/constants.dart';
// import 'package:titan/event/tools/functions.dart';
import 'package:titan/event/ui/pages/event_pages/checkbox_entry.dart';
import 'package:titan/feed/class/event_creation.dart';
import 'package:titan/feed/providers/admin_news_list_provider.dart';
import 'package:titan/feed/providers/event_creation_provider.dart';
import 'package:titan/feed/ui/feed.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/horizontal_multi_select.dart';
import 'package:titan/tools/ui/styleguide/image_entry.dart';
import 'package:titan/tools/ui/styleguide/text_entry.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';

class AddEventPage extends HookConsumerWidget {
  const AddEventPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final myAssociations = ref.watch(myAssociationListProvider);
    final titleController = useTextEditingController();
    final locationController = useTextEditingController();
    final shotgunDateController = useTextEditingController();
    final externalLinkController = useTextEditingController();
    final startDateController = useTextEditingController();
    final endDateController = useTextEditingController();
    final allDay = useState(false);
    // final recurrentController = useState(false);
    // final recurrenceEndDateController = useTextEditingController();

    final eventCreationNotifier = ref.watch(eventCreationProvider.notifier);
    final adminNewsListNotifier = ref.watch(adminNewsListProvider.notifier);
    // final interval = useTextEditingController();
    // final recurrenceEndDate = useTextEditingController();
    // final selectedDays = ref.watch(selectedDaysProvider);
    // final selectedDaysNotifier = ref.watch(selectedDaysProvider.notifier);
    // final now = DateTime.now();
    final selectedAssociation = useState<Association?>(null);


    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

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
                    AsyncChild(
                      value: myAssociations,
                      builder: (context, associations) => SizedBox(
                        height: 50,
                        child: HorizontalMultiSelect<Association>(
                          items: associations,
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
                    ),
                    const SizedBox(height: 10),
                    TextEntry(label: "Titre", controller: titleController),
                    const SizedBox(height: 10),
                    CheckBoxEntry(
                      title: AppLocalizations.of(context)!.eventAllDay,
                      valueNotifier: allDay,
                      onChanged: () {
                        startDateController.text = "";
                        endDateController.text = "";
                        // recurrenceEndDateController.text = "";
                      },
                    ),
                    // const SizedBox(height: 10),
                    // CheckBoxEntry(
                    //   title: AppLocalizations.of(context)!.eventRecurrence,
                    //   valueNotifier: recurrentController,
                    //   onChanged: () {
                    //     startDateController.text = "";
                    //     endDateController.text = "";
                    //     recurrenceEndDateController.text = "";
                    //   },
                    // ),
            
                    const SizedBox(height: 30),
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
                    //                 AppLocalizations.of(context)!.eventInterval,
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
                        Column(
                            children: [
                              DateEntry(
                                onTap: () => allDay.value
                                    ? getOnlyDayDate(context, startDateController)
                                    : getFullDate(context, startDateController),
                                controller: startDateController,
                                label: AppLocalizations.of(
                                  context,
                                )!.eventStartDate,
                              ),
                              const SizedBox(height: 30),
                              DateEntry(
                                onTap: () => allDay.value
                                    ? getOnlyDayDate(context, endDateController)
                                    : getFullDate(context, endDateController),
                                controller: endDateController,
                                label: AppLocalizations.of(context)!.eventEndDate,
                              ),
                            ],
                          ),
                    SizedBox(height: 10),
                    TextEntry(label: "Lieu", controller: locationController),
                    SizedBox(height: 10),
                    DateEntry(
                      onTap: () => getFullDate(context, shotgunDateController),
                      controller: shotgunDateController,
                      label: "Date du SG ",
                    ),
                    SizedBox(height: 10),
                    TextEntry(
                      label: "Lien externe pour le SG",
                      controller: externalLinkController,
                      canBeEmpty: true,
                    ),
                    const SizedBox(height: 10),
                    ImageEntry(
                      title: "Image",
                      subtitle: "Sélectionnez une image",
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Image ajoutée')),
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                    Button(
                      text: "Créer l'événement",
                      onPressed: () async {
                        if (key.currentState == null) {
                          return;
                        }
                        if (selectedAssociation.value == null) {
                          displayToastWithContext(
                            TypeMsg.error,
                            "Veuillez sélectionner une association"
                          );
                          return;
                        }
                        final addedEventMsg = AppLocalizations.of(
                          context,
                        )!.eventAddedEvent;
                        final addingErrorMsg = AppLocalizations.of(
                          context,
                        )!.eventAddingError;
                        if (key.currentState!.validate()) {
                          // if (allDay.value) {
                          //   startDateController.text =
                          //       "${!recurrentController.value ? "${startDateController.text} " : ""}00:00";
                          //   endDateController.text =
                          //       "${!recurrentController.value ? "${endDateController.text} " : ""}23:59";
                          // }
                          if (endDateController.text.contains("/") &&
                              isDateBefore(
                                processDateBack(endDateController.text),
                                processDateBack(startDateController.text),
                              )) {
                            displayToast(
                              context,
                              TypeMsg.error,
                              AppLocalizations.of(context)!.eventInvalidDates,
                            );
                          // } else if (recurrentController.value &&
                          //     selectedDays.where((element) => element).isEmpty) {
                          //   displayToast(
                          //     context,
                          //     TypeMsg.error,
                          //     AppLocalizations.of(context)!.eventNoDaySelected,
                          //   );
                          } else {
                            await tokenExpireWrapper(ref, () async {
                              // String recurrenceRule = "";
                              // String startString = startDateController.text;
                              // if (!startString.contains("/")) {
                              //   startString = "${processDate(now)} $startString";
                              // }
                              // String endString = endDateController.text;
                              // if (!endString.contains("/")) {
                              //   endString = "${processDate(now)} $endString";
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
                              final newEvent = EventCreation(
                                start: DateTime.parse(
                                  processDateBack(startDateController.text),
                                ),
                                end: DateTime.parse(
                                  processDateBack(endDateController.text),
                                ),
                                location: locationController.text,
                                ticketUrlOpening: DateTime.parse(
                                  processDateBack(shotgunDateController.text),
                                ),
                                name: titleController.text,
                                allDay: allDay.value,
                                // recurrenceRule: recurrenceRule,
                                recurrenceRule: "",
                                associationId: selectedAssociation.value!.id,
                                ticketUrl: externalLinkController.text,
                              );
                              final value = await eventCreationNotifier.addEvent(
                                newEvent,
                              );
                              if (value) {
                                adminNewsListNotifier.loadNewsList();
                                Navigator.of(context).pop();
                                displayToastWithContext(
                                  TypeMsg.msg,
                                  addedEventMsg,
                                );
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  addingErrorMsg,
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
