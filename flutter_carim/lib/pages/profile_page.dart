import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:carimbinho/core/models/contact.dart';
import 'package:carimbinho/pages/qr_code_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final Contact contact;

  ProfilePage({this.contact});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Contact contact;
  StorageReference storage;
  String photo;
  final _avatar =
      "https://cdn2.iconfinder.com/data/icons/solid-glyphs-volume-2/256/user-unisex-512.png";

  @override
  void initState() {
    super.initState();
    contact = widget.contact;
    photo = '${contact.email}.png';
    storage = FirebaseStorage.instance.ref().child('photos/${contact.email}');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      reverse: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              _buildImageProvider(),
              const SizedBox(
                height: 20,
              ),
              Text(contact.nome ?? "",
                  style: TextStyle(
                      fontSize: 45.0,
                      color: Colors.green[900],
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Membro desde ${contact.membroDesde}',
                style: TextStyle(color: Colors.green[900]),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                contact.email ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.green[900]),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                contact.nomeCompleto ?? "",
                style: TextStyle(fontSize: 15.0, color: Colors.green[900]),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                contact.fone ?? "",
                style: TextStyle(color: Colors.green[900]),
              ),
              const SizedBox(
                height: 30,
              ),
              QrCodePage(data: contact.email),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageProvider() {
    return FutureBuilder(
      future: _locatePicture(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return _returnPicture(snapshot);
          default:
            return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _returnPicture(AsyncSnapshot snapshot) {
    return GestureDetector(
        child: Container(
          alignment: Alignment.center,
          width: 150.0,
          height: 150.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: snapshot.hasData ? snapshot.data : NetworkImage(_avatar),
              fit: BoxFit.cover,
            ),
          ),
        ),
        onTap: () {
          ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50)
              .then((file) {
            if (file == null) return;
            updateProfilePicture(file);
          });
        });
  }

  Future<ImageProvider> _locatePicture() async {
    if (!(contact.foto != null || contact.foto.isNotEmpty)) {
      return NetworkImage(_avatar);
    }

    if (File(contact.foto).existsSync()) {
      File file = File(contact.foto);
      return FileImage(file);
    } else {
      final Directory tempDir = Directory.systemTemp;
      final File file = File('${tempDir.path}/$photo');
      try {
        final String downloadUrl = await storage.getDownloadURL();
        final httpResponse = http.get(downloadUrl);
        if (file.existsSync()) {
          file.deleteSync();
        }
        final StorageFileDownloadTask downloadTask = storage.writeToFile(file);
        return FileImage(file);
      } catch (error) {
        return NetworkImage(_avatar);
      }
    }
  }

  Future<void> updateProfilePicture(File file) async {
    File newFile = file;
    final StorageUploadTask upload = storage.putFile(
        File(newFile.path),
        StorageMetadata(
          contentType: 'image/jpg',
        ));
    await upload.onComplete;
    setState(() {
      contact.foto = newFile.path == null ? contact.foto : newFile.path;
    });
  }
}
