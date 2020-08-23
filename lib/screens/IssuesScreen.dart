import 'package:flutter/material.dart';
import 'package:puttur_vegetables/widgets/custom_appBar.dart';

class IssuesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar('ISSUES', false, false, false),
        body: Container(
          padding: const EdgeInsets.all(30.0),
          color: Colors.white,
          child: new Container(
              child: new Column(children: [
            new Padding(padding: EdgeInsets.only(top: 140.0)),
            new Text(
              'Thanks For Helping Us',
              style: new TextStyle(color: Colors.blue, fontSize: 25.0),
            ),
            new Padding(padding: EdgeInsets.only(top: 50.0)),
            new TextFormField(
              decoration: new InputDecoration(
                labelText: "Enter the Issues",
                fillColor: Colors.white,

                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "Issues cannot be empty";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.multiline,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: RaisedButton(
                color: Colors.black,
                onPressed: () {},
                child: Text(
                  'Post The Issue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ])),
        ));
  }
}
