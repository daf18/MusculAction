// ignore_for_file: library_private_types_in_public_api, unnecessary_nullable_for_final_variable_declarations, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'exercice_details_screen.dart';

class ExerciceCategoryScreen extends StatefulWidget {
  static const routeName = '/exercice-category';

  @override
  State<ExerciceCategoryScreen> createState() => _ExerciceCategoryScreenState();
}

class _ExerciceCategoryScreenState extends State<ExerciceCategoryScreen> {
  final CollectionReference _exercices =
      FirebaseFirestore.instance.collection('exercices');

  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _youtubeUrlController = TextEditingController();

  Future<void> _ajouterOuModifier([DocumentSnapshot? documentSnapshot]) async {
    String action = 'nouveau';
    if (documentSnapshot != null) {
      action = 'modifier';
      _titreController.text = documentSnapshot['title'];
      _descriptionController.text = documentSnapshot['description'];
      _detailsController.text = documentSnapshot['details'];
      _youtubeUrlController.text = documentSnapshot['youtubeUrl'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titreController,
                  decoration: const InputDecoration(labelText: 'Titre'),
                  textInputAction: TextInputAction.next,
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  textInputAction: TextInputAction.next,
                ),
                TextField(
                  controller: _detailsController,
                  decoration: const InputDecoration(labelText: 'Détails'),
                  textInputAction: TextInputAction.next,
                ),
                TextField(
                  controller: _youtubeUrlController,
                  decoration: const InputDecoration(labelText: 'YouTube Url'),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'nouveau' ? 'Nouveau' : 'Modifier'),
                  onPressed: () async {
                    final String? titre = _titreController.text;
                    final String? description = _descriptionController.text;
                    final String? details = _detailsController.text;
                    final String? youtubeUrl = _youtubeUrlController.text;

                    if (titre != null && description != null) {
                      if (action == 'nouveau') {
                        // Ajouter un nouveau exercice dans Firestore
                        await _exercices.add({
                          "category": "IFVsMMqf2VqQoM7DVzt4",
                          "img":
                              "assets/images/musculation/biceps/extensions.jpg",
                          "title": titre,
                          "description": description,
                          "details": details,
                          "youtubeUrl": youtubeUrl,
                        });
                      }

                      if (action == 'modifier') {
                        // Modifier l'exercice
                        await _exercices.doc(documentSnapshot!.id).update({
                          "title": titre,
                          "description": description,
                          "details": details,
                          "youtubeUrl": youtubeUrl,
                        });
                      }

                      _titreController.text = '';
                      _descriptionController.text = '';
                      _detailsController.text = '';
                      _youtubeUrlController.text = '';

                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Enleve un exeice by id
  Future<void> _deleteExercice(String exerciceId) async {
    await _exercices.doc(exerciceId).delete();

    // Montrer un snackbar
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Exercice a été supprimé')));
  }

  @override
  Widget build(BuildContext context) {
    //extract the arguments from the route
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final _categoryId = routeArgs['id'];
    //exercices for each category
    final selectedCategory =
        _exercices.where('category', isEqualTo: _categoryId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercices'),
        actions: [
          IconButton(
            color: Colors.green,
            icon: Icon(Icons.add),
            onPressed: () => _ajouterOuModifier(),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: selectedCategory.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    dense: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciceDetailsScreen(
                            title: documentSnapshot['title'],
                            youtubeLink: documentSnapshot['youtubeUrl'],
                            description: documentSnapshot['description'],
                            details: documentSnapshot['details'],
                          ),
                        ),
                      );
                    },
                    horizontalTitleGap: 10,
                    title: Text(
                      documentSnapshot['title'],
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    subtitle: Text(
                      documentSnapshot['description'],
                      maxLines: 4,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                    leading: SizedBox(
                      //padding: EdgeInsets.symmetric(vertical: 4),
                      child: Image.asset(
                        documentSnapshot['img'].toString(),
                      ),
                      width: 100,
                      height: 100,
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // modifie cet exercice
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _ajouterOuModifier(documentSnapshot)
                              ),
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteExercice(documentSnapshot.id)
                              ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Ajouter un nouveau exercice
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => _ajouterOuModifier(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

