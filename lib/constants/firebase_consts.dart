import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? user = auth.currentUser;


//collections
const String usersCollection = 'users';
const productsCollection = "products";
const categoryCollection = "category";
const cartCollection = "cart";
const wishlistCollection = "wishlist";
const ordersCollection = "orders";
const reviewsCollection = "reviews";
const addressCollection = "address";
const bannersCollection = "banners";
