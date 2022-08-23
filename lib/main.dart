import 'package:ecom_user_batch06/page/cart_page.dart';
import 'package:ecom_user_batch06/page/checkout_page.dart';
import 'package:ecom_user_batch06/page/launcher_page.dart';
import 'package:ecom_user_batch06/page/phone_verification_page.dart';
import 'package:ecom_user_batch06/page/registration_page.dart';
import 'package:ecom_user_batch06/page/user_address_page.dart';
import 'package:ecom_user_batch06/providers/cart_provider.dart';
import 'package:ecom_user_batch06/providers/product_provider.dart';
import 'package:ecom_user_batch06/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'page/login_page.dart';
import 'page/order_page.dart';
import 'page/product_details_page.dart';
import 'page/product_page.dart';
import 'providers/order_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => OrderProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (_) => const LauncherPage(),
        LoginPage.routeName: (_) => const LoginPage(),
        ProductPage.routeName: (_) => ProductPage(),
        ProductDetailsPage.routeName: (_) => ProductDetailsPage(),
        OrderPage.routeName: (_) => const OrderPage(),
        CartPage.routeName: (_) => CartPage(),
        PhoneVerificationPage.routeName: (_) => PhoneVerificationPage(),
        UserAddressPage.routeName: (_) => UserAddressPage(),
        CheckoutPage.routeName: (_) => CheckoutPage(),
        RegistrationPage.routeName: (_) => RegistrationPage(),
      },
    );
  }
}
