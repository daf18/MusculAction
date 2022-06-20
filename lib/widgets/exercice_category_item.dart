// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'exercice_category_screen.dart';
// import 'exercice_details_screen.dart';

// class ExerciceCategoryItem extends StatelessWidget {
//   final String id;
//   final String title;
//   final String description;
//   final String image;
//   final String youtubeUrl;
//   final String details;

//   ExerciceCategoryItem(
//       {required this.id,
//       required this.title,
//       required this.description,
//       required this.image,
//       required this.youtubeUrl,
//       required this.details});

//   @override
//   Widget build(BuildContext context) {
//     final CollectionReference _exercices =
//         FirebaseFirestore.instance.collection('exercices');

//     Future<void> _deleteExercice(String exerciceId) async {
//       await _exercices.doc(exerciceId).delete();

//       // Montrer un snackbar
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Exercice a été supprimé')));
//     }

//     //  Future<void> _ajouterOuModifier([DocumentSnapshot? documentSnapshot]) async {
//     // String action = 'nouveau';
//     // if (documentSnapshot != null) {
//     //   action = 'modifier';
//     //   _titreController.text = documentSnapshot['title'];
//     //   _descriptionController.text = documentSnapshot['description'];
//     //   _detailsController.text = documentSnapshot['details'];
//     //   _youtubeUrlController.text = documentSnapshot['youtubeUrl'];
//     // }

//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: ListTile(
//         dense: true,
//         onTap: () {
//           Navigator.of(context)
//               .pushNamed(ExerciceDetailsScreen.routeName, arguments: {
//             'id': id,
//             'title': title,
//             'description': description,
//             'youtubeUrl': youtubeUrl,
//             'details': details
//           });
//         },
//         horizontalTitleGap: 10,
//         title: Text(
//           title,
//           style: TextStyle(
//             color: Colors.green,
//           ),
//         ),
//         subtitle: Text(
//           description,
//           maxLines: 4,
//           softWrap: true,
//           overflow: TextOverflow.fade,
//         ),
//         leading: SizedBox(
//           //padding: EdgeInsets.symmetric(vertical: 4),
//           child: Image.asset(
//             image,
//           ),
//           width: 100,
//           height: 100,
//         ),
//         trailing: SizedBox(
//           width: 100,
//           child: Row(
//             children: [
//               // modifie cet exercice
//               IconButton(icon: const Icon(Icons.edit), onPressed: () {}
//                   // _ajouterOuModifier(documentSnapshot)),
//                   ),
//               IconButton(
//                   icon: const Icon(Icons.delete),
//                   onPressed: () => _deleteExercice(id)
//                   //_deleteExercice(documentSnapshot.id)),
//                   ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
