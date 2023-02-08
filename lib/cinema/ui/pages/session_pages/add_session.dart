import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/cinema/class/session.dart';
import 'package:myecl/cinema/providers/cinema_page_provider.dart';
import 'package:myecl/cinema/providers/session_list_provider.dart';
import 'package:myecl/cinema/tools/constants.dart';
import 'package:myecl/cinema/tools/functions.dart';
import 'package:myecl/loan/ui/text_entry.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AddSessionPage extends HookConsumerWidget {
  const AddSessionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(cinemaPageProvider.notifier);
    final key = GlobalKey<FormState>();
    final sessionListNotifier = ref.watch(sessionListProvider.notifier);
    final name = useTextEditingController();
    final duration = useTextEditingController();
    final genre = useTextEditingController();
    final overview = useTextEditingController();
    final posterUrl = useTextEditingController();
    final start = useTextEditingController();
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Expanded(
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: key,
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(CinemaTextConstants.addSession,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 205, 205, 205)))),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(children: [
                  (posterUrl.text.isEmpty)
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 30),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20)),
                          child: HeroIcon(
                            HeroIcons.camera,
                            size: 100,
                            color: Colors.grey.shade500,
                          ),
                        )
                      : Image.network(posterUrl.text, fit: BoxFit.cover),
                  const SizedBox(height: 30),
                  TextEntry(
                    keyboardType: TextInputType.text,
                    label: CinemaTextConstants.name,
                    suffix: '',
                    isInt: false,
                    controller: name,
                  ),
                  const SizedBox(height: 30),
                  TextEntry(
                    keyboardType: TextInputType.text,
                    label: CinemaTextConstants.posterUrl,
                    suffix: '',
                    isInt: false,
                    controller: posterUrl,
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () => _selectDate(context, start),
                    child: SizedBox(
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: start,
                          decoration: const InputDecoration(
                            labelText: CinemaTextConstants.sessionDate,
                            floatingLabelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return CinemaTextConstants.noDateError;
                            }
                            return null;
                          },
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () => _selectOnlyHour(context, duration),
                    child: SizedBox(
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: duration,
                          decoration: const InputDecoration(
                            labelText: CinemaTextConstants.duration,
                            floatingLabelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return CinemaTextConstants.noDuration;
                            }
                            return null;
                          },
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextEntry(
                    keyboardType: TextInputType.text,
                    label: CinemaTextConstants.genre,
                    suffix: '',
                    isInt: false,
                    controller: genre,
                  ),
                  const SizedBox(height: 30),
                  TextEntry(
                    keyboardType: TextInputType.text,
                    label: CinemaTextConstants.overview,
                    suffix: '',
                    isInt: false,
                    controller: overview,
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      if (key.currentState == null) {
                        return;
                      }
                      if (key.currentState!.validate()) {
                        tokenExpireWrapper(ref, () async {
                            final value = await sessionListNotifier.addSession(
                              Session(
                                name: name.text,
                                duration: parseDuration(duration.text),
                                genre: genre.text,
                                id: '',
                                overview: overview.text,
                                posterUrl: posterUrl.text,
                                start: DateTime.parse(
                                    processDateBackWithHour(start.text)),
                                tagline: '',
                              ),
                            );
                            if (value) {
                              pageNotifier.setCinemaPage(CinemaPage.admin);
                              displayToastWithContext(TypeMsg.msg,
                                  CinemaTextConstants.addedSession);
                            } else {
                              displayToastWithContext(TypeMsg.error,
                                  CinemaTextConstants.addingError);
                            }
                        });
                      } else {
                        displayToast(context, TypeMsg.error,
                            CinemaTextConstants.incorrectOrMissingFields);
                      }
                    },
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 8, bottom: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(
                                  3, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Text(CinemaTextConstants.add,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold))),
                  ),
                  const SizedBox(height: 20),
                ]),
              )
            ]),
          )),
    );
  }
}

_selectDate(BuildContext context, TextEditingController dateController) async {
  final DateTime now = DateTime.now();
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1, now.month, now.day),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 10, 153, 172),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      });
  if (picked != null) {
    final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(picked),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(255, 10, 153, 172),
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });
    dateController.text = DateFormat('dd/MM/yyyy HH:mm')
        .format(DateTimeField.combine(picked, time));
  } else {
    dateController.text = DateFormat('dd/MM/yyyy HH:mm').format(now);
  }
}

_selectOnlyHour(
    BuildContext context, TextEditingController dateController) async {
  const TimeOfDay now = TimeOfDay(hour: 0, minute: 0);
  final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: now,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 10, 153, 172),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      });
  dateController.text =
      DateFormat('HH:mm').format(DateTimeField.combine(DateTime.now(), picked));
}
