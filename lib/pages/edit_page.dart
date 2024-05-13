import 'package:flutter/material.dart';
import 'package:gamelovers/models/user.dart';
import 'package:gamelovers/pages/repository/user_repository.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final UserRepository userRepository = UserRepository();

  TextEditingController nameController = TextEditingController();

  Users? user;

  bool loading = true;

  @override
  void initState() {
    userRepository.getMe().then((value) {
      setState(() {
        user = (value);
        nameController.text = user?.name ?? "";
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 44, 44, 44),
      body: loading
          ? const CircularProgressIndicator()
          : Column(
              children: [
                SizedBox(
                  width: 250,
                  height: 50,
                  child: TextField(
                    controller: nameController,
                  ),
                ),
                MaterialButton(
                    child: const Text("Salvar"),
                    onPressed: () async {
                      var textoNovo = nameController.text;

                      user!.name = textoNovo;

                      await userRepository.saveAll(user!);
                    })
              ],
            ),
    );
  }
}
