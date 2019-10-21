import 'dart:io';
import 'package:carimbinho/pages/carimbo_page.dart';
import 'package:exif/exif.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:carimbinho/core/models/contact.dart';
import 'package:carimbinho/pages/profile_edit_page.dart';
import 'package:carimbinho/pages/qr_code_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  final Contact contact;

  ProfilePage({this.contact});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Contact contact;
  StorageReference storage;

  @override
  void initState() {
    super.initState();
    contact = widget.contact;
    storage = FirebaseStorage.instance.ref().child(contact.email);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: false,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                      child: Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: (contact.foto != null ||
                                    contact.foto.isNotEmpty)
                                ? FileImage(File(contact.foto))
                                : NetworkImage(
                                    "https://cdn2.iconfinder.com/data/icons/solid-glyphs-volume-2/256/user-unisex-512.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () {
                        ImagePicker.pickImage(
                                source: ImageSource.camera, imageQuality: 50)
                            .then((file) {
                          if (file == null) return;
                          setState(() async {
                            File newFile =
                                await rotateAndCompressAndSaveImage(file);
                            final StorageUploadTask upload = storage.putFile(
                                File(newFile.path),
                                StorageMetadata(
                                  contentType: 'image/jpg',
                                ));
                            await upload.onComplete;
                            setState(() {
                              contact.foto = newFile.path == null
                                  ? contact.foto
                                  : newFile.path;
                            });
                          });
                        });
                      }),
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const SizedBox(
                  width: 10.0,
                ),
                IconButton(
                  padding: EdgeInsets.only(bottom: 10.0),
                  icon: Icon(FontAwesomeIcons.stamp),
                  iconSize: 40.0,
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 50.0,
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.star),
                  iconSize: 40.0,
                  onPressed: () async {
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CarimboPage()));
                  },
                ),
                const SizedBox(
                  width: 50.0,
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.search),
                  iconSize: 40.0,
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 50.0,
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.userEdit),
                  iconSize: 40.0,
                  onPressed: () async {
                    final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileEditPage(contact: contact)));
                    setState(() {
                      contact = result == null ? contact : result;
                    });
                  },
                ),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
          ],
        ),
    );
  }

  Future<File> rotateAndCompressAndSaveImage(File image) async {
    int rotate = 0;
    List<int> imageBytes = await image.readAsBytes();
    Map<String, IfdTag> exifData = await readExifFromBytes(imageBytes);

    if (exifData != null &&
        exifData.isNotEmpty &&
        exifData.containsKey("Image Orientation")) {
      IfdTag orientation = exifData["Image Orientation"];
      int orientationValue = orientation.values[0];

      if (orientationValue == 3) {
        rotate = 180;
      }

      if (orientationValue == 6) {
        rotate = -90;
      }

      if (orientationValue == 8) {
        rotate = 90;
      }
    }

    List<int> result = await FlutterImageCompress.compressWithList(imageBytes,
        quality: 50, rotate: rotate);

    image.writeAsBytesSync(result);

    return image;
  }
}
