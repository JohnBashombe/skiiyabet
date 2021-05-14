// // import 'package:skiiyabet/menu/sideMenu.dart';
// // import 'package:skiiyabet/window.dart';
// import 'package:skiiyabet/Responsive/responsive_widget.dart';
// import 'package:flutter/material.dart';

// class Jackpot extends StatefulWidget {
//   @override
//   _JackpotState createState() => _JackpotState();
// }

// class _JackpotState extends State<Jackpot> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//         child: Container(
//       decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border(
//             top: BorderSide(color: Colors.grey, width: 0.3),
//             bottom: BorderSide(color: Colors.grey, width: 0.3),
//             left: BorderSide(color: Colors.grey, width: 0.3),
//             right: BorderSide(color: Colors.grey, width: 0.3),
//           )),
//       padding: new EdgeInsets.all(10.0),
//       margin: EdgeInsets.only(
//           left: 10.0),
//       child: ListView(
//           // children: [
//           //   Container(
//           //     alignment: Alignment.center,
//           //     child: Text(
//           //       'Weekly Jackpot',
//           //       style: TextStyle(
//           //         color: Colors.black,
//           //         fontSize: 23.0,
//           //         fontWeight: FontWeight.bold,
//           //       ),
//           //     ),
//           //   ),
//           //   SizedBox(height: 5.0),
//           //   Row(
//           //     children: [
//           //       Text(
//           //         'Jackpot:',
//           //         style: TextStyle(
//           //           color: Colors.grey,
//           //           fontSize: 13.0,
//           //         ),
//           //       ),
//           //       SizedBox(width: 5.0),
//           //       Text(
//           //         '10 000 000 Fc',
//           //         style: TextStyle(
//           //             color: Colors.black,
//           //             fontSize: 15.0,
//           //             fontWeight: FontWeight.bold),
//           //       )
//           //     ],
//           //   ),
//           //   Row(
//           //     children: [
//           //       Text(
//           //         'Ticket Price:',
//           //         style: TextStyle(
//           //           color: Colors.grey,
//           //           fontSize: 13.0,
//           //         ),
//           //       ),
//           //       SizedBox(width: 5.0),
//           //       Text(
//           //         '100 Fc',
//           //         style: TextStyle(
//           //             color: Colors.black,
//           //             fontSize: 15.0,
//           //             fontWeight: FontWeight.bold),
//           //       ),
//           //     ],
//           //   ),
//           //   Row(
//           //     children: [
//           //       Text(
//           //         'Closing time:',
//           //         style: TextStyle(
//           //           color: Colors.grey,
//           //           fontSize: 13.0,
//           //         ),
//           //       ),
//           //       SizedBox(width: 5.0),
//           //       Text(
//           //         '1:00 PM / Sat, 7/11',
//           //         style: TextStyle(
//           //             color: Colors.black,
//           //             fontSize: 15.0,
//           //             fontWeight: FontWeight.bold),
//           //       ),
//           //     ],
//           //   ),
//           //   Row(
//           //     children: [
//           //       Text(
//           //         'Details:',
//           //         style: TextStyle(
//           //           color: Colors.grey,
//           //           fontSize: 13.0,
//           //         ),
//           //       ),
//           //       SizedBox(width: 5.0),
//           //       Text(
//           //         'Pick 20 winners',
//           //         style: TextStyle(
//           //             color: Colors.black,
//           //             fontSize: 15.0,
//           //             fontWeight: FontWeight.bold),
//           //       ),
//           //     ],
//           //   ),
//           //   SizedBox(height: 8.0),
//           //   Container(
//           //     width: double.infinity,
//           //     child: RawMaterialButton(
//           //       onPressed: null,
//           //       fillColor: Colors.grey[400],
//           //       disabledElevation: 3.0,
//           //       child: Text(
//           //         'Lucky Dip'.toUpperCase(),
//           //         style: TextStyle(
//           //             color: Colors.white,
//           //             fontWeight: FontWeight.bold,
//           //             fontSize: 13.0,
//           //             letterSpacing: 0.5),
//           //       ),
//           //     ),
//           //   ),
//           //   SizedBox(height: 12.0),
//           //   Row(
//           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //     children: [
//           //       Text(
//           //         'Events',
//           //         style: TextStyle(fontSize: 12.0, color: Colors.grey),
//           //       ),
//           //       Text(
//           //         'Select one or more',
//           //         style: TextStyle(fontSize: 12.0, color: Colors.grey),
//           //       ),
//           //     ],
//           //   ),
//           //   Divider(
//           //     color: Colors.grey,
//           //     thickness: 0.5,
//           //   ),
//           //   Column(
//           //     children: [
//           //       Row(
//           //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //         children: [
//           //           Container(
//           //             padding: EdgeInsets.only(right: 5.0),
//           //             width: ResponsiveWidget.isLargeScreen(context)
//           //                 ? MediaQuery.of(context).size.width - 605 - 220
//           //                 : ResponsiveWidget.customScreen(context)
//           //                     ? MediaQuery.of(context).size.width - 605 - 100
//           //                     : ResponsiveWidget.isMediumScreen(context)
//           //                         ? MediaQuery.of(context).size.width - 350
//           //                         : ResponsiveWidget.isSmallScreen(context)
//           //                             ? MediaQuery.of(context).size.width - 200
//           //                             : MediaQuery.of(context).size.width - 150,
//           //             child: Column(
//           //               crossAxisAlignment: CrossAxisAlignment.start,
//           //               children: [
//           //                 Text(
//           //                   'Motedio Yamagata - Mito HollyHock',
//           //                   style: TextStyle(
//           //                     color: Colors.black,
//           //                     fontSize: 14.0,
//           //                     fontWeight: FontWeight.bold,
//           //                   ),
//           //                   maxLines: 4,
//           //                   overflow: TextOverflow.clip,
//           //                 ),
//           //                 SizedBox(height: 3.0),
//           //                 Text(
//           //                   '1:00 PM / Sat, 7/11 - Japan J-League Division 2',
//           //                   style: TextStyle(
//           //                     color: Colors.grey,
//           //                     fontSize: 12.0,
//           //                     // fontWeight: FontWeight.bold,
//           //                   ),
//           //                   maxLines: 4,
//           //                   overflow: TextOverflow.clip,
//           //                 ),
//           //               ],
//           //             ),
//           //           ),
//           //           Expanded(
//           //             child: RawMaterialButton(
//           //               onPressed: null,
//           //               fillColor: Colors.lightBlue,
//           //               disabledElevation: 3.0,
//           //               child: Text(
//           //                 '1'.toUpperCase(),
//           //                 style: TextStyle(
//           //                     color: Colors.white,
//           //                     fontWeight: FontWeight.bold,
//           //                     fontSize: 12.0,
//           //                     letterSpacing: 0.5),
//           //               ),
//           //             ),
//           //           ),
//           //           SizedBox(width: 5.0),
//           //           Expanded(
//           //             child: RawMaterialButton(
//           //               onPressed: null,
//           //               fillColor: Colors.grey[400],
//           //               disabledElevation: 3.0,
//           //               child: Text(
//           //                 'x'.toUpperCase(),
//           //                 style: TextStyle(
//           //                     color: Colors.white,
//           //                     fontWeight: FontWeight.bold,
//           //                     fontSize: 12.0,
//           //                     letterSpacing: 0.5),
//           //               ),
//           //             ),
//           //           ),
//           //           SizedBox(width: 5.0),
//           //           Expanded(
//           //             child: RawMaterialButton(
//           //               onPressed: null,
//           //               fillColor: Colors.grey[400],
//           //               disabledElevation: 3.0,
//           //               child: Text(
//           //                 '2'.toUpperCase(),
//           //                 style: TextStyle(
//           //                     color: Colors.white,
//           //                     fontWeight: FontWeight.bold,
//           //                     fontSize: 12.0,
//           //                     letterSpacing: 0.5),
//           //               ),
//           //             ),
//           //           )
//           //         ],
//           //       ),
//           //       // Divider(
//           //       //   color: Colors.grey,
//           //       //   thickness: 0.5,
//           //       // ),
//           //       // Row(
//           //       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //       //   children: [
//           //       //     Column(
//           //       //       crossAxisAlignment: CrossAxisAlignment.start,
//           //       //       children: [
//           //       //         Text(
//           //       //           'Barcelona - Real Madrid',
//           //       //           style: TextStyle(
//           //       //             color: Colors.black,
//           //       //             fontSize: 14.0,
//           //       //             fontWeight: FontWeight.bold,
//           //       //           ),
//           //       //           maxLines: 2,
//           //       //           overflow: TextOverflow.ellipsis,
//           //       //         ),
//           //       //         SizedBox(height: 3.0),
//           //       //         Text(
//           //       //           '6:30 PM / Sun, 13/01 - Spain Primera Division',
//           //       //           style: TextStyle(
//           //       //             color: Colors.grey,
//           //       //             fontSize: 12.0,
//           //       //             // fontWeight: FontWeight.bold,
//           //       //           ),
//           //       //           maxLines: 3,
//           //       //           overflow: TextOverflow.ellipsis,
//           //       //         ),
//           //       //       ],
//           //       //     ),
//           //       //     Row(
//           //       //       children: [
//           //       //         RawMaterialButton(
//           //       //           onPressed: null,
//           //       //           fillColor: Colors.grey[400],
//           //       //           disabledElevation: 3.0,
//           //       //           child: Text(
//           //       //             '1'.toUpperCase(),
//           //       //             style: TextStyle(
//           //       //                 color: Colors.white,
//           //       //                 fontWeight: FontWeight.bold,
//           //       //                 fontSize: 12.0,
//           //       //                 letterSpacing: 0.5),
//           //       //           ),
//           //       //         ),
//           //       //         SizedBox(width: 5.0),
//           //       //         RawMaterialButton(
//           //       //           onPressed: null,
//           //       //           fillColor: Colors.grey[400],
//           //       //           disabledElevation: 3.0,
//           //       //           child: Text(
//           //       //             'x'.toUpperCase(),
//           //       //             style: TextStyle(
//           //       //                 color: Colors.white,
//           //       //                 fontWeight: FontWeight.bold,
//           //       //                 fontSize: 12.0,
//           //       //                 letterSpacing: 0.5),
//           //       //           ),
//           //       //         ),
//           //       //         SizedBox(width: 5.0),
//           //       //         RawMaterialButton(
//           //       //           onPressed: null,
//           //       //           fillColor: Colors.grey[400],
//           //       //           disabledElevation: 3.0,
//           //       //           child: Text(
//           //       //             '2'.toUpperCase(),
//           //       //             style: TextStyle(
//           //       //                 color: Colors.white,
//           //       //                 fontWeight: FontWeight.bold,
//           //       //                 fontSize: 12.0,
//           //       //                 letterSpacing: 0.5),
//           //       //           ),
//           //       //         ),
//           //       //       ],
//           //       //     )
//           //       //   ],
//           //       // ),
//           //     ],
//           //   ),
//           //   Divider(
//           //     color: Colors.grey,
//           //     thickness: 1,
//           //   ),
//           //   SizedBox(height: 5.0),
//           //   Container(
//           //     alignment: Alignment.centerRight,
//           //     child: Text(
//           //       'Clear All',
//           //       style: TextStyle(color: Colors.grey, fontSize: 14.0),
//           //     ),
//           //   ),
//           //   SizedBox(height: 10.0),
//           //   Row(
//           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //     children: [
//           //       Text('Price:',
//           //           style: TextStyle(color: Colors.grey, fontSize: 14.0)),
//           //       Text(
//           //         '100 Fc',
//           //         style: TextStyle(
//           //             color: Colors.black,
//           //             fontSize: 16.0,
//           //             fontWeight: FontWeight.bold),
//           //       ),
//           //     ],
//           //   ),
//           //   SizedBox(height: 5.0),
//           //   Row(
//           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //     children: [
//           //       Text('Total tickets:',
//           //           style: TextStyle(color: Colors.grey, fontSize: 14.0)),
//           //       Text(
//           //         '1',
//           //         style: TextStyle(
//           //             color: Colors.black,
//           //             fontSize: 16.0,
//           //             fontWeight: FontWeight.bold),
//           //       ),
//           //     ],
//           //   ),
//           //   SizedBox(height: 5.0),
//           //   Row(
//           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //     children: [
//           //       Text('Total Price:',
//           //           style: TextStyle(color: Colors.grey, fontSize: 14.0)),
//           //       Text(
//           //         '10 000 0000 Fc',
//           //         style: TextStyle(
//           //             color: Colors.black,
//           //             fontSize: 17.0,
//           //             fontWeight: FontWeight.bold),
//           //       ),
//           //     ],
//           //   ),
//           //   SizedBox(height: 10.0),
//           //   Container(
//           //     width: double.infinity,
//           //     child: RawMaterialButton(
//           //       onPressed: null,
//           //       fillColor: Colors.lightBlue,
//           //       disabledElevation: 3.0,
//           //       child: Text(
//           //         'Buy Ticket'.toUpperCase(),
//           //         style: TextStyle(
//           //             color: Colors.white,
//           //             fontWeight: FontWeight.bold,
//           //             fontSize: 13.0,
//           //             letterSpacing: 0.5),
//           //       ),
//           //     ),
//           //   ),
//           // ],

//           ),
//     ));
//   }
// }

// // initialBlocks() {
// //   return SideMenu();
// // }
