import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puttur_vegetables/providers/Products.dart';
import 'package:puttur_vegetables/widgets/CategoryItem.dart';
import 'package:puttur_vegetables/widgets/custom_appBar.dart';
import 'package:translator/translator.dart';

class ListOfItemsScreen extends StatefulWidget {
  final String type, title;
  ListOfItemsScreen(this.type, this.title, {Key key}) : super(key: key);

  @override
  _ListOfItemsScreenState createState() => _ListOfItemsScreenState();
}

class _ListOfItemsScreenState extends State<ListOfItemsScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _error = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts(widget.type).then((_) {
        // final vegie = Provider.of<Products>(context, listen: false);
        // final vegieTypes = vegie.items;
        // for (int i = 0; i < vegieTypes.length; i++)
        //   translateToKannada(vegieTypes[i].title, i)
        //       .then((value) => setState(() {
        //             _isLoading = false;
        //           }));
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) {
        print(error);
        setState(() {
          _error = true;
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // var _kannadalist;
  // @override
  // void initState() {
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
  //     '',
  //     '',
  //   ];
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final response = Provider.of<Products>(context, listen: false);
    final responseList = response.items;
    return RefreshIndicator(
      onRefresh: () {
        return Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) {
          return ListOfItemsScreen(widget.type, widget.title);
        }));
      },
      child: Scaffold(
        appBar: CustomAppBar(widget.title, false, false, false),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _error
                ? Container(
                    child: Center(
                      child: Text('Error'),
                    ),
                  )
                :

                // GridView.builder(
                //   padding: EdgeInsets.all(10),
                //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                //     maxCrossAxisExtent: 400,
                //     childAspectRatio: 3 / 2,
                //     crossAxisSpacing: 20,
                //     mainAxisSpacing: 20,
                //   ),
                //   itemBuilder: (ctxt, index) {
                //     return CategoryItem(responseList[index]);
                //   },
                //   itemCount: responseList.length,
                // ),
                ListView.builder(
                    itemBuilder: (ctxt, index) {
                      return CategoryItem(responseList[index]);
                    },
                    itemCount: responseList.length,
                  ),
      ),
    );
  }

  // Future translateToKannada(String input, int index) async {
  //   final translator = GoogleTranslator();
  //   return translator.translate(input, to: 'kn').then((s) {
  //     print("Source: " +
  //         input +
  //         "\n"
  //             "Translated: " +
  //         s +
  //         "\n");
  //     _kannadalist[index] = s;
  //   });
  // }
}
