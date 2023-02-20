import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {

    final FirebaseStorage storage = FirebaseStorage.instance;

    Future<File?> _getImageFromCamera() async {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      return File(pickedFile!.path);
    }
    Future<String> _uploadImageToFirebase(File file) async {
      // Crie uma referência única para o arquivo
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final reference = storage.ref().child('images/$fileName');

      // Faça upload da imagem para o Cloud Storage
      await reference.putFile(file);

      // Recupere a URL do download da imagem para salvar no banco de dados
      final url = await reference.getDownloadURL();
      return url;
    }
    File? _imageFile;

    Future<void> _uploadImage() async {
      final imageFile = await _getImageFromCamera();
      if (imageFile != null) {
        setState(() {
          _imageFile = imageFile;
        });

        final imageUrl = await _uploadImageToFirebase(imageFile);
        // Salve a URL do download da imagem no banco de dados
      }
    }
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: _getImageFromCamera,
                child: Text('c'),
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload Image'),
            )
          ],
        ),
      ),
    );
  }
}
