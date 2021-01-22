import 'package:badgerhacks/home.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    Home(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: HexColor('#FFDFCA'),
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          showSelectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.smart_button, color: HexColor('#545E78')),
              title: new Text(
                'Drag and Drop',
                style:
                    TextStyle(color: HexColor('#545E78'), fontFamily: 'Roboto'),
              ),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.notes, color: HexColor('#545E78')),
              title: new Text(
                'My Notes',
                style:
                    TextStyle(color: HexColor('#545E78'), fontFamily: 'Roboto'),
              ),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.panorama_photosphere,
                  color: HexColor('#545E78')),
              title: new Text(
                'Flyers',
                style:
                    TextStyle(color: HexColor('#545E78'), fontFamily: 'Roboto'),
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
