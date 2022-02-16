import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

Position? position;
List<Placemark>? placeMarks;
String completeAddress = "";

String perParcelDeliveryAmount = "";

String previousEarnings = ""; //this is previous seller earnings

String previousRiderEarnings = ""; // this is previous rider earnings
