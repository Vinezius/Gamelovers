import 'package:flutter/material.dart';
import 'package:gamelovers/models/user.dart';
import 'package:gamelovers/pages/components/button.dart';
import 'package:gamelovers/pages/profile_page.dart';
import 'package:gamelovers/pages/repository/user_repository.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final UserRepository userRepository = UserRepository();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController yearsController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Users? user;

  //bool loading = true;

  @override
  void initState() {
    userRepository.getMe().then((value) {
      setState(() {
        user = (value);
        nameController.text = user?.name ?? "";
        yearsController.text = '${user?.years ?? "Empty"}';
        descriptionController.text = user?.description ?? "";
        //loading = false;
      });
    });
    super.initState();
  }

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
                    'Edit Profile',
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
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.all(25),
              child: Form(
                  key: _formKey,
                  child: Center(
                      child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        TextField(
                            controller: nameController,
                            style: const TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(223, 233, 226, 226)),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nome',
                            )),
                        const SizedBox(height: 20),
                        TextField(
                            controller: yearsController,
                            style: const TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(223, 233, 226, 226)),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Idade',
                            )),
                        const SizedBox(height: 20),
                        TextField(
                            controller: descriptionController,
                            style: const TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(223, 233, 226, 226)),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Descrição',
                            )),
                        const SizedBox(height: 40),
                        CustomButton(
                          onTap: () async {
                            var textoName = nameController.text;
                            int? textoYears =
                                int.tryParse(yearsController.text);
                            var textoDescription = descriptionController.text;

                            user!.name = textoName;
                            user!.years = textoYears!;
                            user!.description = textoDescription;
                            await userRepository.saveAll(user!);
                            Navigator.pushReplacement(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()),
                            );
                          },
                          textoBotao: "Salvar",
                        ),
                        CustomButton(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()),
                            );
                          },
                          textoBotao: "Voltar",
                        ),
                      ],
                    ),
                  ))))
        ]));
  }
}
