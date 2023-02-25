import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/providers/advert_page_provider.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(advertPageProvider);
    final pageNotifier = ref.watch(advertPageProvider.notifier);
    final tags = [
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
        child: Container(
          height: 20,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
              child: Text(
                'Mon tag',
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
        child: Container(
          height: 20,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
              child: Text(
                'Second tag',
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      )
    ];
    return Stack(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 7,
                  offset: Offset(0, 5),
                ),
              ]),
              child: Image(
                image: Image.network(
                  'https://picsum.photos/seed/664/600',
                ).image,
                fit: BoxFit.fill,
              ),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 45,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (page == AdvertPage.detailFromMainPage) {
                            pageNotifier.setAdvertPage(AdvertPage.main);
                          } else {
                            pageNotifier.setAdvertPage(AdvertPage.admin);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  blurRadius: 10,
                                  spreadRadius: 7,
                                  offset: const Offset(0, 5),
                                ),
                              ]),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const HeroIcon(
                                HeroIcons.calendar,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text('25/02/2023',
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 140,
                  ),
                  Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color.fromARGB(0, 255, 255, 255),
                          Colors.grey.shade50.withOpacity(0.85),
                          Colors.grey.shade50,
                        ],
                        stops: const [0.0, 0.65, 1.0],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey.shade50,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            'C\'est le super titre de mon annonce !',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Auteur',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 35,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: tags.length + 2,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0 || index == tags.length + 1) {
                                return const SizedBox(
                                  width: 20,
                                );
                              } else {
                                return tags[index - 1];

                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce commodo urna quis sem varius porttitor. Cras pretium purus lacus, non tempor enim pharetra id. Curabitur aliquet, ipsum nec volutpat gravida, dui ipsum finibus elit, sed tristique nulla velit vel massa. Proin quis leo vitae augue semper suscipit. Sed nec magna in leo congue sagittis ac vitae arcu. Vivamus scelerisque auctor mauris, vitae ultricies justo mattis eget. Cras nisl ante, rutrum ac eros vitae, ullamcorper pretium nibh. Nulla scelerisque tincidunt placerat. Sed dictum, sem ac aliquet commodo, est arcu tristique ex, ut laoreet nulla libero vel lorem.\n\nMorbi nec ligula eu lorem malesuada gravida eu nec neque. Duis fringilla tincidunt nisi id pulvinar. Nam lobortis fringilla elementum. Praesent vitae accumsan erat. Etiam porttitor auctor volutpat. Nunc non magna eget dolor cursus vehicula sed id quam. Suspendisse luctus accumsan justo ac molestie. Nam laoreet erat enim, sed sollicitudin tellus sodales non. Aliquam tincidunt ex pharetra arcu fermentum, ac consequat felis porttitor. Proin sed pulvinar libero. Curabitur magna velit, dapibus ac ultrices a, scelerisque at diam. Vivamus ac gravida risus. Morbi bibendum vehicula leo sed mollis. Quisque imperdiet faucibus viverra. Aenean vestibulum bibendum massa, consequat tempus lectus volutpat quis. Quisque congue sem diam, sit amet laoreet magna blandit vitae.\n\nPellentesque sit amet magna nec ante tempus tempor quis vel magna. Nullam aliquet ligula dolor, iaculis lobortis magna sodales sed. Nunc quam orci, dignissim eu feugiat quis, gravida sit amet eros. Duis at ante ut sapien sodales volutpat fringilla in mi. Aliquam feugiat pulvinar ligula, id elementum leo semper aliquet. Fusce semper dui libero, eu iaculis dui bibendum quis. Fusce malesuada vulputate sagittis. Nulla faucibus, leo et aliquam suscipit, mauris tortor pellentesque justo, sit amet facilisis enim massa eget lacus. Praesent ultrices dui at elit commodo cursus. Donec in leo felis. Maecenas convallis quis lorem mollis vehicula. Nulla facilisi. Nam bibendum eleifend blandit. Aliquam semper eleifend erat ut congue.\n\nDuis mollis, sem vel sollicitudin interdum, eros neque posuere tortor, sit amet ullamcorper ipsum turpis nec nisl. Aenean hendrerit lacinia ex eu venenatis. Quisque euismod arcu elit, et lobortis ligula ultricies quis. Donec aliquet, libero at sodales convallis, nulla nisl consequat neque, a rhoncus arcu felis vitae dolor. Suspendisse commodo rutrum tortor. Nulla facilisi. Maecenas sed nunc ornare, vulputate metus sed, blandit ex. Sed quis pharetra ipsum. Aliquam nec velit sapien. Nulla rutrum iaculis odio, eu volutpat turpis venenatis ac. Nullam sollicitudin mauris vitae ligula commodo, varius euismod turpis ornare. Duis lacinia luctus sem, a volutpat justo ultrices vel.\n\nDonec vulputate augue nisl, sit amet hendrerit mi condimentum eu. Nam pretium purus at leo consequat, ac varius nibh tristique. Morbi tristique ullamcorper mollis. Etiam nec augue nulla. Fusce lectus dui, consequat sit amet mauris id, convallis accumsan odio. Vivamus vitae efficitur mi, non iaculis tortor. Morbi malesuada porttitor malesuada. Integer pulvinar arcu tortor, sed pharetra ipsum sagittis eu. Donec feugiat egestas est, sed ultricies nulla malesuada sit amet. Etiam porta porttitor consequat. Curabitur interdum nibh massa, at rutrum urna aliquet eu. Nulla ac orci ut orci maximus mattis. Donec rhoncus non lectus a rhoncus. Mauris ac luctus enim. Ut ultrices pharetra arcu egestas rhoncus. Nullam lacus nulla, iaculis aliquam porttitor ac, lobortis sed quam. ",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
