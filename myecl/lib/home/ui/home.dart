import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/home/ui/last_info.dart';
import 'package:myecl/home/ui/todays_events.dart';
import 'package:myecl/home/ui/top_bar.dart';


class Home extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const Home({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> days = ["L", "M", "M", "J", "V", "S", "D"];
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 1, 49, 68),
              Color.fromARGB(255, 2, 84, 104),
            ],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              TopBar(controllerNotifier: controllerNotifier),
              const TodaysEvents(),
              const LastInfos(),
            ],
          ),
        )));
  }
}

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   _AccueilState createState() => _AccueilState();
// }

// class _AccueilState extends State<Home> {
//   List<Res> res = [
//     Res(
//         title: "Réu 1",
//         h: 8,
//         l: 1,
//         color: const Color.fromARGB(255, 35, 146, 72)),
//     Res(
//         title: "Réu 2",
//         h: 9,
//         l: 1.5,
//         color: const Color.fromARGB(255, 112, 182, 54)),
//     Res(
//         title: "Réu 3",
//         h: 15,
//         l: .5,
//         color: const Color.fromARGB(255, 37, 140, 149))
//   ];

//   Timer _timer, timer2;
//   ScrollController _scrollController;

//   List<String> days = ["L", "M", "M", "J", "V", "S", "D"];

//   DateTime today = DateTime.now();
//   // final DateTime _firstDayOfWeek = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));

