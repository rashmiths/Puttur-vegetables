import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:puttur_vegetables/providers/Product.dart';
import 'package:puttur_vegetables/providers/cart.dart';
import 'package:puttur_vegetables/screens/cartscreen.dart';

class CategoryItem extends StatefulWidget {
  final Product response;
  //final String kannadaTitle;
  const CategoryItem(this.response, {Key key}) : super(key: key);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  final priceNode = FocusNode();

  @override
  void dispose() {
    priceNode.dispose();
    super.dispose();
  }

  @override

  // Widget build(BuildContext context) {
  //   return InkWell(
  //     onTap: () {
  //       //selectCategory(context);
  //     },
  //     child: Container(
  //       height: 200,
  //       width: 200,
  //       padding: EdgeInsets.all(15.0),
  //       // child: Text(
  //       //   response.title,
  //       //   style: Theme.of(context).textTheme.title,
  //       // ),
  //       decoration: BoxDecoration(
  //         image: DecorationImage(
  //             image: NetworkImage(response.imageUrl), fit: BoxFit.cover),
  //         borderRadius: BorderRadius.circular(15),
  //       ),
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    return (!widget.response.availability)
        ? Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.network(
                        widget.response.imageUrl,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Container(
                          height: 150,
                          color: Colors.black54,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Text(
                            'Not Available',
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                                color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: 20,
                        right: 5,
                        child: Container(
                            color: Colors.black54,
                            //width: 200,
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 40),
                            child: Text(
                              widget.response.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )))
                  ],
                ),
              ],
            ),
          )
        : Form(
            child: InkWell(
              onTap: () {
                final _form = GlobalKey<FormState>();

                String quantity;
                String amount = 'Kgs';

                void _saveForm() {
                  final isValid = _form.currentState.validate();
                  if (!isValid) {
                    print('not valid');
                    return;
                  }

                  _form.currentState.save();
                  print(quantity);

                  if (double.tryParse(quantity) == null) {
                    return;
                  }

                  Provider.of<Cart>(context, listen: false).addItem(
                      widget.response.id,
                      widget.response.price,
                      widget.response.title,
                      quantity.toString() + amount);
                  Navigator.of(context).pop();
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Added item to cart !',
                      ),
                      duration: Duration(seconds: 3),
                      action: SnackBarAction(
                        label: 'CART',
                        onPressed: () {
                          // Provider.of<Cart>(context, listen: false)
                          //     .removeSingleItem(widget.response.id);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return CartScreen();
                          }));
                        },
                      ),
                    ),
                  );
                }

                bool isKg = true;
                bool isGms = false;
                return showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return Dialog(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(width: 2.0, color: Colors.black)),
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          height: 240,
                          child: Form(
                            key: _form,
                            child: ListView(
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Quantity(only numbers)',
                                  ),
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  // initialValue: title,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(priceNode);
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'please Enter the Quantity';
                                    }
                                    if (value.startsWith(
                                        new RegExp(r'[A-Z][a-z]'))) {
                                      return 'cannot enter a alphabet';
                                    }
                                    if (value
                                        .contains(new RegExp(r'[A-Z][a-z]'))) {
                                      return 'cannot enter a alphabet';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {
                                    quantity = value;
                                  },
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text('KG:'),
                                        IconButton(
                                            icon: Icon(isKg
                                                ? Icons.radio_button_checked
                                                : Icons.radio_button_unchecked),
                                            onPressed: () {
                                              setState(() {
                                                isKg = !isKg;
                                                isGms = !isGms;
                                                amount = 'Kg';
                                              });
                                            }),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Gms:'),
                                        IconButton(
                                            icon: Icon(isGms
                                                ? Icons.radio_button_checked
                                                : Icons.radio_button_unchecked),
                                            onPressed: () {
                                              setState(() {
                                                isGms = !isGms;
                                                isKg = !isKg;

                                                amount = 'Gms';
                                              });
                                            }),
                                      ],
                                    )
                                  ],
                                ),
                                RaisedButton(
                                  color: Colors.black,
                                  onPressed: () {
                                    _saveForm();
                                  },
                                  child: Text(
                                    'Add To Cart',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  },
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                margin: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.network(
                            widget.response.imageUrl,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                            bottom: 20,
                            right: 5,
                            child: Container(
                                color: Colors.black54,
                                // width: 250,
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 40),
                                child: Text(
                                  widget.response.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                )))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Icon(Icons.attach_money),
                              SizedBox(width: 6),
                              Text('${widget.response.price} Rs/Kg'),
                            ],
                          ),
                          // Column(
                          //   children: <Widget>[
                          //     Icon(Icons.work),
                          //     SizedBox(width: 6),
                          //     Text('${widget.response.description}'),
                          //   ],
                          // ),
                          //$$$$$$$$$$$$$$
                          Column(
                            children: <Widget>[
                              Icon(Icons.add_shopping_cart),
                              SizedBox(width: 6),
                              Text('Add To Cart'),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
