import 'package:badgerhacks/pages/addnote.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';

final titleController = TextEditingController();
final firestoreInstance = FirebaseFirestore.instance;
AsyncSnapshot<DocumentSnapshot> snapshot;
Stream<QuerySnapshot> newStream;

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  void initState() {
    super.initState();
    newStream = firestoreInstance.collection('notes').snapshots();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'My Notes'.toUpperCase(),
          style: TextStyle(fontFamily: 'ArimaMadurai', color: Colors.black),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return AddNotes();
                    },
                  ),
                );
              })
        ],
      ),
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
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
                                              child: Text(
                                                  groupUsers[index]
                                                      .data()['title'],
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
                                              .collection('blog')
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

class AddNotes extends StatefulWidget {
  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(
                Icons.cancel,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Add a Note",
                  style: TextStyle(fontFamily: 'ArimaMadurai', fontSize: 30),
                ),
              )),
          // ignore: deprecated_member_use
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 1,
                child: Image.asset('images/create.png')),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ButtonTheme(
              height: 50,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: HexColor('#FF84AF'))),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return NoteCreate();
                      },
                    ),
                  );
                },
                color: Colors.white,
                textColor: HexColor('#FF84AF'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text("Create a Note".toUpperCase(),
                          style: TextStyle(fontFamily: 'Roboto')),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ButtonTheme(
              height: 50,
              // ignore: deprecated_member_use
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: HexColor('#FF84AF'))),
                onPressed: () {
                  null;
                },
                color: Colors.white,
                textColor: HexColor('#FF84AF'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text("Voice Note".toUpperCase(),
                          style: TextStyle(fontFamily: 'Roboto')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
