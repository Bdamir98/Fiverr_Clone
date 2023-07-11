import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

declineShowAlertDialog<bool>(
  BuildContext context,
  String postId,
  String roomId,
  VoidCallback callback,
) async {
  double rating1 = 3;
  double rating2 = 3;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Give Your Feedback'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Behavior'),
            RatingBar.builder(
              initialRating: rating1,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                rating1 = rating;
              },
            ),
            SizedBox(height: 20),
            Text('Price Of Service'),
            RatingBar.builder(
              initialRating: rating2,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                rating2 = rating;
              },
            ),
            SizedBox(height: 20),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              FirebaseFirestore firestore = FirebaseFirestore.instance;

              firestore.collection('Chats').doc(roomId).update({
                'status': 'decline',
              }).catchError((error) {
                print('Error updating status: $error');
              });

              try {
                QuerySnapshot snapshot = await firestore
                    .collection('Chats')
                    .where('post_id', isEqualTo: postId)
                    .get();

                if (snapshot.docs.isNotEmpty) {
                  String senderId = (snapshot.docs[0].data()
                      as Map<String, dynamic>)['sender'];

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(senderId)
                      .update({
                    'user_behavior': FieldValue.arrayUnion([rating1]),
                    'price_service': FieldValue.arrayUnion([rating2]),
                  });

                  callback();
                } else {
                  print('No document found with the post ID: $postId');
                }
              } catch (e) {
                print('Error: $e');
              }
              Navigator.of(context).pop();
            },
            child: Text('Submit'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}
