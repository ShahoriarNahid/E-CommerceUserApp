import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_user_batch06/auth/auth_service.dart';
import 'package:ecom_user_batch06/models/user_model.dart';
import 'package:ecom_user_batch06/providers/cart_provider.dart';
import 'package:ecom_user_batch06/providers/order_provider.dart';
import 'package:ecom_user_batch06/providers/user_provider.dart';
import 'package:ecom_user_batch06/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'user_address_page.dart';

class CheckoutPage extends StatefulWidget {
  static const String routeName = '/checkout';

  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late CartProvider cartProvider;
  late OrderProvider orderProvider;
  late UserProvider userProvider;
  @override
  void didChangeDependencies() {
    cartProvider = Provider.of<CartProvider>(context);
    orderProvider = Provider.of<OrderProvider>(context);
    userProvider = Provider.of<UserProvider>(context);
    orderProvider.getOrderConstants();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                Text('Product Info', style: Theme.of(context).textTheme.headline6,),
                const SizedBox(height: 10,),
                Card(
                  elevation: 5,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: cartProvider.cartList.map((cartM) =>
                        ListTile(
                          title: Text(cartM.productName!),
                          trailing: Text('${cartM.quantity}x$currencySymbol${cartM.salePrice}'),
                        )).toList(),
                  ),
                ),
                const SizedBox(height: 10,),
                Text('Payment Info', style: Theme.of(context).textTheme.headline6,),
                const SizedBox(height: 10,),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Subtotal'),
                            Text('$currencySymbol${cartProvider.getCartSubTotal()}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Delivery Charge'),
                            Text('$currencySymbol${orderProvider.orderConstantsModel.deliveryCharge}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Discount(${orderProvider.orderConstantsModel.discount}%)'),
                            Text('-$currencySymbol${orderProvider.getDiscountAmount(cartProvider.getCartSubTotal())}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('VAT(${orderProvider.orderConstantsModel.vat}%)'),
                            Text('$currencySymbol${orderProvider.getVatAmount(cartProvider.getCartSubTotal())}'),
                          ],
                        ),
                        const Divider(height: 1.5, color: Colors.black,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Grand Total'),
                            Text('$currencySymbol${orderProvider.getGrandTotal(cartProvider.getCartSubTotal())}', style: Theme.of(context).textTheme.headline6,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text('Delivery Address', style: Theme.of(context).textTheme.headline6,),
                const SizedBox(height: 10,),
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: userProvider.getUserByUid(AuthService.user!.uid),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      final userM = UserModel.fromMap(snapshot.data!.data()!);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(userM.address == null ? 'No address set yet' :
                          '${userM.address!.streetAddress} \n'
                              '${userM.address!.area}, ${userM.address!.city}\n'
                              '${userM.address!.zipCode}'),
                          ElevatedButton(
                            onPressed: () => Navigator.pushNamed(context, UserAddressPage.routeName),
                            child: const Text('Change'),
                          ),
                        ],
                      );
                    }
                    if(snapshot.hasError) {
                      return const Text('Failed to fetch user data');
                    }
                    return const Text('Fetching user data...');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
