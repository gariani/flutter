import 'dart:io';
import 'package:carimbinho/core/services/authentication_service.dart';
import 'package:carimbinho/helpers/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:carimbinho/core/models/contact.dart';
import 'package:carimbinho/views/qr_code_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _auth = locator<AuthenticationService>();
  Stream<Contact> contact;

  @override
  void initState() {
    contact = _auth.contact;
    super.initState();
  }

  @override
  void dispose() {
    _auth.dispose();
    super.dispose();
  }

  StorageReference storage;
  String photo;
  final _avatar =
      "https://cdn2.iconfinder.com/data/icons/solid-glyphs-volume-2/256/user-unisex-512.png";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: contact,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                  _buildImageProvider(snapshot),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(snapshot.data.nome,
                      style: TextStyle(
                          fontSize: 45.0,
                          color: Colors.green[900],
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Membro desde',
                    style: TextStyle(color: Colors.green[900]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.green[900]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "",
                    style: TextStyle(fontSize: 15.0, color: Colors.green[900]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "",
                    style: TextStyle(color: Colors.green[900]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  QrCodePage(data: ""),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageProvider(AsyncSnapshot snapshot) {
    return FutureBuilder(
      future: _locatePicture(snapshot),
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
            updateProfilePicture(file, snapshot);
          });
        });
  }

  Future<ImageProvider> _locatePicture(AsyncSnapshot snapshot) async {
    if (!(snapshot.data.foto != null || snapshot.data.foto.isNotEmpty)) {
      return NetworkImage(_avatar);
    }

    if (File(snapshot.data.foto).existsSync()) {
      File file = File(snapshot.data.foto);
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

  Future<void> updateProfilePicture(File file, AsyncSnapshot snapshot) async {
    File newFile = file;
    final StorageUploadTask upload = storage.putFile(
        File(newFile.path),
        StorageMetadata(
          contentType: 'image/jpg',
        ));
    await upload.onComplete;
    setState(() {
      snapshot.data.foto = newFile.path == null ? snapshot.data.foto : newFile.path;
    });
  }
}
