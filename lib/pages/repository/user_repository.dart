import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamelovers/models/user.dart';

class UserRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Users>> getUsers() async {
    List<Users> usersList = [];

    var result = await db.collection("users").get();

    for (var doc in result.docs) {
      var tmp = doc.data();
      tmp['uId'] = doc.id;

      Users user = Users.fromMap(tmp);
      usersList.add(user);
    }

    return usersList;
  }

  Future<Users> getMe() async {
    String uId = FirebaseAuth.instance.currentUser!.uid;

    var result = await db.collection("users").doc(uId).get();

    if (result.exists) {
      Map tmp = result.data() as Map;
      tmp["uId"] = result.id;

      return Users.fromMap(tmp);
    } else {
      var novouser = Users(uId: uId, name: "", description: "", years: 0);
      await result.reference.set(novouser.toMap());

      return novouser;
    }
  }

  Future saveAll(Users user) async {
    if (user.uId == null) {
      await db.collection("users").add(user.toMap());
    } else {
      await db.collection("users").doc(user.uId).set(user.toMap());
    }
  }
}
