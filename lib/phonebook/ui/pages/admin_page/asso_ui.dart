import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/providers/association_picture_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class AssoUi extends HookConsumerWidget {
  final Association association;
  final void Function() onEdit;
  final Future Function() onDelete;
  const AssoUi(
      {super.key,
      required this.association,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationPicture =
        ref.watch(associationPictureProvider);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 2)
          ]),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          associationPicture.when(data: (picture){
                return CircleAvatar(
                radius: 80,
                backgroundImage: picture.isEmpty ?
                const AssetImage('assets/images/profile.png') :
                Image.memory(picture).image,
              );
              }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }, error: (e, s) {
              return const Center(
                child: Text(PhonebookTextConstants.errorLoadAssociationPicture),
              );
            }, 
            ),
          Expanded(
            child: Text(
              association.name,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: onEdit,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.shade800,
                        Colors.grey.shade900,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade900.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(2, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const HeroIcon(
                    HeroIcons.eye,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ShrinkButton(
                  waitChild: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          ColorConstants.gradient1,
                          ColorConstants.gradient2,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.gradient2.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(2, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: onDelete,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          ColorConstants.gradient1,
                          ColorConstants.gradient2,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.gradient2.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(2, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const HeroIcon(
                      HeroIcons.xMark,
                      color: Colors.white,
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
