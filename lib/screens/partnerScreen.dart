import 'package:flutter/material.dart';
import 'package:puttur_vegetables/screens/partnerRequest.dart';
import 'package:puttur_vegetables/widgets/custom_appBar.dart';

class PartnerScreen extends StatelessWidget {
  const PartnerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Partner with us', false, false, false),
      body: Center(
        child: Container(
          child: Text('PARTNER WITH US'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (_) {
                return PartnerRequest();
              });
        },
        label: Text(
          'Ready To Join',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
