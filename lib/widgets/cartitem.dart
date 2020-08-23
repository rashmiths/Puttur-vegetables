import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final num price;
  final String quantity;
  final String title;

  CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
     num intquantity;
     String kquantity='';
     print(quantity);
     if (quantity.contains('K')) {
        for (int i = 0; i < quantity.length; i++) {
          if (quantity[i] == 'K') {
            intquantity = double.parse(kquantity);
            print('##### $price');
            kquantity = '';
            break;
          } else {
             print(quantity[i]);
            kquantity = kquantity + quantity[i];
            print(kquantity);
          }
        }
      } else {
        for (int i = 0; i < quantity.length; i++) {
          if (quantity[i] == 'G') {
            intquantity = double.parse(kquantity);
            intquantity = intquantity* 0.001;
            kquantity = '';
            break;
          } else {
             print(quantity[i]);
            kquantity = kquantity + quantity[i];
             print(kquantity);
          }
        }
      }
      num totalamt=intquantity*price;
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
              'Do you want to remove the item from the cart?',
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    '\$${(price)}',
                  ),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${totalamt.toStringAsFixed(2)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
