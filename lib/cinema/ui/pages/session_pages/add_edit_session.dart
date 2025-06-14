import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/cinema/class/session.dart';
import 'package:titan/cinema/providers/session_list_provider.dart';
import 'package:titan/cinema/providers/session_poster_map_provider.dart';
import 'package:titan/cinema/providers/session_poster_provider.dart';
import 'package:titan/cinema/providers/session_provider.dart';
import 'package:titan/cinema/providers/the_movie_db_genre_provider.dart';
import 'package:titan/cinema/tools/constants.dart';
import 'package:titan/cinema/tools/functions.dart';
import 'package:titan/cinema/ui/cinema.dart';
import 'package:titan/cinema/ui/pages/session_pages/tmdb_button.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditSessionPage extends HookConsumerWidget {
  const AddEditSessionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final movieNotifier = ref.watch(theMovieDBMovieProvider.notifier);
    final isEdit = session.id != Session.empty().id;
    final tmdbUrl = useTextEditingController();
    final key = GlobalKey<FormState>();
    final sessionListNotifier = ref.watch(sessionListProvider.notifier);
    final sessionList = ref.watch(sessionListProvider);
    final name = useTextEditingController(text: session.name);
    final duration = useTextEditingController(
      text: isEdit ? parseDurationBack(session.duration) : '',
    );
    final genre = useTextEditingController(text: session.genre ?? '');
    final overview = useTextEditingController(text: session.overview ?? '');
    final start = useTextEditingController(
      text: isEdit ? processDateWithHour(session.start) : '',
    );
    final tagline = useTextEditingController(text: session.tagline ?? '');
    final sessionPosterMap = ref.watch(sessionPosterMapProvider);
    final logo = useState<Uint8List?>(null);
    final logoFile = useState<Image?>(null);
    final posterUrl = useTextEditingController();
    final sessionPosterNotifier = ref.watch(sessionPosterProvider.notifier);

    if (sessionPosterMap[session.id] != null) {
      sessionPosterMap[session.id]!.whenData((data) {
        if (data.isNotEmpty) {
          logoFile.value = data.first;
        }
      });
    }

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
            child: Column(
              children: [
                AlignLeftText(
                  isEdit
                      ? CinemaTextConstants.editSession
                      : CinemaTextConstants.addSession,
                  color: Colors.grey,
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: tmdbUrl,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelText: CinemaTextConstants.importFromTMDB,
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    suffixIcon: Container(
                      padding: const EdgeInsets.all(10),
                      child: WaitingButton(
                        onTap: () async {
                          if (tmdbUrl.text.isEmpty) {
                            displayToastWithContext(
                              TypeMsg.error,
                              CinemaTextConstants.emptyUrl,
                            );
                            return;
                          }
                          try {
                            final url = Uri.parse(tmdbUrl.text);
                            final movieId = switch (url.host) {
                              "www.themoviedb.org" => url.pathSegments[1],
                              "www.imdb.com" => url.pathSegments[1],
                              _ => throw const FormatException(),
                            };
                            tokenExpireWrapper(ref, () async {
                              movieNotifier.loadMovie(movieId).then((value) {
                                value.when(
                                  data: (data) async {
                                    name.text = data.title;
                                    overview.text = data.overview;
                                    posterUrl.text = data.posterUrl;
                                    genre.text = data.genres.join(', ');
                                    tagline.text = data.tagline;
                                    duration.text = parseDurationBack(
                                      data.runtime,
                                    );
                                    logo.value = await getFromUrl(
                                      data.posterUrl,
                                    );
                                  },
                                  loading: () {},
                                  error: (e, s) {
                                    displayToastWithContext(
                                      TypeMsg.error,
                                      e.toString(),
                                    );
                                  },
                                );
                              });
                            });
                          } on FormatException catch (_) {
                            displayToastWithContext(
                              TypeMsg.error,
                              CinemaTextConstants.invalidUrl,
                            );
                            return;
                          }
                        },
                        builder: (child) => TmdbButton(child: child),
                        child: const HeroIcon(
                          HeroIcons.arrowRight,
                          size: 22,
                          color: Colors.black,
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
                                vertical: 50,
                                horizontal: 30,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: HeroIcon(
                                HeroIcons.camera,
                                size: 100,
                                color: Colors.grey.shade500,
                              ),
                            )
                          : Image(
                              image: logoFile.value!.image,
                              fit: BoxFit.cover,
                            )
                    : Image.memory(logo.value!, fit: BoxFit.cover),
                const SizedBox(height: 30),
                TextEntry(label: CinemaTextConstants.name, controller: name),
                const SizedBox(height: 30),
                TextEntry(
                  label: CinemaTextConstants.posterUrl,
                  controller: posterUrl,
                  onChanged: (value) async {
                    logo.value = await getFromUrl(posterUrl.text);
                  },
                  canBeEmpty: true,
                ),
                const SizedBox(height: 30),
                DateEntry(
                  onTap: () => getFullDate(context, start),
                  label: CinemaTextConstants.sessionDate,
                  controller: start,
                ),
                const SizedBox(height: 30),
                DateEntry(
                  onTap: () => getOnlyHourDate(context, duration),
                  label: CinemaTextConstants.duration,
                  controller: duration,
                ),
                const SizedBox(height: 30),
                TextEntry(
                  label: CinemaTextConstants.genre,
                  controller: genre,
                  canBeEmpty: true,
                ),
                const SizedBox(height: 30),
                TextEntry(
                  label: CinemaTextConstants.overview,
                  controller: overview,
                  canBeEmpty: true,
                ),
                const SizedBox(height: 30),
                TextEntry(
                  label: CinemaTextConstants.tagline,
                  controller: tagline,
                  canBeEmpty: true,
                ),
                const SizedBox(height: 50),
                WaitingButton(
                  builder: (child) => AddEditButtonLayout(child: child),
                  onTap: () async {
                    if (key.currentState == null) {
                      return;
                    }
                    if (key.currentState!.validate()) {
                      if (logo.value == null && logoFile.value == null) {
                        displayToastWithContext(
                          TypeMsg.error,
                          CinemaTextConstants.noPoster,
                        );
                        return;
                      }
                      await tokenExpireWrapper(ref, () async {
                        Session newSession = Session(
                          name: name.text,
                          duration: parseDuration(duration.text),
                          genre: genre.text.isEmpty ? null : genre.text,
                          id: isEdit ? session.id : '',
                          overview: overview.text.isEmpty
                              ? null
                              : overview.text,
                          start: DateTime.parse(
                            processDateBackWithHour(start.text),
                          ),
                          tagline: tagline.text.isEmpty ? null : tagline.text,
                        );
                        final value = isEdit
                            ? await sessionListNotifier.updateSession(
                                newSession,
                              )
                            : await sessionListNotifier.addSession(newSession);
                        if (value) {
                          QR.back();
                          if (isEdit) {
                            sessionList.maybeWhen(
                              data: (list) async {
                                final logoBytes = logo.value;
                                if (logoBytes != null) {
                                  final sessionPosterMapNotifier = ref.read(
                                    sessionPosterMapProvider.notifier,
                                  );
                                  sessionPosterMapNotifier.autoLoad(
                                    ref,
                                    session.id,
                                    (sessionId) => sessionPosterNotifier
                                        .updateLogo(sessionId, logoBytes),
                                  );
                                }
                              },
                              orElse: () {},
                            );
                            displayToastWithContext(
                              TypeMsg.msg,
                              CinemaTextConstants.editedSession,
                            );
                          } else {
                            sessionList.maybeWhen(
                              data: (list) async {
                                final newSession = list.last;
                                final logoBytes = logo.value;
                                if (logoBytes != null) {
                                  final sessionPosterMapNotifier = ref.read(
                                    sessionPosterMapProvider.notifier,
                                  );
                                  sessionPosterMapNotifier.autoLoad(
                                    ref,
                                    newSession.id,
                                    (sessionId) => sessionPosterNotifier
                                        .updateLogo(sessionId, logoBytes),
                                  );
                                }
                              },
                              orElse: () {},
                            );
                            displayToastWithContext(
                              TypeMsg.msg,
                              CinemaTextConstants.addedSession,
                            );
                          }
                        } else {
                          if (isEdit) {
                            displayToastWithContext(
                              TypeMsg.error,
                              CinemaTextConstants.editingError,
                            );
                          } else {
                            displayToastWithContext(
                              TypeMsg.error,
                              CinemaTextConstants.addingError,
                            );
                          }
                        }
                      });
                    } else {
                      displayToast(
                        context,
                        TypeMsg.error,
                        CinemaTextConstants.incorrectOrMissingFields,
                      );
                    }
                  },
                  child: Text(
                    isEdit ? CinemaTextConstants.edit : CinemaTextConstants.add,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
