import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../category_item.dart';

class CategoryOverviewScreen extends StatelessWidget {
  final CollectionReference _categories =
      FirebaseFirestore.instance.collection('categories');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercices musculation'),
      ),
      body: StreamBuilder(
        stream: _categories.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return CategoryItem(
                  id: documentSnapshot.reference.id,
                  title: documentSnapshot['title'],
                  imageUrl: documentSnapshot['imageUrl'],
                );
              },
              itemCount: streamSnapshot.data!.docs.length,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
