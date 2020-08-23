import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Align(
          alignment: Alignment(-1.2, -1.1),
          child: GestureDetector(
              child: Container(
                  width: 100,
                  height: 90,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black),
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
              onTap: () {
                Navigator.of(context).pop();
              }),
        ),
      ),
      GestureDetector(
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2.0)),
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                "assets/images/profileImage.jpeg",
              ),
            ),
          ),
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            //   return FullImage(url);
            // }));
          }),
      Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text(
          'Rashmith S',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.android),
          Text(' & '),
          Text(
            'ios  ',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          ),
          Text(
            'APP Developer',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              child: IconButton(
                  icon: Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                  onPressed: (){
                    _launchURL('rashmiths28@gmail.com', 'PartnerShip',
                        '');
                  }),
            ),
            CircleAvatar(
              backgroundColor: Colors.black,
              child: IconButton(
                  icon: Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  onPressed: null),
            ),
            CircleAvatar(
              backgroundColor: Colors.black,
              child: IconButton(
                  icon: Icon(
                    Icons.open_in_new,
                    color: Colors.white,
                  ),
                  onPressed: (){
                    _launchlinkedin();
                  }
            ),),
            
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Text(
          'Profile',
          style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          )),
        ),
      ),
      Expanded(
        child: ListView(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/flutterlogo.jpg'),
              ),
              title: Text('Flutter Team'),
              subtitle: Text('IRIS NITK'),
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                  child: Icon(
                Icons.school,
                size: 40,
              )),
              title: Text('B.Tech CSE'),
              subtitle: Text('NITK'),
            ),
             Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.web,
                  size: 40,
                ),
              ),
              title: Text('Web Development'),
              subtitle: Text('Knowledge'),
            ),
             Divider(),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/webdev.png'),
              ),
              title: Text('Python & C'),
              subtitle: Text('Coding'),
            ),
             Divider(),
          ],
        ),
      )
    ]));
  }
}
_launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchlinkedin() async{
    String url='https://in.linkedin.com/in/rashmith-s-b6576019a';
     if (await canLaunch('https://in.linkedin.com/in/rashmith-s-b6576019a')) {
      await launch('https://in.linkedin.com/in/rashmith-s-b6576019a');
    } else {
      throw 'Could not launch $url';
    }

  }