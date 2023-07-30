import 'dart:io';
import 'dart:typed_data';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/cinema/class/session/session.dart';
import 'package:myecl/cinema/providers/session_list_provider.dart';
import 'package:myecl/cinema/providers/session_poster_map_provider.dart';
import 'package:myecl/cinema/providers/session_poster_provider.dart';
import 'package:myecl/cinema/providers/session_provider.dart';
import 'package:myecl/cinema/providers/the_movie_db_genre_provider.dart';
import 'package:myecl/cinema/tools/constants.dart';
import 'package:myecl/cinema/tools/functions.dart';
import 'package:myecl/cinema/ui/cinema.dart';
import 'package:myecl/cinema/ui/text_entry.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditSessionPage extends HookConsumerWidget {
  const AddEditSessionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final movieNotifier = ref.watch(theMovieDBMovieProvider.notifier);
    final isEdit = session.id != Session.empty().id;
    final imdbUrl = useTextEditingController();
    final key = GlobalKey<FormState>();
    final sessionListNotifier = ref.watch(sessionListProvider.notifier);
    final sessionList = ref.watch(sessionListProvider);
    final name = useTextEditingController(text: session.name);
    final duration = useTextEditingController(
        text: isEdit ? parseDurationBack(session.duration) : '');
    final genre = useTextEditingController(text: session.genre ?? '');
    final overview = useTextEditingController(text: session.overview ?? '');
    final start = useTextEditingController(
        text: isEdit ? processDateWithHour(session.start) : '');
    final tagline = useTextEditingController(text: session.tagline ?? '');
    final sessionPosterMap = ref.watch(sessionPosterMapProvider);
    final logo = useState<Uint8List?>(null);
    final logoFile = useState<Image?>(null);
    final posterUrl = useTextEditingController();
    final sessionPosterNotifier = ref.watch(sessionPosterProvider.notifier);

    sessionPosterMap.whenData((value) {
      if (value[session] != null) {
        value[session]!.whenData((data) {
          if (data.isNotEmpty) {
            logoFile.value = data.first;
          }
        });
      }
    });

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return CinemaTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: key,
              child: Column(children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        isEdit
                            ? CinemaTextConstants.editSession
                            : CinemaTextConstants.addSession,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 149, 149, 149)))),
                const SizedBox(height: 30),
                TextField(
                  controller: imdbUrl,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelText: CinemaTextConstants.importFromIMDB,
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 20),
                    suffixIcon: Container(
                      padding: const EdgeInsets.all(10),
                      child: ShrinkButton(
                        onTap: () async {
                          if (imdbUrl.text.isEmpty) {
                            displayToastWithContext(
                                TypeMsg.error, CinemaTextConstants.emptyUrl);
                            return;
                          }
                          if (!imdbUrl.text.contains('imdb.com/title/')) {
                            displayToastWithContext(
                                TypeMsg.error, CinemaTextConstants.invalidUrl);
                            return;
                          }
                          final movieId = imdbUrl.text
                              .split('imdb.com/title/')
                              .last
                              .split('/')
                              .first;
                          tokenExpireWrapper(ref, () async {
                            movieNotifier.loadMovie(movieId).then((value) {
                              value.when(
                                data: (data) async {
                                  name.text = data.title;
                                  overview.text = data.overview;
                                  posterUrl.text = data.posterUrl;
                                  genre.text = data.genres.join(', ');
                                  tagline.text = data.tagline;
                                  duration.text =
                                      parseDurationBack(data.runtime);
                                  logo.value = await getFromUrl(data.posterUrl);
                                },
                                loading: () {},
                                error: (e, s) {
                                  displayToastWithContext(
                                      TypeMsg.error, e.toString());
                                },
                              );
                            });
                          });
                        },
                        waitChild: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffe2b616),
                          ),
                          child: const CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffe2b616),
                          ),
                          child: const HeroIcon(
                            HeroIcons.arrowRight,
                            size: 22,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                (logo.value == null)
                    ? logoFile.value == null
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
                        : Image(image: logoFile.value!.image, fit: BoxFit.cover)
                    : Image.memory(logo.value!, fit: BoxFit.cover),
                const SizedBox(height: 30),
                TextEntry(
                  keyboardType: TextInputType.text,
                  label: CinemaTextConstants.name,
                  suffix: '',
                  isInt: false,
                  controller: name,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 30),
                TextEntry(
                  keyboardType: TextInputType.text,
                  label: CinemaTextConstants.posterUrl,
                  suffix: '',
                  isInt: false,
                  controller: posterUrl,
                  onChanged: (value) async {
                    logo.value = await File(posterUrl.text).readAsBytes();
                  },
                  canBeEmpty: true,
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
                  canBeEmpty: true,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 30),
                TextEntry(
                  keyboardType: TextInputType.text,
                  label: CinemaTextConstants.overview,
                  suffix: '',
                  isInt: false,
                  controller: overview,
                  canBeEmpty: true,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 30),
                TextEntry(
                  keyboardType: TextInputType.text,
                  label: CinemaTextConstants.tagline,
                  suffix: '',
                  isInt: false,
                  controller: tagline,
                  canBeEmpty: true,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 50),
                ShrinkButton(
                  waitChild: Container(
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
                          offset:
                              const Offset(3, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    if (key.currentState == null) {
                      return;
                    }
                    if (key.currentState!.validate()) {
                      if (logo.value == null && logoFile.value == null) {
                        displayToastWithContext(
                            TypeMsg.error, CinemaTextConstants.noPoster);
                        return;
                      }
                      await tokenExpireWrapper(ref, () async {
                        Session newSession = Session(
                          name: name.text,
                          duration: parseDuration(duration.text),
                          genre: genre.text.isEmpty ? null : genre.text,
                          id: isEdit ? session.id : '',
                          overview:
                              overview.text.isEmpty ? null : overview.text,
                          start: DateTime.parse(
                              processDateBackWithHour(start.text)),
                          tagline: tagline.text.isEmpty ? null : tagline.text,
                        );
                        final value = isEdit
                            ? await sessionListNotifier
                                .updateSession(newSession)
                            : await sessionListNotifier.addSession(newSession);
                        if (value) {
                          QR.back();
                          if (isEdit) {
                            sessionList.when(
                                data: (list) async {
                                  if (logo.value != null) {
                                    final sessionPosterMapNotifier = ref.read(
                                        sessionPosterMapProvider.notifier);
                                    Future.delayed(
                                        const Duration(milliseconds: 1), () {
                                      sessionPosterMapNotifier.setTData(
                                          session, const AsyncLoading());
                                    });
                                    Image image = await sessionPosterNotifier
                                        .updateLogo(session.id, logo.value!);
                                    sessionPosterMapNotifier.setTData(
                                        session,
                                        AsyncData([
                                          Image(
                                            image: image.image,
                                            fit: BoxFit.cover,
                                          ),
                                        ]));
                                  }
                                },
                                error: (error, s) {},
                                loading: () {});
                            displayToastWithContext(
                                TypeMsg.msg, CinemaTextConstants.editedSession);
                          } else {
                            sessionList.when(
                                data: (list) async {
                                  final newPretendance = list.last;
                                  if (logo.value != null) {
                                    final sessionPosterMapNotifier = ref.read(
                                        sessionPosterMapProvider.notifier);
                                    Future.delayed(
                                        const Duration(milliseconds: 1), () {
                                      sessionPosterMapNotifier.setTData(
                                          session, const AsyncLoading());
                                    });
                                    Image image =
                                        await sessionPosterNotifier.updateLogo(
                                            newPretendance.id, logo.value!);
                                    sessionPosterMapNotifier.setTData(
                                        newPretendance,
                                        AsyncData([
                                          Image(
                                            image: image.image,
                                            fit: BoxFit.cover,
                                          )
                                        ]));
                                  }
                                },
                                error: (error, s) {},
                                loading: () {});
                            displayToastWithContext(
                                TypeMsg.msg, CinemaTextConstants.addedSession);
                          }
                        } else {
                          if (isEdit) {
                            displayToastWithContext(TypeMsg.error,
                                CinemaTextConstants.editingError);
                          } else {
                            displayToastWithContext(
                                TypeMsg.error, CinemaTextConstants.addingError);
                          }
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
                      child: Text(
                          isEdit
                              ? CinemaTextConstants.edit
                              : CinemaTextConstants.add,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold))),
                ),
                const SizedBox(height: 20),
              ]),
            )),
      ),
    );
  }
}

_selectDate(BuildContext context, TextEditingController dateController) async {
  final DateTime now = DateTime.now();
  showDatePicker(
      locale: const Locale("fr", "FR"),
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
      }).then((picked) {
    if (picked != null) {
      showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
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
          }).then((value) {
        dateController.text = DateFormat('dd/MM/yyyy HH:mm')
            .format(DateTimeField.combine(picked, value));
      });
    } else {
      dateController.text = DateFormat('dd/MM/yyyy HH:mm').format(now);
    }
  });
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
              primary: ColorConstants.gradient1,
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
