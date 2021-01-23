import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

final bodyController = TextEditingController();
final firestoreInstance = FirebaseFirestore.instance;

DateTime now = DateTime.now();
String newDate = DateFormat('EEE d MMM, kk:mm').format(now);

class NoteCreate extends StatefulWidget {
  @override
  _NoteCreateState createState() => _NoteCreateState();
}

class _NoteCreateState extends State<NoteCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Create a Note".toUpperCase(),
              style: TextStyle(
                  fontFamily: 'ArimaMadurai',
                  color: Colors.white,
                  fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: HexColor('#353535'),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: TextFormField(
                    controller: bodyController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'ArimaMadurai'),
                    decoration: new InputDecoration(
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintStyle: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.white54,
                        fontSize: 15,
                      ),
                      labelStyle:
                          TextStyle(fontFamily: 'Roboto', color: Colors.white),
                      hintText: 'Write here...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ButtonTheme(
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: HexColor('#FFFFFF'))),
                  onPressed: () {
                    newRecord();
                    print("Swedish house mafia");
                    clear();
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                  textColor: HexColor('#000000'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text("Done".toUpperCase(),
                            style: TextStyle(fontFamily: 'Roboto')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void newRecord() async {
  firestoreInstance
      .collection('notes')
      .doc(
          '${now.hour.toString()}${now.minute.toString()}${now.second.toString()}')
      .set({
    "body": bodyController.text,
    "id":
        '${now.hour.toString()}${now.minute.toString()}${now.second.toString()}',
  }).then((_) {
    print("success!");
  });
}

void clear() {
  bodyController.clear();
}
