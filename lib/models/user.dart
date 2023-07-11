//add at 02:21
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final String category;
  final List followers;
  final List following;
  final List<dynamic> price_service;
  final List<dynamic> required_details;
  final List<dynamic> time_delivery;
  final List<dynamic> user_behavior;
  final double user_rate;

  const User({
    required this.username,
    required this.uid,
    required this.photoUrl,
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
    required this.price_service,
    required this.required_details,
    required this.time_delivery,
    required this.user_behavior,
    required this.user_rate,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
        "price_service": price_service,
        "required_details": required_details,
        "time_delivery": time_delivery,
        "user_behavior": user_behavior,
        "user_rate": user_rate,
        "category": category,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      bio: snapshot["bio"],
      followers: snapshot["followers"],
      following: snapshot["following"],
      price_service: snapshot["price_service"],
      required_details: snapshot["required_details"],
      time_delivery: snapshot["time_delivery"],
      user_behavior: snapshot["user_behavior"],
      user_rate: snapshot["user_rate"],
      category: snapshot["category"],
    ); //add at 02:39
  }
}
