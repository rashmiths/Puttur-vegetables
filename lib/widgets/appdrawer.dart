import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puttur_vegetables/screens/IssuesScreen.dart';
import 'package:puttur_vegetables/screens/authorScreen.dart';
import 'package:puttur_vegetables/screens/mapScreen.dart';
import 'package:puttur_vegetables/screens/partnerScreen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
            icon: Icons.location_on,
            text: 'Location',
            onTap: () =>
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return MapSample();
            })),
          ),
          _createDrawerItem(
            icon: Icons.blur_on,
            text: 'Partner With Us',
            onTap: () =>
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return PartnerScreen();
            })),
          ),
          Divider(),
          _createDrawerItem(
            icon: Icons.contacts,
            text: 'Contact',
          ),
          Divider(),
          _createDrawerItem(
            icon: Icons.face,
            text: 'Authors',
            onTap: () =>
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return AuthorScreen();
            })),
          ),
          Divider(),
          _createDrawerItem(
            icon: Icons.bug_report,
            text: 'Report an issue',
            onTap: () =>
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return IssuesScreen();
            })),
          ),
          ListTile(
            title: Text('0.0.1'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

Widget _createHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('assets/images/photo.jpg'))),
      child: Stack(children: <Widget>[
        Positioned(
          bottom: 12.0,
          left: 16.0,
          child: Text(
            "Puttur Vegetables",
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ]));
}

Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
