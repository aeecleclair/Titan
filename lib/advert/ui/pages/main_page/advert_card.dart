import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AdvertCard extends StatelessWidget {
  final VoidCallback onTap;

  const AdvertCard({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0, 0.3),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.network(
                'https://picsum.photos/seed/664/600',
              ).image,
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                color: Color(0x33000000),
                offset: Offset(2, 2),
                spreadRadius: 3,
              )
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0x58000000),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 10, 0),
                                child: AutoSizeText(
                                  'C\'est le super titre de mon annonce !',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  minFontSize: 20,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 2),
                                  child: Text(
                                    '25/05/2003',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 2, 0, 0),
                                  child: Text(
                                    'Auteur',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5, 0, 5, 0),
                            child: Container(
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 0),
                                  child: Text(
                                    'Mon tag',
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5, 0, 5, 0),
                            child: Container(
                              height: 20,
                              decoration: BoxDecoration(
                                color:  Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 0),
                                  child: Text(
                                    'Second tag',
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                          child: Text(
                              overflow: TextOverflow.fade,
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce commodo urna quis sem varius porttitor. Cras pretium purus lacus, non tempor enim pharetra id. Curabitur aliquet, ipsum nec volutpat gravida, dui ipsum finibus elit, sed tristique nulla velit vel massa. Proin quis leo vitae augue semper suscipit. Sed nec magna in leo congue sagittis ac vitae arcu. Vivamus scelerisque auctor mauris, vitae ultricies justo mattis eget. Cras nisl ante, rutrum ac eros vitae, ullamcorper pretium nibh. Nulla scelerisque tincidunt placerat. Sed dictum, sem ac aliquet commodo, est arcu tristique ex, ut laoreet nulla libero vel lorem.\n\nMorbi nec ligula eu lorem malesuada gravida eu nec neque. Duis fringilla tincidunt nisi id pulvinar. Nam lobortis fringilla elementum. Praesent vitae accumsan erat. Etiam porttitor auctor volutpat. Nunc non magna eget dolor cursus vehicula sed id quam. Suspendisse luctus accumsan justo ac molestie. Nam laoreet erat enim, sed sollicitudin tellus sodales non. Aliquam tincidunt ex pharetra arcu fermentum, ac consequat felis porttitor. Proin sed pulvinar libero. Curabitur magna velit, dapibus ac ultrices a, scelerisque at diam. Vivamus ac gravida risus. Morbi bibendum vehicula leo sed mollis. Quisque imperdiet faucibus viverra. Aenean vestibulum bibendum massa, consequat tempus lectus volutpat quis. Quisque congue sem diam, sit amet laoreet magna blandit vitae.\n\nPellentesque sit amet magna nec ante tempus tempor quis vel magna. Nullam aliquet ligula dolor, iaculis lobortis magna sodales sed. Nunc quam orci, dignissim eu feugiat quis, gravida sit amet eros. Duis at ante ut sapien sodales volutpat fringilla in mi. Aliquam feugiat pulvinar ligula, id elementum leo semper aliquet. Fusce semper dui libero, eu iaculis dui bibendum quis. Fusce malesuada vulputate sagittis. Nulla faucibus, leo et aliquam suscipit, mauris tortor pellentesque justo, sit amet facilisis enim massa eget lacus. Praesent ultrices dui at elit commodo cursus. Donec in leo felis. Maecenas convallis quis lorem mollis vehicula. Nulla facilisi. Nam bibendum eleifend blandit. Aliquam semper eleifend erat ut congue.\n\nDuis mollis, sem vel sollicitudin interdum, eros neque posuere tortor, sit amet ullamcorper ipsum turpis nec nisl. Aenean hendrerit lacinia ex eu venenatis. Quisque euismod arcu elit, et lobortis ligula ultricies quis. Donec aliquet, libero at sodales convallis, nulla nisl consequat neque, a rhoncus arcu felis vitae dolor. Suspendisse commodo rutrum tortor. Nulla facilisi. Maecenas sed nunc ornare, vulputate metus sed, blandit ex. Sed quis pharetra ipsum. Aliquam nec velit sapien. Nulla rutrum iaculis odio, eu volutpat turpis venenatis ac. Nullam sollicitudin mauris vitae ligula commodo, varius euismod turpis ornare. Duis lacinia luctus sem, a volutpat justo ultrices vel.\n\nDonec vulputate augue nisl, sit amet hendrerit mi condimentum eu. Nam pretium purus at leo consequat, ac varius nibh tristique. Morbi tristique ullamcorper mollis. Etiam nec augue nulla. Fusce lectus dui, consequat sit amet mauris id, convallis accumsan odio. Vivamus vitae efficitur mi, non iaculis tortor. Morbi malesuada porttitor malesuada. Integer pulvinar arcu tortor, sed pharetra ipsum sagittis eu. Donec feugiat egestas est, sed ultricies nulla malesuada sit amet. Etiam porta porttitor consequat. Curabitur interdum nibh massa, at rutrum urna aliquet eu. Nulla ac orci ut orci maximus mattis. Donec rhoncus non lectus a rhoncus. Mauris ac luctus enim. Ut ultrices pharetra arcu egestas rhoncus. Nullam lacus nulla, iaculis aliquam porttitor ac, lobortis sed quam. ',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              )),
                        ),
                      ),
                    ),
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
