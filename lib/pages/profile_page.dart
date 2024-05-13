import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamelovers/models/games_user.dart';
import 'package:gamelovers/pages/components/button.dart';
import 'package:gamelovers/pages/edit_page.dart';
import 'package:gamelovers/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 44, 44, 44),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 44, 44, 44),
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.videogame_asset_outlined,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  'Profile',
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                    color: Colors.purple.shade300,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  )),
                ),
              ],
            ),
          )),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                    padding: const EdgeInsets.only(top: 50),
                    child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/foto_perfil.png"),
                          radius: 50,
                        ))),
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                user.name,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.white),
              )),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 380,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 59, 51, 51),
                  borderRadius: BorderRadius.circular(20)),
              child: const Column(children: [
                ListTile(
                  title: Text(
                    "Nome",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  subtitle: Text(
                    User.name;
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  title: Text(
                    "Like jogos",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  subtitle: Text(
                    var list = 
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  title: Text(
                    "Idade",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  subtitle: Text(
                    "20",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  title: Text(
                    "Descrição",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  subtitle: Text(
                    "Eu amo jogos de poderzinho",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
              ]),
            ),
          ),
          CustomButton(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            textoBotao: 'Sair',
          ),
          CustomButton(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const EditPage()),
              );
            },
            textoBotao: 'Editar BIO',
          ),
        ],
      )),
    );
  }

  sair() async {
    await _firebaseAuth.signOut().then(
          (user) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          ),
        );
  }

  jogosLike
  for 
                    if(games_user.review=true){
                      game_user.id == game.id
                      list[] game.name
                    }

  return list
}