//   @override
//   void initState() {
//     _scrollController = ScrollController();
//     _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
//       setState(() {
//         today = DateTime.now();
//       });
//     });
//     timer2 = Timer.periodic(const Duration(milliseconds: 1), (timer) {
//       setState(() {
//         if (_scrollController.positions.isNotEmpty) {
//           _scrollController.jumpTo(
//             (today.hour + today.minute / 60 + today.second / 3600) * 90.0 - 150,
//           );
//           timer2.cancel();
//         }
//       });
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _timer.cancel();
//     _scrollController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color.fromARGB(255, 1, 49, 68),
//                   Color.fromARGB(255, 2, 84, 104),
//                 ],
//               ),
//             ),
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Column(
//                 children: [
//                   getTopBar(),
//                   getTodaysEvent(),
//                   getLastInfo(),
//                 ],
//               ),
//             )));
//   }

//   Widget getTopBar() {
//     return Column(
//       children: [
//         const SizedBox(
//           height: 20,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(
//               width: 70,
//               child: Builder(
//                 builder: (BuildContext appBarContext) {
//                   return IconButton(
//                       onPressed: () {
//                         // Appdrawer.of(appBarContext).toggle();
//                       },
//                       icon: FaIcon(
//                         FontAwesomeIcons.chevronRight,
//                         color: Colors.grey.shade100,
//                       ));
//                 },
//               ),
//             ),
//             Text("MyECL",
//                 style: GoogleFonts.montserrat(
//                   textStyle: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.grey.shade100,
//                   ),
//                 )),
//             const SizedBox(
//               width: 70,
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//       ],
//     );
//   }

//   // Widget getTitle(String text) {
//   //   return Container(
//   //     margin: const EdgeInsets.only(top: 30, bottom: 10),
//   //     height: 30,
//   //     child: Row(
//   //       mainAxisAlignment: MainAxisAlignment.start,
//   //       children: [
//   //         const SizedBox(
//   //           width: 20,
//   //         ),
//   //         Text(
//   //           text,
//   //           style: const TextStyle(
//   //             color: Color.fromARGB(255, 15, 65, 98),
//   //             fontWeight: FontWeight.w700,
//   //             fontSize: 25,
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   // Widget getEvent(String nom, String dates, Color color1, Color color2) {
//   //   return Container(
//   //     height: 75,
//   //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//   //     decoration: BoxDecoration(
//   //       borderRadius: BorderRadius.circular(10),
//   //       gradient: LinearGradient(
//   //         colors: [color1, color2],
//   //         begin: Alignment.topLeft,
//   //         end: Alignment.bottomRight,
//   //       ),
//   //       boxShadow: [
//   //         BoxShadow(
//   //           color: color2.withOpacity(0.5),
//   //           spreadRadius: 2,
//   //           blurRadius: 3,
//   //           offset: const Offset(3, 2), // changes position of shadow
//   //         ),
//   //       ],
//   //     ),
//   //     child: Row(
//   //       mainAxisAlignment: MainAxisAlignment.start,
//   //       children: [
//   //         const SizedBox(
//   //           width: 2,
//   //         ),
//   //         Container(
//   //           width: 4,
//   //           height: 80,
//   //           margin: const EdgeInsets.all(10),
//   //           decoration: BoxDecoration(
//   //             borderRadius: BorderRadius.circular(10),
//   //             color: Colors.grey.shade100.withOpacity(0.6),
//   //           ),
//   //         ),
//   //         const SizedBox(
//   //           width: 2,
//   //         ),
//   //         Column(
//   //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //           crossAxisAlignment: CrossAxisAlignment.start,
//   //           children: [
//   //             const SizedBox(),
//   //             Text(
//   //               nom,
//   //               overflow: TextOverflow.clip,
//   //               style: TextStyle(
//   //                 fontSize: 18,
//   //                 fontWeight: FontWeight.bold,
//   //                 color: Colors.grey.shade100.withOpacity(0.8),
//   //               ),
//   //             ),
//   //             Text(
//   //               dates,
//   //               style: TextStyle(
//   //                 fontSize: 13,
//   //                 fontWeight: FontWeight.bold,
//   //                 color: Colors.grey.shade100.withOpacity(0.8),
//   //               ),
//   //             ),
//   //             const SizedBox()
//   //           ],
//   //         )
//   //       ],
//   //     ),
//   //   );
//   // }

//   // Widget getDatesColumn(String day, String date, {isToday = false}) {
//   //   return Container(
//   //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
//   //     decoration: BoxDecoration(
//   //       color: isToday ? const Color(0xffd7d0ad) : Colors.transparent,
//   //       borderRadius: BorderRadius.circular(15),
//   //     ),
//   //     child: Column(
//   //       children: [
//   //         Text(day,
//   //             style: GoogleFonts.montserrat(
//   //                 fontSize: 18,
//   //                 fontWeight: FontWeight.w400,
//   //                 color: Colors.grey.shade500)),
//   //         const SizedBox(
//   //           height: 10,
//   //         ),
//   //         Text(date,
//   //             style: GoogleFonts.montserrat(
//   //                 fontSize: 18,
//   //                 fontWeight: FontWeight.w600,
//   //                 color: Colors.grey.shade900)),
//   //       ],
//   //     ),
//   //   );
//   // }

//   List<Widget> getHourBar() {
//     List<Widget> hourBar = [];
//     for (int i = 0; i < 24; i++) {
//       hourBar.add(Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         height: 80,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 3,
//               width: 40,
//               color: Colors.grey.shade500.withOpacity(0.4),
//             ),
//             Row(
//               children: [
//                 const SizedBox(width: 40),
//                 Text("$i:00",
//                     style: GoogleFonts.montserrat(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.grey.shade700)),
//               ],
//             ),
//             Container(
//               height: 3,
//               width: 20,
//               color: Colors.grey.shade500.withOpacity(0.2),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//       ));
//     }
//     hourBar.add(
//       Container(
//         height: 3,
//         width: 40,
//         color: Colors.grey.shade500.withOpacity(0.4),
//       ),
//     );
//     return hourBar;
//   }

//   List<Widget> getHourBarItem(List<Res> res) {
//     List<Widget> hourBar = [];
//     double dh = 0;
//     double dl = 0;
//     for (Res r in res) {
//       double ph = r.h - dh;
//       hourBar.add(SizedBox(
//         height: (ph - dl) * 90.0,
//       ));
//       hourBar.add(
//         Container(
//           margin: const EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
//           width: 500,
//           height: r.l * 90.0 - 4,
//           decoration: BoxDecoration(
//             color: r.color,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Row(
//             children: [
//               const SizedBox(
//                 width: 25,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   Text(r.title,
//                       style: GoogleFonts.montserrat(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white)),
//                   const SizedBox(
//                     height: 3,
//                   ),
//                   r.l > 0.5
//                       ? Text(doubleToTime(r.l),
//                           style: GoogleFonts.montserrat(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white.withOpacity(0.5)))
//                       : const SizedBox(),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
//       dh = r.h;
//       dl = r.l;
//     }
//     return hourBar;
//   }

//   String doubleToTime(double d) {
//     int h = d.toInt();
//     int m = ((d - h) * 60).toInt();
//     String s = "";
//     s += h != 0 ? "${h}h" : "";
//     s += m != 0 ? "$m" : "";
//     s += h == 0 && m != 0 ? "min" : "";
//     return s;
//   }

//   String getMonth(int m) {
//     switch (m) {
//       case 1:
//         return "Janvier";
//       case 2:
//         return "Février";
//       case 3:
//         return "Mars";
//       case 4:
//         return "Avril";
//       case 5:
//         return "Mai";
//       case 6:
//         return "Juin";
//       case 7:
//         return "Juillet";
//       case 8:
//         return "Août";
//       case 9:
//         return "Septembre";
//       case 10:
//         return "Octobre";
//       case 11:
//         return "Novembre";
//       case 12:
//         return "Décembre";
//       default:
//         return "";
//     }
//   }

//   Widget getCurrentTime(DateTime today) {
//     return Positioned(
//       top: (today.hour + today.minute / 60 + today.second / 3600) * 90.0 -
//           6, //(today.hour + today.minute / 60 + today.second / 3600)
//       left: 0,
//       child: Row(
//         children: [
//           Container(
//             width: 15,
//             height: 15,
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(50),
//             ),
//           ),
//           Container(
//             height: 3,
//             width: 500,
//             color: Colors.black,
//           )
//         ],
//       ),
//     );
//   }

//   Widget getTodaysEvent() {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * .65,
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 30),
//         alignment: Alignment.centerLeft,
//         decoration: BoxDecoration(
//           color: Colors.grey.shade100,
//           borderRadius: const BorderRadius.all(
//             Radius.circular(30),
//           ),
//         ),
//         child: Column(
//           children: [
//             Container(
//               margin: const EdgeInsets.only(left: 30, right: 30),
//               padding: const EdgeInsets.only(top: 20),
//               alignment: Alignment.centerLeft,
//               child: Text("Évènements du ${today.day} ${getMonth(today.month)}",
//                   style: GoogleFonts.montserrat(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black)),
//             ),
//             // const SizedBox(
//             //   height: 20,
//             // ),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//             //   children: [
//             //     const SizedBox(
//             //       width: 5,
//             //     ),
//             //     ...days.map((day) {
//             //       int i = days.indexOf(day);
//             //       int date =
//             //           _firstDayOfTheweek.add(Duration(days: i)).day;
//             //       return getDatesColumn(day, date.toString(),
//             //           isToday: date == today.day);
//             //     }).toList(),
//             //     const SizedBox(
//             //       width: 5,
//             //     ),
//             //   ],
//             // ),
//             const SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 controller: _scrollController,
//                 scrollDirection: Axis.vertical,
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 80,
//                       height: 24 * 90.0 + 3,
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: getHourBar()),
//                     ),
//                     Expanded(
//                       child: SizedBox(
//                         height: 24 * 90.0 + 3,
//                         child: Stack(
//                           children: [
//                             Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: getHourBarItem(res)),
//                             getCurrentTime(today)
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 35,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget getLastInfo() {
//     return Container(
//         height: 500,
//         margin: const EdgeInsets.all(30),
//         alignment: Alignment.centerLeft,
//         decoration: BoxDecoration(
//           color: Colors.grey.shade100,
//           borderRadius: const BorderRadius.all(
//             Radius.circular(30),
//           ),
//         ),
//         child: Column(children: [
//           Container(
//             margin: const EdgeInsets.only(left: 30, right: 30),
//             padding: const EdgeInsets.only(top: 20),
//             alignment: Alignment.centerLeft,
//             child: Text("Dernières annonces",
//                 style: GoogleFonts.montserrat(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black)),
//           ),
//         ]));
//   }

//   // Future<User> fetchAlbum() async {
//   //   final response = await http
//   //       .get(Uri.parse(Port));

//   //   if (response.statusCode == 200) {
//   //     // If the server did return a 200 OK response,
//   //     // then parse the JSON.
//   //     return User.fromJson(jsonDecode(response.body));
//   //   } else {
//   //     // If the server did not return a 200 OK response,
//   //     // then throw an exception.
//   //     throw Exception('Failed to load album');
//   //   }
//   // }

// }
