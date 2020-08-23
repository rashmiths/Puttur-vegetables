import 'package:flutter/material.dart';
import 'package:puttur_vegetables/providers/ProductType.dart';
import 'package:puttur_vegetables/screens/ListOfItemsScreen.dart';

class VegetableTypeItem extends StatelessWidget {
  //final String kannadaTitle;
  final ProductType productType;
  const VegetableTypeItem(this.productType, {Key key}) : super(key: key);

  void SelectMeal(BuildContext context, String type, String title) {
    print(type);
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return ListOfItemsScreen(type, title);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => SelectMeal(context, productType.id, productType.title),
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
                    productType.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    bottom: 20,
                    //right: 5,
                    child: Container(
                        color: Colors.black54,
                        //width: 250,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                        child: Text(
                          productType.title,
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
      ),
    );
  }
}
