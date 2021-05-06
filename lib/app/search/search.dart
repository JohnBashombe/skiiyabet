// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:skiiyabet/Responsive/responsive_widget.dart';
// import 'package:skiiyabet/app/skiiyaBet.dart';

// class RootPage extends StatefulWidget {
//   @override
//   _RootPageState createState() => new _RootPageState();
// }

// class _RootPageState extends State<RootPage> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   void callback(Widget nextPage) {
//     setState(() {});
//   }

//   SkiiyaBet skiiya = new SkiiyaBet();

//   @override
//   Widget build(BuildContext context) {
//     return search();
//   }

//   Widget search(var _queryResults, var _queryDisplay, bool _isQueryEmpty) {
//     return Expanded(
//       child: Container(
//         width: double.infinity,
//         margin: EdgeInsets.only(
//             left: ResponsiveWidget.isBigScreen(context) ? 15.0 : 10.0),
//         padding: new EdgeInsets.all(10.0),
//         decoration: BoxDecoration(
//           border: Border(
//             top: BorderSide(color: Colors.grey, width: 0.5),
//             bottom: BorderSide(color: Colors.grey, width: 0.5),
//             left: BorderSide(color: Colors.grey, width: 0.5),
//             right: BorderSide(color: Colors.grey, width: 0.5),
//           ),
//         ),
//         child: ListView(
//           padding: EdgeInsets.only(top: 0.0),
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // SizedBox(height: 5.0),
//                 Container(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
//                   height: 60.0,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: Colors.white70,
//                       border: Border(
//                         top: BorderSide(color: Colors.lightGreen, width: 1.5),
//                         bottom:
//                             BorderSide(color: Colors.lightGreen, width: 1.5),
//                         left: BorderSide(color: Colors.lightGreen, width: 1.5),
//                         right: BorderSide(color: Colors.lightGreen, width: 1.5),
//                       )),
//                   child: TextField(
//                     cursorColor: Colors.lightGreen,
//                     maxLines: 1,
//                     keyboardType: TextInputType.text,
//                     inputFormatters: <TextInputFormatter>[
//                       FilteringTextInputFormatter.singleLineFormatter,
//                       FilteringTextInputFormatter.allow(RegExp(
//                           r'[a-zA-Z0-9\s]')), // create a pattern for text only
//                     ],
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 15.0,
//                         fontWeight: FontWeight.w500,
//                         letterSpacing: 0.5),
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: 'Cherchez un Match',
//                         icon: Icon(
//                           Icons.search,
//                           color: Colors.lightGreen[400],
//                         ),
//                         hintMaxLines: 1,
//                         hintStyle: TextStyle(
//                             color: Colors.grey,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12.0)),
//                     onChanged: (value) {
//                       if (value.isEmpty) {
//                         if (mounted)
//                           setState(() {
//                             _queryResults.clear();
//                             _queryDisplay.clear();
//                             _isQueryEmpty = true;
//                           });
//                         return;
//                       }
//                       try {
//                         if (mounted)
//                           setState(() {
//                             // if reaches here it means the value is not empty
//                             _isQueryEmpty = false;
//                             // everytime a value is changed, do update the results
//                             skiiya.loadingSearch(value);
//                           });
//                       } catch (e) {
//                         // caught the error if any one show in the user typing
//                         print('Erreur: $e');
//                       }
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 20.0),
//                 Text(
//                   'Mes Résultats'.toUpperCase(),
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 12.0,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 SizedBox(height: 5.0),
//                 Divider(color: Colors.grey, thickness: 0.5),
//                 // if something has been found in collection, execute this
//                 _queryResults.length > 0
//                     // if both contents are greater than 0 print this
//                     ? _queryDisplay.length > 0
//                         ? MouseRegion(
//                             cursor: SystemMouseCursors.click,
//                             child: Column(
//                               children: _queryDisplay.map<Widget>(
//                                 (result) {
//                                   // return Container(child: Text(word['team1']));
//                                   return thisResult(result);
//                                 },
//                               ).toList(),
//                             ),
//                           )
//                         // if there is no matching content then do thi
//                         : Center(
//                             child: (isNoInternetNetwork)
//                                 ? Padding(
//                                     padding: const EdgeInsets.only(top: 10.0),
//                                     child: Text('Pas d\'Internet'.toUpperCase(),
//                                         style: TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: 16.0,
//                                           fontWeight: FontWeight.w400,
//                                           // fontStyle: FontStyle.italic,
//                                         )),
//                                   )
//                                 : Column(
//                                     children: [
//                                       SizedBox(height: 8.0),
//                                       Text(
//                                         'Aucun Match Trouvé',
//                                         style: TextStyle(
//                                           color: Colors.lightGreen[400],
//                                           fontSize: 15.0,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       SizedBox(height: 10.0),
//                                       SpinKitCubeGrid(
//                                         color: Colors.lightGreen[400],
//                                         size: 20.0,
//                                         // lineWidth: 5.0,
//                                       ),
//                                     ],
//                                   ),
//                           )
//                     // if the query is empty return three dots
//                     : _isQueryEmpty
//                         ? Padding(
//                             padding: const EdgeInsets.only(top: 10.0),
//                             child: Center(
//                               child: Text(
//                                 'Résultats de la Recherche',
//                                 style: TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.w400,
//                                   fontStyle: FontStyle.italic,
//                                 ),
//                               ),
//                             ),
//                           )
//                         // if that means nothing has been found in collection
//                         : Center(
//                             child: (isNoInternetNetwork)
//                                 ? Padding(
//                                     padding: const EdgeInsets.only(top: 10.0),
//                                     child: Text('Pas d\'Internet'.toUpperCase(),
//                                         style: TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: 16.0,
//                                           fontWeight: FontWeight.w400,
//                                           // fontStyle: FontStyle.italic,
//                                         )),
//                                   )
//                                 : Column(
//                                     children: [
//                                       SizedBox(height: 8.0),
//                                       Text(
//                                         'Aucun Match Trouvé',
//                                         style: TextStyle(
//                                           color: Colors.lightGreen[400],
//                                           fontSize: 15.0,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       SizedBox(height: 10.0),
//                                       SpinKitCubeGrid(
//                                         color: Colors.lightGreen[400],
//                                         size: 20.0,
//                                         // lineWidth: 5.0,
//                                       ),
//                                     ],
//                                   ),
//                           ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
