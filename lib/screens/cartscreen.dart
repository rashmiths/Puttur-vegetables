import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:puttur_vegetables/widgets/cartitem.dart';
import 'package:puttur_vegetables/widgets/custom_appBar.dart';

import '../providers/cart.dart' show Cart;

import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: CustomAppBar('Your Cart', false, false, true, page: 'CartScreen'),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity.toString(),
                cart.items.values.toList()[i].title,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  // var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'ORDER NOW',
        style: GoogleFonts.openSans(
            textStyle: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      ),
      onPressed: () {
        final items = widget.cart.items.values.toList();
        String message = '';
        for (int i = 0; i < items.length; i++) {
          message = message + items[i].title + ' - ${items[i].quantity}\n';
        }
        // setState(() {
        //   _isLoading = true;
        // });
        // await Provider.of<Orders>(context, listen: false).addOrder(
        //   widget.cart.items.values.toList(),
        //   widget.cart.totalAmount,
        // );
        FlutterOpenWhatsapp.sendSingleMessage("60105602182",
            "Hi I am Intrested in buying following items\n + $message");
        var box = Hive.openBox('cart');
        Hive.box('cart').clear();
        widget.cart.clear();
      },
      textColor: Colors.blue,
    );
  }
}
