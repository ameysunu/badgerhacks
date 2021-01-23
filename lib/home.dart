import 'package:flutter/material.dart';
import 'login.dart';

bool isSuccessful = false;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "$name's Schedule",
          style: TextStyle(fontFamily: 'Roboto', color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Draggable(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "ACROPOLIS",
                          style: TextStyle(
                              fontFamily: 'ArimaMadurai',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Athens, Greece",
                          style: TextStyle(
                            fontFamily: 'ArimaMadurai',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                feedback: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "ACROPOLIS",
                          style: TextStyle(
                              fontFamily: 'ArimaMadurai',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Athens, Greece",
                          style: TextStyle(
                            fontFamily: 'ArimaMadurai',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                data: 'First',
                childWhenDragging: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                // childWhenDragging: Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: Container(
                //     width: MediaQuery.of(context).size.width * 1,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15.0),
                //       color: Colors.white,
                //     ),
                //     child: Column(
                //       children: [
                //         Text(
                //           "CAVE SANTORINI",
                //           style: TextStyle(
                //               fontFamily: 'ArimaMadurai',
                //               fontSize: 20,
                //               fontWeight: FontWeight.bold),
                //         ),
                //         Text(
                //           "Santorini, Greece",
                //           style: TextStyle(
                //             fontFamily: 'ArimaMadurai',
                //             fontSize: 15,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5.0, 10, 5),
                child: Row(
                  children: [
                    Text(
                      "8:00 AM",
                      style: TextStyle(
                        fontFamily: 'ArimaMadurai',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 2.0,
                        width: MediaQuery.of(context).size.width * 0.75,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "SKAROS ROCK",
                        style: TextStyle(
                            fontFamily: 'ArimaMadurai',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Santorini, Greece",
                        style: TextStyle(
                          fontFamily: 'ArimaMadurai',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5.0, 10, 5),
                child: Row(
                  children: [
                    Text(
                      "9:00 AM",
                      style: TextStyle(
                        fontFamily: 'ArimaMadurai',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 2.0,
                        width: MediaQuery.of(context).size.width * 0.75,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "KAMARI BEACH",
                        style: TextStyle(
                            fontFamily: 'ArimaMadurai',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Santorini, Greece",
                        style: TextStyle(
                          fontFamily: 'ArimaMadurai',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5.0, 10, 5),
                child: Row(
                  children: [
                    Text(
                      "10:00 AM",
                      style: TextStyle(
                        fontFamily: 'ArimaMadurai',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 2.0,
                        width: MediaQuery.of(context).size.width * 0.75,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              DragTarget(
                builder: (context, List<String> candidateData, rejectedData) {
                  return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: isSuccessful
                          ? Container(
                              width: MediaQuery.of(context).size.width * 1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "ACROPOLIS",
                                    style: TextStyle(
                                        fontFamily: 'ArimaMadurai',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Athens, Greece",
                                    style: TextStyle(
                                      fontFamily: 'ArimaMadurai',
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width * 1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "CAVE SANTORINI",
                                    style: TextStyle(
                                        fontFamily: 'ArimaMadurai',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Santorini, Greece",
                                    style: TextStyle(
                                      fontFamily: 'ArimaMadurai',
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ));
                },
                onWillAccept: (data) {
                  return true;
                },
                onAccept: (data) {
                  setState(() {
                    isSuccessful = true;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5.0, 10, 5),
                child: Row(
                  children: [
                    Text(
                      "11:00 AM",
                      style: TextStyle(
                        fontFamily: 'ArimaMadurai',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 2.0,
                        width: MediaQuery.of(context).size.width * 0.75,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "LA CIEL RESTAURANT",
                        style: TextStyle(
                            fontFamily: 'ArimaMadurai',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Santorini, Greece",
                        style: TextStyle(
                          fontFamily: 'ArimaMadurai',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5.0, 10, 5),
                child: Row(
                  children: [
                    Text(
                      "12:00 PM",
                      style: TextStyle(
                        fontFamily: 'ArimaMadurai',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 2.0,
                        width: MediaQuery.of(context).size.width * 0.75,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "LITTLE VENICE",
                        style: TextStyle(
                            fontFamily: 'ArimaMadurai',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Mykonos, Greece",
                        style: TextStyle(
                          fontFamily: 'ArimaMadurai',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5.0, 10, 5),
                child: Row(
                  children: [
                    Text(
                      "1:00 PM",
                      style: TextStyle(
                        fontFamily: 'ArimaMadurai',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 2.0,
                        width: MediaQuery.of(context).size.width * 0.75,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "CHURCH OF PARAPORTIANI",
                        style: TextStyle(
                            fontFamily: 'ArimaMadurai',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Mykonos, Greece",
                        style: TextStyle(
                          fontFamily: 'ArimaMadurai',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5.0, 10, 5),
                child: Row(
                  children: [
                    Text(
                      "2:00 PM",
                      style: TextStyle(
                        fontFamily: 'ArimaMadurai',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 2.0,
                        width: MediaQuery.of(context).size.width * 0.75,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.chat),
        onPressed: () {
          print("Chat triggered");
        },
      ),
    );
  }
}
