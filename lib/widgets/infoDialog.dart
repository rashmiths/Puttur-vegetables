import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoDialog extends StatelessWidget {
  final String page;
  InfoDialog(this.page, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return page == 'MapScreen'
        ? Dialog(
            elevation: 20,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      'How to navigate to the shop?',
                      style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                        '# \tTap on the Red Marker \n # \ttwo option will popup in the bottom \n # \tclick enter icon to see direction \n # \tmap icon to locate'),
                  )
                ],
              ),
            ),
          )
        : Dialog(
            elevation: 20,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      'How to Delete a cart item?',
                      style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text('Swipe the desired item card towards left'),
                  )
                ],
              ),
            ),
          );
  }
}
