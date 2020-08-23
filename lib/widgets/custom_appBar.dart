import 'dart:io';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:puttur_vegetables/providers/cart.dart';
import 'package:puttur_vegetables/screens/cartscreen.dart';
import 'package:puttur_vegetables/screens/mapScreen.dart';
import 'package:puttur_vegetables/screens/vegetableTypes_overviewscreen.dart';
import 'package:puttur_vegetables/widgets/badge.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:puttur_vegetables/widgets/infoDialog.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool iscart;
  final bool isdashboard;
  final bool islocation;
  final scaffoldkey;
  final String page;

  const CustomAppBar(this.title, this.iscart, this.isdashboard, this.islocation,
      {this.scaffoldkey, this.page, Key key})
      : super(key: key);

  @override
  Size get preferredSize => Size(0.0, 56.0);

  @override
  Widget build(BuildContext context) {
    // final _cart = GestureDetector(
    //   onTap: () {
    //     if (iscart) {
    //       Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //         return CartScreen();
    //       }));
    //     }
    //   },
    //   child: Container(
    //       margin: EdgeInsets.only(right: 20.0, top: 10.0, bottom: 10.0),
    //       //height: MediaQuery.of(context).size.height/10,
    //       width: 36,
    //       // decoration: BoxDecoration(
    //       //     border: Border.all(
    //       //       color: Colors.black,
    //       //       width: 1,
    //       //     ),
    //       //   borderRadius: BorderRadius.circular(20.0),

    //       // ),
    //       child: iscart
    //           ? Consumer<Cart>(
    //               builder: (_, cart, ch) => Badge(
    //                 child: ch,
    //                 value: cart.itemCount.toString(),
    //               ),
    //               child: IconButton(
    //                 icon: Icon(
    //                   Icons.shopping_cart,
    //                 ),
    //                 onPressed: () {
    //                   Navigator.of(context)
    //                       .pushReplacement(MaterialPageRoute(builder: (_) {
    //                     return CartScreen();
    //                   }));
    //                 },
    //               ),
    //             )
    //           : null),
    // );

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: GestureDetector(
            onTap: () async {
              if (isdashboard) {
                PermissionStatus permission =
                    await LocationPermissions().requestPermissions();
                PermissionStatus permission2 =
                    await LocationPermissions().checkPermissionStatus();
                if (permission2 == PermissionStatus.granted) {
                  print('GRANTED');
                }

                // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                //   return MapSample();
                // }));
                scaffoldkey.currentState.openDrawer();
              } else {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_) {
                  return VegetableTypesOverViewScreen(
                    load: false,
                  );
                }));
              }
            },
            child: isdashboard
                ? Icon(
                    Icons.dashboard,
                    color: Colors.black,
                  )
                : Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )
            // Image.asset(
            //   "assets/dashboard/hamburger.png",
            //   width: 2.0,
            //   fit: BoxFit.contain,
            // ),
            ),
      ),
      title: Text(
        title,
        style: GoogleFonts.openSans(
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      centerTitle: true,
      actions: <Widget>[
        iscart
            ? Consumer<Cart>(
                builder: (_, cart, ch) => Badge(
                  child: ch,
                  value: cart.itemCount.toString(),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return CartScreen();
                    }));
                  },
                ),
              )
            : page == 'CartScreen' || page == 'MapScreen'
                ? IconButton(
                    icon: Icon(
                      Icons.info,
                      size: 30,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return InfoDialog(page == 'CartScreen'
                                ? 'CartScreen'
                                : 'MapScreen');
                          });
                    },
                  )
                : Container()
      ],
    );
  }
}
