// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gamelovers/models/user.dart';
import 'package:gamelovers/pages/components/button.dart';
import 'package:gamelovers/pages/profile_page.dart';
import 'package:gamelovers/pages/repository/user_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

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
  File? _imageFile;
  String? _uploadedFileURL;

  @override
  void initState() {
    userRepository.getMe().then((value) {
      setState(() {
        user = (value);
        nameController.text = user?.name ?? "";
        yearsController.text = '${user?.years ?? "Empty"}';
        descriptionController.text = user?.description ?? "";
      });
    });
    super.initState();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    String fileName = path.basename(_imageFile!.path);
    Reference storageReference =
        FirebaseStorage.instance.ref().child('profiles/$fileName');

    try {
      UploadTask uploadTask = storageReference.putFile(_imageFile!);
      TaskSnapshot snapshot = await uploadTask;

      // Verifica se o upload foi concluído com sucesso
      if (snapshot.state == TaskState.success) {
        // Obtém a URL de download da imagem
        String downloadURL = await storageReference.getDownloadURL();
        print('URL do arquivo carregado: $downloadURL');

        // Atualiza o campo profileImageUrl no Firestore
        if (user != null) {
          user!.profileImageUrl = downloadURL;
          await userRepository
              .saveAll(user!); // Salva as alterações no Firestore
          setState(() {
            _uploadedFileURL = downloadURL;
          });
        } else {
          print('Usuário não definido.');
        }
      } else {
        print('Erro ao carregar imagem: Upload não concluído com sucesso.');
      }
    } on FirebaseException catch (e) {
      print('Erro Firebase Storage: ${e.message}');
    } catch (e) {
      print('Erro ao fazer upload do arquivo: $e');
    }
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
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
                            color: Color.fromARGB(223, 233, 226, 226),
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nome',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: yearsController,
                          style: const TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(223, 233, 226, 226),
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Idade',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: descriptionController,
                          style: const TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(223, 233, 226, 226),
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Descrição',
                          ),
                        ),
                        const SizedBox(height: 40),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Alterar foto de perfil',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _imageFile != null
                            ? Image.file(
                                _imageFile!,
                                height: 150,
                              )
                            : const Text(
                                'Nenhuma imagem selecionada',
                                style: TextStyle(color: Colors.white),
                              ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () =>
                                    _pickImage(ImageSource.gallery),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black, // Fundo preto
                                  foregroundColor: Colors.white, // Texto branco
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        0), // Bordas quadradas
                                  ),
                                ),
                                child: const Text('Usar imagem de galeria'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _pickImage(ImageSource.camera),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black, // Fundo preto
                                  foregroundColor: Colors.white, // Texto branco
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        0), // Bordas quadradas
                                  ),
                                ),
                                child: const Text('Usar a câmera'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        CustomButton(onTap: () async {
                          var textoName = nameController.text;
                          int? textoYears = int.tryParse(yearsController.text);
                          var textoDescription = descriptionController.text;

                          if (_imageFile != null) {
                            await _uploadImage();
                            user!.profileImageUrl = _uploadedFileURL;
                          }

                          user!.name = textoName;
                          user!.years = textoYears!;
                          user!.description = textoDescription;
                          await userRepository.saveAll(user!);
                          Navigator.pop(
                            // ignore: use_build_context_synchronously
                            context,
                          );
                        }),
                        CustomButton(
                          onTap: () {
                            Navigator.pop(
                              context,
                            );
                          },
                          textoBotao: "Voltar",
                        ),
                      ]),
                ),
              )),
        ));
  }
}
