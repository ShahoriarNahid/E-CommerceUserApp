import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_user_batch06/models/product_model.dart';
import '../models/cart_model.dart';
import '../models/user_model.dart';

class DbHelper {
  static const String collectionCategory = 'Categories';
  static const String collectionProduct = 'Products';
  static const String collectionUser = 'Users';
  static const String collectionCart = 'Cart';
  static const String collectionCities = 'Cities';
  static const String collectionOrderSettings = 'Settings';
  static const String documentOrderConstant = 'OrderConstant';
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addUser(UserModel userModel) =>
      _db.collection(collectionUser).doc(userModel.uid)
          .set(userModel.toMap());

  static Future<void> addToCart(CartModel cartModel, String uid) =>
      _db.collection(collectionUser).doc(uid)
          .collection(collectionCart)
          .doc(cartModel.productId)
          .set(cartModel.toMap());

  static Future<void> removeFromCart(String pid, String uid) =>
      _db.collection(collectionUser).doc(uid)
          .collection(collectionCart)
          .doc(pid)
          .delete();

  static Future<void> updateCartQuantity(String uid, String pid, num quantity) =>
      _db.collection(collectionUser).doc(uid)
          .collection(collectionCart)
          .doc(pid)
          .update({cartProductQuantity : quantity});

  static Future<bool> doesUserExist(String uid) async {
    final snapshot = await _db.collection(collectionUser)
        .doc(uid).get();
    return snapshot.exists;
  }


  static Stream<DocumentSnapshot<Map<String, dynamic>>> getOrderConstants() =>
      _db.collection(collectionOrderSettings).doc(documentOrderConstant)
          .snapshots();

  static Future<DocumentSnapshot<Map<String, dynamic>>> getOrderConstants2() =>
      _db.collection(collectionOrderSettings).doc(documentOrderConstant)
          .get();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() =>
      _db.collection(collectionCategory).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCities() =>
      _db.collection(collectionCities).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(collectionProduct).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCartByUser(String uid) =>
      _db.collection(collectionUser)
          .doc(uid)
          .collection(collectionCart)
          .snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProductsByCategory(String category) =>
      _db.collection(collectionProduct).where(productCategory, isEqualTo: category).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllFeaturedProducts() =>
      _db.collection(collectionProduct).where(productFeatured, isEqualTo: true).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getProductById(String id) =>
      _db.collection(collectionProduct).doc(id).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserByUid(String uid) =>
      _db.collection(collectionUser).doc(uid).snapshots();

  static Future<void> updateProfile(String uid, Map<String, dynamic> map) {
    return _db.collection(collectionUser).doc(uid).update(map);
  }

}