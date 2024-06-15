import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gamelovers/models/games_user.dart';
import 'package:gamelovers/models/user.dart';
import 'package:gamelovers/pages/components/button.dart';
import 'package:gamelovers/pages/edit_page.dart';
import 'package:gamelovers/pages/login_page.dart';
import 'package:gamelovers/pages/repository/user_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _firebaseAuth = FirebaseAuth.instance;
  final UserRepository userRepository = UserRepository();
  Users? user;
  Reviews? review;
  final _formKey = GlobalKey<FormState>();
  bool loading = true;

  @override
  void initState() {
    userRepository.getMe().then((value) {
      setState(() {
        user = (value);
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<UserRepository>().getMe();
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
            child: Column(children: [
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
                    child:  CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60,
                        child: user?.profileImageUrl != null
                            ? CircleAvatar(
                                backgroundImage:
                                    NetworkImage(user!.profileImageUrl!),
                                radius: 50,
                              )
                            :
                        const CircleAvatar(
                          backgroundImage: AssetImage("assets/foto_perfil.png"),
                          radius: 50,
                        ))),
              ],
            ),
          ),
          Column(children: [
            Padding(
                padding: const EdgeInsets.all(25),
                child: Form(
                    key: _formKey,
                    child: Center(
                      child: SingleChildScrollView(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            title: const Text(
                              "Nome",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            subtitle: Text(
                              user?.name ?? "Empty",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                          ListTile(
                            title: const Text(
                              "Idade",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            subtitle: Text('${user?.years ?? "Empty"}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                          ListTile(
                            title: const Text("Descrição",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14)),
                            subtitle: Text(user?.description ?? "Empty",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                          ListTile(
                            title: const Text("Jogos Like",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14)),
                            subtitle: Text("jogos",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                          CustomButton(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EditPage()),
                              );
                            },
                            textoBotao: 'Editar Perfil',
                          ),
                          CustomButton(
                            onTap: () {
                              sair();
                            },
                            textoBotao: 'Sair',
                          ),
                        ],
                      )),
                    )))
          ])
        ])));
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
}
