  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:hive/hive.dart';
  import 'package:path_provider/path_provider.dart';
  import 'package:provider/provider.dart';
  import 'package:puttur_vegetables/providers/ProductType.dart';
  import 'package:puttur_vegetables/providers/ProductTypes.dart';
  import 'package:puttur_vegetables/providers/Products.dart';
  import 'package:puttur_vegetables/providers/cart.dart';
  import 'package:puttur_vegetables/screens/splashScreen.dart';
  import 'package:puttur_vegetables/screens/vegetableTypes_overviewscreen.dart';
  
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(CartItemAdapter());
  
    await Hive.openBox('cart');
  
    runApp(MyApp());
  }
  
  class MyApp extends StatelessWidget {
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProductTypes([])),
          ChangeNotifierProvider(create: (_) => Products([])),
          ChangeNotifierProvider(create: (_) => Cart()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Puttur Vegetables',
            theme: ThemeData(
              primarySwatch: Colors.grey,
              //accentColor: Colors.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: SplashScreen()
            // VegetableTypesOverViewScreen(
            //   load: true,
            // ),
            ),
      );
    }
  }
