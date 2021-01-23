import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'pages/addnote.dart';

AsyncSnapshot<DocumentSnapshot> snapshot;
Stream<QuerySnapshot> newStream;
void main() => runApp(Flyer());

class Flyer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File pickedImage;
  var text = '';

  bool imageLoaded = false;

  Future pickImage() async {
    var awaitImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = awaitImage;
      imageLoaded = true;
    });
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await textRecognizer.processImage(visionImage);

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          setState(() {
            text = text + word.text + ' ';
          });
        }
        text = text + '\n';
      }
    }
    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.view_agenda, color: Colors.black),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return MyFlyers();
                    },
                  ),
                );
              })
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('My Flyers'.toUpperCase(),
            style: TextStyle(
              fontFamily: 'ArimaMadurai',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
      backgroundColor: HexColor('#FFFFFF'),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30.0),
            imageLoaded
                ? Center(
                    child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(blurRadius: 20),
                      ],
                    ),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    height: 250,
                    child: Image.file(
                      pickedImage,
                      fit: BoxFit.cover,
                    ),
                  ))
                : Container(),
            SizedBox(height: 10.0),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ButtonTheme(
                  height: 50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: HexColor('#FFFFFF'))),
                    onPressed: () {
                      pickImage();
                    },
                    color: Colors.white,
                    textColor: HexColor('#000000'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text("Upload".toUpperCase(),
                              style: TextStyle(fontFamily: 'Roboto')),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            SizedBox(height: 10.0),
            text == ''
                ? Text(
                    'Upload an image',
                    style: TextStyle(fontFamily: 'Roboto'),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SelectableText(
                          text,
                          style: TextStyle(
                              fontFamily: 'ArimaMadurai',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ButtonTheme(
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: HexColor('#FFFFFF'))),
                  onPressed: () async {
                    firestoreInstance
                        .collection('flyers')
                        .doc(
                            '${now.hour.toString()}${now.minute.toString()}${now.second.toString()}')
                        .set({
                      "flyer": text,
                      "id":
                          '${now.hour.toString()}${now.minute.toString()}${now.second.toString()}',
                    }).then((_) {
                      print("success!");
                    });
                  },
                  color: Colors.white,
                  textColor: HexColor('#000000'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text("Save".toUpperCase(),
                            style: TextStyle(fontFamily: 'Roboto')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyFlyers extends StatefulWidget {
  @override
  _MyFlyersState createState() => _MyFlyersState();
}

class _MyFlyersState extends State<MyFlyers> {
  @override
  void initState() {
    super.initState();
    newStream = firestoreInstance.collection('flyers').snapshots();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.cancel, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('Flyers'.toUpperCase(),
            style: TextStyle(
              fontFamily: 'ArimaMadurai',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Container(
          child: StreamBuilder(
            stream: newStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              var totalgroupCount = 0;
              List<DocumentSnapshot> groupUsers;
              if (snapshot.hasData) {
                groupUsers = snapshot.data.documents;
                totalgroupCount = groupUsers.length;
                return (Container(
                  child: ListView.builder(
                      itemCount: groupUsers.length,
                      itemBuilder: (context, int index) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Slidable(
                              actionPane: SlidableDrawerActionPane(),
                              actionExtentRatio: 0.25,
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: SelectableText(
                                                  groupUsers[index]
                                                      .data()['flyer'],
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'ArimaMadurai',
                                                      fontSize: 20,
                                                      color:
                                                          HexColor('#000000'))),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              secondaryActions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: HexColor('#FF0D0D'),
                                    ),
                                    child: Container(
                                      child: IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.white),
                                        onPressed: () {
                                          print("Delete triggered");
                                          firestoreInstance
                                              .collection('flyers')
                                              .doc(groupUsers[index]
                                                  .data()['id'])
                                              .delete()
                                              .then((_) {
                                            print("success!");
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
