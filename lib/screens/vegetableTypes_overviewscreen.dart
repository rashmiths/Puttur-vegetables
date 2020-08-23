import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:puttur_vegetables/providers/ProductType.dart';
import 'package:puttur_vegetables/providers/ProductTypes.dart';
import 'package:puttur_vegetables/providers/cart.dart';
import 'package:puttur_vegetables/screens/cartscreen.dart';
import 'package:puttur_vegetables/widgets/appdrawer.dart';
import 'package:puttur_vegetables/widgets/custom_appBar.dart';
import 'package:puttur_vegetables/widgets/vegetableTypeItem.dart';
import 'package:translator/translator.dart';

class VegetableTypesOverViewScreen extends StatefulWidget {
  final bool load;
  const VegetableTypesOverViewScreen({this.load, Key key}) : super(key: key);

  @override
  _VegetableTypesOverViewScreenState createState() =>
      _VegetableTypesOverViewScreenState();
}

class _VegetableTypesOverViewScreenState
    extends State<VegetableTypesOverViewScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var _isInit = true;
  var _isLoading = false;
  var _error = false;
  String _message;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      print(widget.load);

      if (widget.load) {
        Provider.of<ProductTypes>(context).fetchAndSetProducts().then((result) {
          setState(() {
            _isLoading = false;
          });
          // final vegie = Provider.of<ProductTypes>(context, listen: false);
          // final vegieTypes = vegie.productTypes;
          // for (int i = 0; i < vegieTypes.length; i++)
          //   translateToKannada(vegieTypes[i].title, i)
          //       .then((value) => setState(() {
          //             _isLoading = false;
          //           }));
        }).catchError((error) {
          setState(() {
            _message = error;
            _error = true;
            _isLoading = false;
          });
        });

        _isInit = false;
        super.didChangeDependencies();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // var _kannadalist;

  // @override
  // void initState() {
  //   print('initSTate Running');
  //   _kannadalist = [
  //     '',
  //     '',
  //     '',
  //     '',
  //     '',
  //     '',
  //     '',
  //     '',
  //     '',
  //     '',
  //     '',
  //     '',
  //     '',
  //     '',
  //     '',
  //     '',
  //     '',
  //     '',
  //     '',
  //     '',
  //     ''
  //   ];
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final vegetableType = Provider.of<ProductTypes>(context, listen: false);
    final vegetableTypes = vegetableType.productTypes;
    return RefreshIndicator(
      onRefresh: () {
        //Navigator.of(context).pop();
        return Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) {
          return VegetableTypesOverViewScreen(
            load: true,
          );
        }));
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(),
        appBar: CustomAppBar(
          'Puttur Vegetables',
          true,
          true,
          false,
          scaffoldkey: _scaffoldKey,
        ),
        // AppBar(
        //   title: Text('Puttur Vegetables'),
        //   actions: [
        //     IconButton(
        //         icon: Icon(Icons.shopping_cart),
        //         onPressed: () {
        //           Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        //             return CartScreen();
        //           }));
        //         })
        //   ],
        // ),

        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _error
                ? Center(
                    child: Card(
                      elevation: 20,
                      child: Container(
                        height: 180,
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.0,
                              ),
                              child: Text(_message),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Text('Please Try Again'),
                            ),
                            FlatButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (_) {
                                    return VegetableTypesOverViewScreen(
                                      load: true,
                                    );
                                  }));
                                },
                                icon: Icon(Icons.thumb_up),
                                label: Text('Try Again'))
                          ],
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (ctxt, index) {
                      print(vegetableTypes[index].title);
                      // translateToKannada(vegetableTypes[index].title);

                      return VegetableTypeItem(
                        vegetableTypes[index],
                        //_kannadalist[index]
                      );
                    },
                    itemCount: vegetableTypes.length,
                  ),
        floatingActionButtonLocation:
            _isLoading ? null : FloatingActionButtonLocation.endFloat,
        floatingActionButton: _isLoading
            ? null
            : FloatingActionButton.extended(
                onPressed: () {
                  final cart = Provider.of<Cart>(context, listen: false);
                  final items = cart.items.values.toList();
                  String message = '';
                  for (int i = 0; i < items.length; i++) {
                    message =
                        message + items[i].title + ' - ${items[i].quantity}\n';
                  }
                  FlutterOpenWhatsapp.sendSingleMessage("60105602182",
                      "Hi I am Intrested in buying following items\n$message");
                  Hive.box('cart').clear();
                  cart.clear();
                },
                label: Text(
                  'ORDER',
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
                backgroundColor: Colors.black,
              ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.black,
        //   splashColor: Colors.white,
        //   onPressed: () {},
        //   child: Icon(
        //     Icons.send,
        //     size: 30,
        //     color: Colors.white,
        //   ),
        // ),
      ),
    );
  }

//   Future translateToKannada(String input, int index) async {
//     final translator = GoogleTranslator();
//     return translator.translate(input, to: 'kn').then((s) {
//       print("Source: " +
//           input +
//           "\n"
//               "Translated: " +
//           s +
//           "\n");
//       _kannadalist[index] = s;
//     });
//   }
}
