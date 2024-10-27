import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FavoritePage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('favorites').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No favorites yet"));
          }

          // Display saved images in a StaggeredGridView
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                String imageUrl = doc['imageUrl'];

                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                );
              },
              staggeredTileBuilder: (index) => StaggeredTile.count(
                2,
                index.isEven ? 2 : 3,
              ),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
          );
        },
      ),
    );
  }
}
