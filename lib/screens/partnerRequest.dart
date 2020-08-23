import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PartnerRequest extends StatefulWidget {
  @override
  _PartnerRequestState createState() => _PartnerRequestState();
}

class _PartnerRequestState extends State<PartnerRequest> {
  final priceNode = FocusNode();
  final _form = GlobalKey<FormState>();
  String name;
  String phNo;

  @override
  void dispose() {
    priceNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _form,
        child: Card(
          elevation: 5.0,
          child: Container(
            padding: EdgeInsets.only(
                // top: 10.0,
                left: 10.0,
                right: 10.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(priceNode);
                  },
                  onSaved: (value) {
                    name = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'please Enter the Title';
                    }
                    if (value.startsWith(RegExp(r'[0-9]'))) {
                      return 'Title cannot start with numbers';
                    }

                    return null;
                  },
                ),
                TextFormField(
                    decoration: InputDecoration(labelText: 'Phone No'),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    focusNode: priceNode,
                    onSaved: (value) {
                      phNo = value;
                    },
                    onFieldSubmitted: (_) {
                      final isValid = _form.currentState.validate();
                      if (!isValid) {
                        return;
                      }

                      _form.currentState.save();
                      _launchURL('rashmiths28@gmail.com', 'PartnerShip',
                        'Myself $name and my Contact No is $phNo,I would Like to PartnerWith you');

                      // BlocProvider.of<CounterBloc>(context)
                      //     .add(IncrementEvent(recentTodo));

                      Navigator.of(context).pop();
                    }),
                RaisedButton(
                  color: Colors.black87,
                  onPressed: () {
                    final isValid = _form.currentState.validate();
                    if (!isValid) {
                      return;
                    }

                    _form.currentState.save();
                    _launchURL('rashmiths28@gmail.com', 'PartnerShip',
                        'Myself $name and my Contact No is $phNo,I would Like to PartnerWith you');

                    // BlocProvider.of<CounterBloc>(context)
                    //     .add(IncrementEvent(recentTodo));

                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Send Request',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
