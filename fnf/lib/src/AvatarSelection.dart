import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis/cloudasset/v1.dart';

import '../profile/Feed.dart';

class AvatarSelectionPage extends StatefulWidget {
  const AvatarSelectionPage({Key? key}) : super(key: key);

  @override
  State<AvatarSelectionPage> createState() => _AvatarSelectionPageState();
}

class _AvatarSelectionPageState extends State<AvatarSelectionPage> {
  var submitButtonOnPressed = null;
  String selectedAvatarPath = '';

  String group1ThumbnailPath = "assets/images/logo1.png";
  String group2ThumbnailPath = "assets/images/logo1.png";
  String group3ThumbnailPath = "assets/images/logo1.png";

  String defaultThumbnailPath = "assets/images/logo1.png";
  // connect to firestore db
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final loggedInUser = FirebaseAuth.instance.currentUser;

  openDialog(String avatarGroup) async {
    // IMPORTANT: this below is how you would read every file listed as an asset,
    // which could be important for this project or others when you want to
    // iterate over every asset and do something

    // the chunk of code belows looks at all the directories listed as 'assets'
    // in the pubspec.yaml and for each of those directories it will store each
    // file path  in keys. Notice that it is not recursive (does not look in folders
    // within folders, unless explicitly those folders are also in the pubspec.yaml
    // as assets) in searching for files and does not add directories.

    // Ex: say the folder 'animals' is listed in assets

    // animals (dir):
    // - dogs (dir)
    // - cats (dir)
    // - zooImage (jpeg)

    // only zooImage.jpeg will be added to keys since 'dogs' and 'cats' are directories,
    // not files. In order for the contents (again, files only not folders) of dogs
    // to be put in keys, 'animals/dogs/' will need to explicitly be stated as
    // an asset in the pubspec.yaml. Any file listed explicitly in the pubspec.yaml
    // as an asset will also be in keys

    var assets = await rootBundle.loadString('AssetManifest.json');

    Map manifestMap = json.decode(assets);
    final keys = manifestMap.keys.toList();
    // lets say then, I have many files / directories explicitly listed as assets
    // but I only want to iterate over those in the 'assets/avatars/${some_directory}'
    // folder. To this, simply make sure the keys start with that path
    List<String> avatarPaths = [];
    String desiredPath = 'assets/avatars/${avatarGroup}';
    int desiredPathLength = desiredPath.length;

    for (String key in keys) {
      if (key.length <= desiredPathLength) {
        continue;
      }

      if (key.substring(0, desiredPathLength) == desiredPath) {
        avatarPaths.add(key);
      } else {}
    }

    List<Row> rowsOfAvatars = [];

    for (int i = 0; i < avatarPaths.length; i += 3) {
      List<Widget> avatarWidgets = [];
      for (int j = 0; j < 3 && (i + j) < avatarPaths.length; j++) {
        String path = avatarPaths[i + j];
        double borderSize = 0;

        if (path == selectedAvatarPath) {
          borderSize = 2.5;
        }

        Widget avatar = Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: borderSize)),
            child: IconButton(
                iconSize: 75,
                onPressed: () {
                  selectedAvatarPath = path;
                  if (submitButtonOnPressed == null) {
                    submitButtonOnPressed = () async {
                      var userRef =
                      db.collection("users").doc(loggedInUser!.email);
                      await userRef.update({"avatarPath": selectedAvatarPath});
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FeedPage()),
                      );
                    };
                  }
                  Navigator.of(context).pop();
                  openDialog(avatarGroup);
                  setState(() {});
                },
                icon: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(path), fit: BoxFit.fill)),
                )));

        avatarWidgets.add(avatar);
      }
      Row row = Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: avatarWidgets); // row of avatar groups
      rowsOfAvatars.add(row);
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey.withOpacity(.75),
          title: Center(
              child: Text(
                "SO MANY OPTIONS!",
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              )),
          content: SingleChildScrollView(
            child: Column(children: rowsOfAvatars),
          ),
          actionsPadding: EdgeInsets.only(bottom: 15, right: 15),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFAF3037)),
                onPressed: submitButtonOnPressed,
                child: Text(
                  "Select",
                  style: GoogleFonts.montserrat(),
                ))
          ],
        ));
  }

  void setThumbnailPaths() async {
    var assets = await rootBundle.loadString('AssetManifest.json');
    Map manifestMap = json.decode(assets);
    final keys = manifestMap.keys.toList();

    String desiredPath = 'assets/avatars/';
    int desiredPathLength = desiredPath.length;

    for (String key in keys) {
      if (key.length <= desiredPathLength) {
        continue;
      }

      if (key.substring(0, desiredPathLength) == desiredPath) {
        // check if path can be of the thumbnail for group 1
        if (group1ThumbnailPath == defaultThumbnailPath) {
          String group1Path = desiredPath + "group1/";
          int group1PathLength = group1Path.length;
          if (key.substring(0, group1PathLength) == group1Path) {
            group1ThumbnailPath = key;
          }
        } else if (group2ThumbnailPath == defaultThumbnailPath) {
          String group2Path = desiredPath + "group2/";
          int group2PathLength = group2Path.length;
          if (key.substring(0, group2PathLength) == group2Path) {
            group2ThumbnailPath = key;
          }
        } else {
          String group3Path = desiredPath + "group3/";
          int group3PathLength = group3Path.length;
          if (key.substring(0, group3PathLength) == group3Path) {
            group3ThumbnailPath = key;
          }
        }
        if (group1ThumbnailPath != defaultThumbnailPath &&
            group2ThumbnailPath != defaultThumbnailPath &&
            group3ThumbnailPath != defaultThumbnailPath) {
          setState(() {});
          return;
        }
      } else {}
    }
  }

  void setUp() async {
    setThumbnailPaths();
  }

  @override
  void initState() {
    setUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFAF3037),
        body: Center(
            child: Padding(
                padding: EdgeInsets.only(top: 100),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // page header
                      Text(
                        "SELECT AN AVATAR!",
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 150),
                          child:
                          // row of avatar groups
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  iconSize: 100,
                                  onPressed: () {
                                    openDialog("group1");
                                  },
                                  icon: Container(
                                    decoration: BoxDecoration(shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(group1ThumbnailPath),
                                            fit: BoxFit.fill
                                        )),
                                  )),
                              IconButton(
                                  onPressed: () {
                                    openDialog("group2");
                                  },
                                  iconSize: 100,
                                  icon: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(group2ThumbnailPath),
                                            fit: BoxFit.fill
                                        ),
                                        shape: BoxShape.circle
                                    ),)),
                              IconButton(
                                  iconSize: 100,
                                  onPressed: () {
                                    openDialog("group3");
                                  },
                                  icon: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(group3ThumbnailPath),
                                            fit: BoxFit.fill
                                        )
                                    ),
                                  )),
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 75),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: Text(
                            "Continue",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                                color: Color(0xFFAF3037)),
                          ),
                          onPressed: submitButtonOnPressed,
                        ),
                      )
                    ]))));
  }
}