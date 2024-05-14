import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamelovers/auth.dart';
import 'package:gamelovers/databases/db_firestore.dart';
import 'package:gamelovers/models/game.dart';
import 'package:gamelovers/pages/repository/games_repository.dart';
import 'dart:collection';

class ReviewsRepository extends ChangeNotifier {
  List<Game> lista = [];
  late FirebaseFirestore db;
  late Auth auth;

  ReviewsRepository({required this.auth}) {
    startRepository();
  }

  startRepository() async {
    await startFirestore();
    await readGames();
  }

  startFirestore() {
    db = DBFirestore.get();
  }

readGames() async {
  if(auth.currentUser != null && lista.isEmpty) {
    final snapshot = await db.collection('users/${auth.currentUser!.uid}/reviews').get();
    snapshot.docs.forEach((doc) {
      if (doc.data().containsKey('name')) { // Check if "name" exists
        Game game = GamesRepository.items.firstWhere((game) => game.name == doc.get('name'));
        lista.add(game);
        notifyListeners();
      }
    });
  }
}

  saveGames(Game game) async {
    lista.add(game);
    await db.collection('users/${auth.currentUser!.uid}/reviews')
    .doc(game.name)
    .set({
      'Name': game.name,
      'Description': game.description,
      'Genre': game.genre,
      'Release Date': game.release,
    });
    notifyListeners();
  }

  remove(Game game) async {
    await db.collection('users/${auth.currentUser!.uid}/reviews').doc(game.name).delete();
    lista.remove(game);
    notifyListeners();
  }

}
