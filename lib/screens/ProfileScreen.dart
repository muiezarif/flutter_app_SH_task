import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdemotask/bloc/AuthBloc.dart';
import 'package:flutterappdemotask/screens/LoginScreen.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var name = "Muiez Arif";
  File _selectedFile;

  Widget getImageWidget(url) {
    if (_selectedFile != null) {
      return CircleAvatar(child: Image.file(_selectedFile), radius: 60.0);
    } else {
      return CircleAvatar(
          backgroundImage: NetworkImage(
            url,
          ),
          radius: 60.0);
    }
  }

  getImage(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(
            ratioX: 1,
            ratioY: 1,
          ),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.blueAccent, toolbarTitle: "Cropper"));
      setState(() {
        _selectedFile = cropped;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
        backgroundColor: Colors.blueAccent,
        actions: [
          FlatButton.icon(
            label: Text("Sign Out"),
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              authBloc.logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          )
        ],
      ),
      backgroundColor: Colors.white12,
      body: Center(
        child: StreamBuilder<FirebaseUser>(
            stream: authBloc.currentUser,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    snapshot.data.displayName,
                    style: TextStyle(fontSize: 35.0, color: Colors.white),
                  ),
                  Text(
                    snapshot.data.email,
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  getImageWidget(snapshot.data.photoUrl),
                  Container(
                    width: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FlatButton.icon(
                            onPressed: () {
                              getImage(ImageSource.gallery);
                            },
                            icon: Icon(Icons.file_upload),
                            label: Text("Gallery")),
                        FlatButton.icon(
                            onPressed: () {
                              getImage(ImageSource.camera);
                            },
                            icon: Icon(Icons.camera),
                            label: Text("Camera")),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100.0,
                  ),
                  Container(
                    width: 200,
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter text to change name...'),
                      onSubmitted: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
