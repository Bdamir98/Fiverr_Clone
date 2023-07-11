import 'package:cloud_firestore/cloud_firestore.dart';

//add at 03:25
class Post {
  final String description;
  final String data1;
  final String data2;
  final String data3;
  final String data4;
  final String data5;
  final String uid;
  final String username;
  //final likes;
  final String postId;
  final DateTime datePublished;
  final List<String> postUrl;
  final String profImage;

  const Post({
    required this.description,
    required this.data1,
    required this.data2,
    required this.data3,
    required this.data4,
    required this.data5,
    required this.uid,
    required this.username,
    //required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
  });

  static Post fromSnap(DocumentSnapshot snap) { var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        description: snapshot["description"],
        data1: snapshot["data1"],
        data2: snapshot["data2"],
        data3: snapshot["data3"],
        data4: snapshot["data4"],
        data5: snapshot["data5"],
        uid: snapshot["uid"],
        //likes: snapshot["likes"],
        postId: snapshot["postId"],
        datePublished: snapshot["datePublished"],
        username: snapshot["username"],
        postUrl: snapshot['postUrl'],
        profImage: snapshot['profImage']);
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "data1": data1,
        "data2": data2,
        "data3": data3,
        "data4": data4,
        "data5": data5,
        "uid": uid,
        //"likes": likes,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'profImage': profImage
      };
}
